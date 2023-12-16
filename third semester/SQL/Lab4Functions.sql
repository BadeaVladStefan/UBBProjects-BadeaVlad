use [Moto GP]

--------------------- insert into tables ---------------------

DROP PROCEDURE IF EXISTS insertIntoTables;
GO
-- inserts a new table name into the "Tables" table, provided that the table name does not already exist.
CREATE PROCEDURE insertIntoTables (@tableName VARCHAR(60)) AS
BEGIN
	IF @tableName IN (SELECT Name FROM Tables)
	BEGIN
		PRINT 'Table already in Tables!'
		RETURN
	END

	INSERT INTO Tables (Name)
	VALUES (@tableName);
END
GO


--------------------- insert into views ---------------------

DROP PROCEDURE IF EXISTS insertIntoViews;
GO
-- inserts a new view name into the "Views" table, provided that the view name does not already exist.
CREATE PROCEDURE insertIntoViews (@viewName VARCHAR(70)) AS
BEGIN
	IF @viewName IN (SELECT Name FROM Views)
	BEGIN
		PRINT 'View already in Views!'
		RETURN
	END

	INSERT INTO Views (Name)
	VALUES (@viewName)

END
GO

--------------------- insert into tests ---------------------

DROP PROCEDURE IF EXISTS insertIntoTests;
GO
-- inserts a new test name into the "Tests" table, provided that the test name does not already exist.
CREATE PROCEDURE insertIntoTests (@testName VARCHAR(70), @testID INT) AS
BEGIN
	
	IF @testName IN (SELECT Name FROM Tests)
	BEGIN
		PRINT 'Test already in Tests!'
		RETURN
	END

	INSERT INTO Tests (Name)
	VALUES (@testName)
END
GO

--------------------- connect table to test ---------------------

DROP PROCEDURE IF EXISTS connectTableToTest;
GO
--insert a new record into the TestTables table, establishing a connection between a specific test and a table.
CREATE PROCEDURE connectTableToTest (@tableName VARCHAR(70), @testName VARCHAR(70), @nb_of_rows INT, @position INT) AS
BEGIN
	INSERT INTO TestTables (TestID, TableID, NoOfRows, Position)
	VALUES (
		(SELECT TestID FROM Tests WHERE Name = @testName),
		(SELECT TableID FROM Tables WHERE Name = @tableName),
		@nb_of_rows,
		@position
	)

END
GO
	


--------------------- connect view to test ---------------------

DROP PROCEDURE IF EXISTS connectViewToTest;
GO
--insert a new record into the TestViews table, establishing a connection between a specific test and a view
CREATE PROCEDURE connectViewToTest (@viewName VARCHAR(70), @testName VARCHAR(70)) AS
BEGIN
	INSERT INTO TestViews (TestID, ViewID)
	VALUES (
		(SELECT TestID FROM Tests WHERE Name = @testName),
		(SELECT ViewID FROM Views WHERE Name = @viewName)
	)
END
GO


--------------------- generate random string ---------------------

DROP PROCEDURE IF EXISTS generateRandomString;
GO
--It generates a random string of variable length (between 5 and 25 characters) by concatenating random lowercase letters.
CREATE PROCEDURE generateRandomString (@string VARCHAR(21) OUTPUT) AS
BEGIN
	DECLARE @counter INT = 0;
	DECLARE @limit INT = 5 + RAND() * 20;

	SET @string = '';

	WHILE (@counter < @limit)
	BEGIN
		SET @string = @string + CHAR((RAND() * 25 + 97));
		SET @counter = @counter + 1;
	END
END
GO

--------------------- generate random int ---------------------

DROP PROCEDURE IF EXISTS generateRandomInt;
GO
-- takes @lowLimit and @maxLimit as input parameters and generates a random integer within that range, storing the result in the output parameter @integer
CREATE PROCEDURE generateRandomInt (@lowLimit INT, @maxLimit INT, @integer INT OUTPUT) AS
BEGIN
	SET @integer = @lowLimit + RAND() * @maxLimit;
END
GO


--------------------- foreign keys retrieval ---------------------

DROP PROCEDURE IF EXISTS getReferenceData;
GO
-- identifies the referenced table and column for a given table and column by querying the database's foreign key
--The results are stored in the output parameters @referencedTable and @referencedColumn
CREATE PROCEDURE getReferenceData (@table VARCHAR(128), @column VARCHAR(128), @referencedTable VARCHAR(128) OUTPUT, @referencedColumn VARCHAR(128) OUTPUT)
AS
BEGIN
	SELECT @referencedTable = OBJECT_NAME(FC.referenced_object_id), @referencedColumn = COL_NAME(FC.referenced_object_id, FC.referenced_column_id)
	FROM sys.foreign_keys AS F INNER JOIN sys.foreign_key_columns AS FC ON F.OBJECT_ID = FC.constraint_object_id
	WHERE OBJECT_NAME (F.parent_object_id) = @table AND COL_NAME(FC.parent_object_id, FC.parent_column_id) = @column
END
GO


--------------------- primary key retrieval ---------------------

DROP FUNCTION IF EXISTS isPrimaryKey;
GO
--checks if a specified column in a given table is part of the primary key. It returns 1 if the column is a primary key, and 0 otherwise.
--The function utilizes the INFORMATION_SCHEMA views to query the database for primary key constraints associated with the specified table and column.
--The result is determined based on the count of matching primary key constraints.

CREATE FUNCTION isPrimaryKey (@table VARCHAR(128), @column VARCHAR(128))
RETURNS INT
AS
BEGIN
	DECLARE @counter INT = 0
	SET @counter = (
		SELECT count(*)
		FROM     INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS C
			JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE  AS K ON C.TABLE_NAME = K.TABLE_NAME
																 AND C.CONSTRAINT_CATALOG = K.CONSTRAINT_CATALOG
																 AND C.CONSTRAINT_SCHEMA = K.CONSTRAINT_SCHEMA
																 AND C.CONSTRAINT_NAME = K.CONSTRAINT_NAME
		WHERE   C.CONSTRAINT_TYPE = 'PRIMARY KEY'
				AND K.COLUMN_NAME = @column
				AND C.TABLE_NAME = @table
		)

	IF @counter = 0 BEGIN
		RETURN 0
	END

	RETURN 1
END
GO

--------------------- insert a row of data in a given table ---------------------

DROP PROCEDURE IF EXISTS insertRow;
GO

CREATE PROCEDURE insertRow (@tableName VARCHAR(70)) AS
BEGIN
	--retrieve column names and data types for the specified table.
	DECLARE @getColumnsQuery NVARCHAR(MAX) = N' 
		SELECT COLUMN_NAME, DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = ''' + @tableName + '''
	';

	--Defines the initial part of the dynamic SQL query for the insert operation.
	DECLARE @insertQuery NVARCHAR(MAX) = N'INSERT INTO ' + @tableName;

	--store column names and data types obtained from the dynamic query.
	--Stores the number of columns in the specified table.
	DECLARE @columns NVARCHAR(MAX);
	DECLARE @types NVARCHAR(MAX);
	DECLARE @rowsNumber INT = 0;

	-- we use a cursor to extract all columns from the table and their types
	--It opens the cursor and fetches the first row into @columnName and @dataType.
	--If the fetch is successful (@@FETCH_STATUS = 0), it sets initial values for @columns, @types, and @rowsNumber.
	--WHILE loop that continues fetching rows from columnsCursor as long as @@FETCH_STATUS is 0 (indicating successful fetch).
	--Inside the loop, it fetches the next row into @columnName and @dataType.
	--If the fetch is successful, it concatenates the column names (@columns) and data types (@types), and increments the @rowsNumber.
	--After the loop, it closes and deallocates the cursor.
	DECLARE @cursorQuery NVARCHAR(MAX) = N'
		DECLARE @columnName NVARCHAR(MAX);
		DECLARE @dataType NVARCHAR(MAX);
		DECLARE columnsCursor CURSOR FOR ' + @getColumnsQuery + '
		OPEN columnsCursor
		FETCH columnsCursor
		INTO @columnName, @dataType;

		IF @@FETCH_STATUS = 0
		BEGIN
			SET @columns = @columnName;
			SET @types = @dataType;
			SET @rowsNumber = 1;
		END

		WHILE @@FETCH_STATUS = 0
		BEGIN
			FETCH columnsCursor
			INTO @columnName, @dataType;
			IF @@FETCH_STATUS = 0
			BEGIN
				SET @columns = @columns + '', '' + @columnName;
				SET @types = @types + '', '' + @dataType;
				SET @rowsNumber = @rowsNumber + 1;
			END
		END

		CLOSE columnsCursor;
		DEALLOCATE columnsCursor;	
	';

	EXEC sp_executesql @Query = @cursorQuery, @Params = N'@columns NVARCHAR(MAX) OUTPUT, @types NVARCHAR(MAX) OUTPUT, @rowsNumber INT OUTPUT', @columns = @columns OUTPUT, @types = @types OUTPUT, @rowsNumber = @rowsNumber OUTPUT;

	SET @insertQuery = @insertQuery + '(' + @columns + ') VALUES (';

	SET @types = @types + ', ';
	SET @columns = @columns + ', ';

	DECLARE @index INT = 0;
	DECLARE @current NVARCHAR(MAX);
	DECLARE @currentColumn NVARCHAR(MAX);
	DECLARE @pkConstraint INT = 0;
	DECLARE @outputPK INT;
	DECLARE @pkQuery NVARCHAR(MAX)

	-- now we insert random data on every column
	WHILE @index < @rowsNumber
	BEGIN
		SET @current = LEFT(@types, CHARINDEX(', ', @types) - 1);
		SET @types = SUBSTRING(@types, CHARINDEX(', ', @types) + 2, LEN(@types));
		SET @currentColumn = LEFT(@columns, CHARINDEX(', ', @columns) - 1);
		SET @columns = SUBSTRING(@columns, CHARINDEX(', ', @columns) + 2, LEN(@columns));

		IF @index != 0
			SET @insertQuery = @insertQuery + ', ';

		DECLARE @referencedTable NVARCHAR(MAX) = '';
		DECLARE @referencedColumn NVARCHAR(MAX) = '';
		
		-- here we check if the current column has a foreign key 
		EXEC getReferenceData @tableName, @currentColumn, @referencedTable = @referencedTable OUTPUT, @referencedColumn = @referencedColumn OUTPUT;
	
		-- here we check if the current column has a primary key
		SET @pkConstraint = dbo.isPrimaryKey(@tableName, @currentColumn);
		--PRINT @pkConstraint;

		-- case 1: we must insert a integer
		IF @current = 'INT'
		BEGIN
			-- case 1.1: it's a foreign key => we must search in the refferenced table
			IF @referencedTable != '' AND @referencedColumn != ''
			BEGIN
				DECLARE @intValue INT;
				DECLARE @intQuery NVARCHAR(MAX) = N'
					SELECT @intValue = ' + @referencedColumn + ' FROM ' + @referencedTable;
				--PRINT @intQuery
				EXEC sp_executesql @Query = @intQuery, @Params = N'@intValue INT OUTPUT', @intValue = @intValue OUTPUT;
				SET @insertQuery = @insertQuery + CONVERT(NVARCHAR(MAX), @intValue);
			END
			ELSE
			BEGIN
				DECLARE @integer INT;
				-- case 1.2: it's a primary key => we generate a random value and we must check if the value doesn't already exist
				IF @pkConstraint = 1
				BEGIN
					EXEC generateRandomInt 0, 1000, @integer = @integer OUTPUT;
					SET @pkQuery = N'SELECT @outputPK = COUNT (*) FROM ' + @tableName + ' WHERE '	+ @currentColumn + '=' + CONVERT(NVARCHAR(MAX), @integer);
					EXEC sp_executesql @pkQuery, N'@outputPK INT OUTPUT', @outputPK OUTPUT
					PRINT @outputPK
					IF @outputPK != NULL
					BEGIN
						WHILE @outputPK != NULL 
						BEGIN
							SET @pkQuery = N'SELECT @outputPK = COUNT (*) FROM ' + @tableName + ' WHERE '	+ @currentColumn + '=' + CONVERT(NVARCHAR(MAX), @integer);
							EXEC sp_executesql @pkQuery, N'@outputPK INT OUTPUT', @outputPK OUTPUT
						END
					END
					SET @insertQuery = @insertQuery + CONVERT(NVARCHAR(MAX), @integer);
				END
				-- case 1.3: it's not a foreign key or a primary key => we insert a random value
				ELSE
				BEGIN
					EXEC generateRandomInt 0, 1000, @integer = @integer OUTPUT;
					SET @insertQuery = @insertQuery + CONVERT(NVARCHAR(MAX), @integer);
				END

			END
		END

		-- case 2: we must insert a string
		IF @current = 'VARCHAR'
		BEGIN
			-- case 2.1: it's a foreign key => we must search in the refferenced table
			IF @referencedTable != '' AND @referencedColumn != ''
			BEGIN
				DECLARE @stringValue NVARCHAR(MAX);
				DECLARE @stringQuery NVARCHAR(MAX) = N'
					SELECT @stringValue = ' + @referencedColumn + ' FROM ' + @referencedTable;
				EXEC sp_executesql @Query = @stringQuery, @Params = N'@stringValue INT OUTPUT', @stringValue = @stringValue OUTPUT;
				SET @insertQuery = @insertQuery + CONVERT(NVARCHAR(MAX), @stringValue);
			END
			ELSE 
			BEGIN
				DECLARE @string NVARCHAR(21);
				-- case 2.2: it's a primary key => we generate a random value and we must check if the value doesn't already exist
				IF @pkConstraint = 1
				BEGIN
					EXEC generateRandomString @string = @string OUTPUT;
					SET @pkQuery = N'SELECT @outputPK = COUNT (*) FROM ' + @tableName + ' WHERE '	+ @currentColumn + '=' + @string;
					EXEC sp_executesql @pkQuery, N'@outputPK VARCHAR OUTPUT', @outputPK OUTPUT;
					PRINT @outputPK;
					IF @outputPK != NULL
					BEGIN
						WHILE @outputPK != NULL 
						BEGIN
							SET @pkQuery = N'SELECT @outputPK = COUNT (*) FROM ' + @tableName + ' WHERE '	+ @currentColumn + '=' + @string;
							EXEC sp_executesql @pkQuery, N'@outputPK VARCHAR OUTPUT', @outputPK OUTPUT;
						END
					END
					SET @insertQuery = @insertQuery + '''' + @string + '''';
				END
				-- case 2.3: it's not a foreign key or a primary key => we insert a random value
				ELSE
				BEGIN
					EXEC generateRandomString @string = @string OUTPUT;
					SET @insertQuery = @insertQuery + '''' + @string + '''';
				END
			END
		END

		SET @index = @index + 1;
	END

	SET @insertQuery = @insertQuery + ');';
	PRINT @insertQuery;
	EXEC sp_executesql @insertQuery;
END
GO


--------------------- insert multiple rows of data in a given table ---------------------

DROP PROCEDURE IF EXISTS insertMultipleRows;
GO
--insert multiple rows into a specified table (@tableName)
CREATE PROCEDURE insertMultipleRows (@tableName VARCHAR(70), @nb INT) AS
BEGIN
	WHILE @nb > 0
	BEGIN
		DECLARE @error INT = 1;
		WHILE @error != 0
		BEGIN
			SET @error = 0;
			BEGIN TRY
				EXEC insertRow @tableName;
			END TRY
			BEGIN CATCH
				SET @error = 1;
			END CATCH
		END

		SET @nb = @nb - 1;
	END
END 
GO


--------------------- run test procedure ---------------------

DROP PROCEDURE IF EXISTS runTest;
GO

CREATE PROCEDURE runTest (@testID INT) AS
BEGIN
	DECLARE @tests INT = 0;
	DECLARE @tableID INT = -1;
	DECLARE @viewID INT = -1;
	DECLARE @rowsNb INT = -1;
	DECLARE @runID INT = -1;
	DECLARE @testStart DATETIME = GETDATE();

	INSERT INTO TestRuns (Description, StartAt)
	VALUES ((SELECT Name FROM Tests WHERE TestID = @testID), @testStart);

	SELECT @runID = TestRunID FROM TestRuns 
	WHERE Description = (SELECT Name FROM Tests WHERE TestID = @testID) AND StartAt = @testStart;

	SELECT @tests = COUNT(*) FROM Tests
	WHERE TestID = @testID;

	IF @testID < 0
	BEGIN
		RAISERROR('Invalid test ID!', 10, 1);
		RETURN
	END

	-- run test for tables --

	DECLARE @tableName NVARCHAR(MAX);
	DECLARE @query NVARCHAR(MAX);

	-- first we delete data from the tables --

	DECLARE testCursor CURSOR FOR
	SELECT TableID FROM TestTables
	WHERE TestID = @testID
	ORDER BY Position DESC;

	OPEN testCursor
	FETCH testCursor
	INTO @tableId;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @tableName = Name FROM Tables
		WHERE TableID = @tableID;

		SET @query = N'DELETE FROM ' + @tableName;
		EXEC sp_executesql @query;

		FETCH testCursor
		INTO @tableId;
	END

	CLOSE testCursor
	DEALLOCATE testCursor

	-- now we insert data to tables --
	
	DECLARE testCursor CURSOR FOR
	SELECT TableID, NoOfRows FROM TestTables
	WHERE TestID = @testID
	ORDER BY Position;

	OPEN testCursor
	FETCH testCursor
	INTO @tableId, @rowsNb;

	DECLARE @startInsert DATETIME;
	DECLARE @endInsert DATETIME;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @tableName = Name FROM Tables
		WHERE TableID = @tableID;

		SET @startInsert = GETDATE();
		EXEC insertMultipleRows @tableName, @rowsNb;
		SET @endInsert = GETDATE();

		INSERT INTO TestRunTables (TestRunID, TableID, StartAt, EndAt)
		VALUES (@runID, @tableID, @startInsert, @endInsert)

		FETCH testCursor
		INTO @tableID, @rowsNb;
	END

	CLOSE testCursor
	DEALLOCATE testCursor

	-- run test for views --

	DECLARE @viewName NVARCHAR(MAX);

	DECLARE testCursor CURSOR FOR
	SELECT ViewID FROM TestViews
	WHERE TestID = @testID

	OPEN testCursor
	FETCH testCursor 
	INTO @viewID;

	DECLARE @startView DATETIME;
	DECLARE @endView DATETIME;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @viewName = Name FROM Views
		WHERE ViewID = @viewID;

		SET @query = 'SELECT * FROM ' + @viewName;

		SET @startView = GETDATE();
		EXEC sp_executesql @query;
		SET @endView = GETDATE();

		INSERT INTO TestRunViews (TestRunID, ViewID, StartAt, EndAt)
		VALUES (@runID, @viewID, @startView, @endView);

		FETCH testCursor
		INTO @viewID;
	END

	CLOSE testCursor;
	DEALLOCATE testCursor;

	-- set TestRuns table data --
	UPDATE TestRuns
	SET EndAt = GETDATE()
	WHERE Description = (SELECT Name FROM Tests WHERE TestID = @testID) AND StartAt = @testStart;

END 
GO
--------------------- views ---------------------

-- a view with a SELECT statement operating on one table


DROP VIEW CurrentYearPointsUnder50View
GO
--view selects all columns from the CurrentYearDriverStandings table where the value in the Points column is less than 50.
CREATE OR ALTER VIEW CurrentYearPointsUnder50View
AS
	SELECT * FROM CurrentYearDriverStandings
	where Points < 50
GO

-- a view with a SELECT statement that operates on at least 2 different tables and contains at least one JOIN operator
DROP VIEW ManufacturersView
GO
--selects the ManufacturerName from the Manufacturers table for manufacturers associated with teams and riders through the specified joins.
CREATE OR ALTER VIEW ManufacturersView
AS
	SELECT M.ManufacturerName FROM Manufacturers M
	INNER JOIN Teams T ON T.BikeManufacturerId = M.ManufacturerId
	INNER JOIN Riders R ON R.TeamId = T.TeamId
GO

-- a view with a SELECT statement that has a GROUP BY clause, operates on at least 2 different tables and contains at least 
-- one JOIN operator

-- display the team ID, team name, manufacturer ID, manufacturer name, and the count of riders associated with each team. It pulls data from
-- the Moto2Teams, Moto2Drivers, and Moto2Manufacturers
CREATE VIEW Moto2View AS
    SELECT t.TeamID, t.TeamName, m.ManufacturerID, m.ManufacturerName, COUNT(d.RiderID) AS RiderCount
    FROM Moto2Teams t
    INNER JOIN Moto2Drivers d ON t.TeamID = d.TeamID
    INNER JOIN Moto2Manufacturers m ON d.ManufacturerID = m.ManufacturerID
    GROUP BY t.TeamID, t.TeamName, m.ManufacturerID, m.ManufacturerName;
GO

--------------------- TEST 1 ---------------------
--a table with a single-column primary key and no foreign keys : PreviousDriverChampions

EXEC insertIntoViews 'CurrentYearPointsUnder50View'
EXEC insertIntoTests 'test1', 1
EXEC insertIntoTables 'CurrentYearDriverStandings'
EXEC connectTablesToTest 'CurrentYearDriverStandings', 'test1', 500, 1
EXEC connectViewToTest 'CurrentYearPointsUnder50View', 'test1'

--------------------- TEST 2 ---------------------
--a table with a single-column primary key and at least one foreign key 

EXEC insertIntoViews 'ManufacturersView'
EXEC insertIntoTests 'test2', 2
EXEC insertIntoTables 'Manufacturers'
EXEC connectTablesToTest 'Manufacturers', 'test2', 500, 1
EXEC insertIntoTables 'Teams'
EXEC connectTablesToTest 'Teams', 'test2', 500, 2
EXEC insertIntoTables 'Riders'
EXEC connectTablesToTest 'Riders', 'test2', 500,3
EXEC connectViewToTest 'ManufacturersView', 'test2'


--------------------- TEST 3 ---------------------
--a table with a multicolumn primary key 
EXEC insertIntoViews 'Moto2View'
EXEC insertIntoTests 'test3', 3
EXEC insertIntoTables 'Moto2Teams'
EXEC connectTablesToTest 'Moto2Teams', 'test3', 500, 1
EXEC insertIntoTables 'Moto2Manufacturers'
EXEC connectTablesToTest 'Moto2Manufacturers', 'test3', 500, 2
EXEC insertIntoTables 'Moto2Drivers'
EXEC connectTablesToTest 'Moto2Drivers', 'test3', 500, 3
EXEC connectViewToTest 'Moto2View', 'test3'


exec runTest 1;
exec runTest 2;
exec runTest 3;

SELECT * FROM Tests
SELECT * FROM Tables
SELECT * FROM Views
SELECT * FROM TestTables
SELECT * FROM TestViews
SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews


SELECT * FROM Manufacturers
SELECT * FROM Teams
SELECT * FROM Riders
SELECT * FROM Moto2Drivers
SELECT * FROM Moto2Manufacturers
SELECT * FROM Moto2Teams

drop table Tests
drop table Tables
drop table views
drop table TestTables
drop table TestRunViews
drop table TestRuns
drop table TestRunTables
drop table TestViews





