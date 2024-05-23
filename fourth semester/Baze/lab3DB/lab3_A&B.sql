CREATE OR ALTER PROCEDURE addRowFormula1Team (@name VARCHAR(100), @country VARCHAR(100), @teamPrincipal VARCHAR(100))
AS
BEGIN
    DECLARE @maxId INT
    SET @maxId = 0
    SELECT TOP 1 @maxId = team_id + 1 FROM Formula1Team ORDER BY team_id DESC

    IF (@name IS NULL)
    BEGIN
        RAISERROR('Formula 1 team name must not be null', 24, 1);
        RETURN;
    END

    IF (@country IS NULL)
    BEGIN
        RAISERROR('Formula 1 team country must not be null', 24, 1);
        RETURN;
    END

    INSERT INTO Formula1Team (team_id, name, country, team_principal)
    VALUES (@maxId, @name, @country, @teamPrincipal);

	DECLARE @errorMessage NVARCHAR(1000);
    SET @errorMessage = ERROR_MESSAGE();
    EXEC sp_log_changes null, @name, 'Added row to Formula 1 team', @errorMessage;
END;
GO

CREATE OR ALTER PROCEDURE addRowFormula1Driver (@name VARCHAR(100), @nationality VARCHAR(100))
AS
BEGIN
    DECLARE @maxId INT
    SET @maxId = 0
    SELECT TOP 1 @maxId = driver_id + 1 FROM Formula1Driver ORDER BY driver_id DESC

    IF (@name IS NULL)
    BEGIN
        RAISERROR('Formula 1 driver name must not be null', 24, 1);
        RETURN;
    END

    IF (@nationality IS NULL)
    BEGIN
        RAISERROR('Formula 1 driver nationality must not be null', 24, 1);
        RETURN;
    END

    INSERT INTO Formula1Driver (driver_id, name, nationality)
    VALUES (@maxId, @name, @nationality);

	DECLARE @errorMessage NVARCHAR(1000);
    SET @errorMessage = ERROR_MESSAGE();
    EXEC sp_log_changes null, @name, 'Added row to Formula 1 driver',@errorMessage;
END;
GO

GO
CREATE OR ALTER PROCEDURE addRowFormula1TeamDriver (@teamName VARCHAR(100), @driverName VARCHAR(100))
AS
BEGIN
    IF (@teamName IS NULL)
    BEGIN
        RAISERROR('Formula 1 team name must not be null', 24, 1);
        RETURN;
    END

    IF (@driverName IS NULL)
    BEGIN
        RAISERROR('Formula 1 driver name must not be null', 24, 1);
        RETURN;
    END

    DECLARE @teamId INT
    DECLARE @driverId INT

    SELECT @teamId = team_id FROM Formula1Team WHERE name = @teamName
    SELECT @driverId = driver_id FROM Formula1Driver WHERE name = @driverName

    IF (@teamId IS NULL)
    BEGIN
        RAISERROR('Formula 1 team does not exist', 24, 1);
        RETURN;
    END

    IF (@driverId IS NULL)
    BEGIN
        RAISERROR('Formula 1 driver does not exist', 24, 1);
        RETURN;
    END

    INSERT INTO Formula1TeamDriver (team_id, driver_id)
    VALUES (@teamId, @driverId);

    DECLARE @newData VARCHAR(200)
    SET @newData = @teamName + ' - ' + @driverName

	DECLARE @errorMessage NVARCHAR(1000);
    SET @errorMessage = ERROR_MESSAGE();
    EXEC sp_log_changes null, @newData, 'Connected Formula 1 team with driver',@errorMessage;
END;
GO


CREATE OR ALTER PROCEDURE rollbackScenarioNoFail
AS
BEGIN
    BEGIN TRAN
    BEGIN TRY
        EXEC addRowFormula1Team 'Team A', 'France', 'John Doe'
        EXEC addRowFormula1Driver 'Lewis Hamilton', 'British'
        EXEC addRowFormula1TeamDriver 'Team A', 'Lewis Hamilton'
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
        RETURN
    END CATCH
    COMMIT TRAN
END;
GO

CREATE OR ALTER PROCEDURE rollbackScenarioFail
AS
BEGIN
    BEGIN TRAN
    BEGIN TRY
        EXEC addRowFormula1Team 'Team A', 'France', 'John Doe'
        EXEC addRowFormula1Driver NULL, 'Unknown'
        EXEC addRowFormula1TeamDriver 'Team A', NULL
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
        RETURN
    END CATCH
    COMMIT TRAN
END;
GO

CREATE OR ALTER PROCEDURE noRollbackScenarioManyToManyNoFail
AS
    DECLARE @ERRORS INT
    SET @ERRORS = 0

    BEGIN TRY
        BEGIN TRANSACTION;
        EXEC addRowFormula1Team 'Team A', 'France', 'John Doe'
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @ERRORS = @ERRORS + 1
    END CATCH

    BEGIN TRY
        BEGIN TRANSACTION;
        EXEC addRowFormula1Driver 'Lewis Hamilton', 'British'
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @ERRORS = @ERRORS + 1
    END CATCH

    IF (@ERRORS = 0) BEGIN
        BEGIN TRY
            BEGIN TRANSACTION;
            EXEC addRowFormula1TeamDriver 'Team A', 'Lewis Hamilton'
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
        END CATCH
    END
GO


CREATE OR ALTER PROCEDURE noRollbackScenarioManyToManyFail
AS
    DECLARE @ERRORS INT
    SET @ERRORS = 0

    BEGIN TRY
        EXEC addRowFormula1Team 'Team A', 'France', 'John Doe'
    END TRY
    BEGIN CATCH
        SET @ERRORS = @ERRORS + 1
    END CATCH

    BEGIN TRY
        EXEC addRowFormula1Driver NULL, 'Kazakhstan'
    END TRY
    BEGIN CATCH
        SET @ERRORS = @ERRORS + 1
    END CATCH

    IF (@ERRORS = 0) BEGIN
        BEGIN TRY
			BEGIN TRANSACTION;
            EXEC addRowFormula1TeamDriver 'Team A', NULL
			COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
			ROLLBACK TRANSACTION;
        END CATCH
    END
GO

SELECT * FROM Formula1Team
SELECT * FROM Formula1Driver
SELECT * FROM Formula1TeamDriver

EXEC rollbackScenarioNoFail;
EXEC rollbackScenarioFail;
EXEC noRollbackScenarioManyToManyNoFail;
EXEC noRollbackScenarioManyToManyFail;

DELETE FROM Formula1Team
DELETE FROM Formula1Driver
DELETE FROM Formula1TeamDriver
