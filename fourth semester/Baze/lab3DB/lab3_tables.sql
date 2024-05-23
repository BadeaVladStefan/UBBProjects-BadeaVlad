CREATE TABLE Formula1Team
(
    team_id INT PRIMARY KEY,
    name VARCHAR(MAX),
    country VARCHAR(MAX),
    team_principal VARCHAR(MAX)
);

CREATE TABLE Formula1Driver
(
    driver_id INT PRIMARY KEY,
    name VARCHAR(MAX),
    nationality VARCHAR(MAX)
);

CREATE TABLE Formula1TeamDriver
(
    team_id INT REFERENCES Formula1Team(team_id),
    driver_id INT REFERENCES Formula1Driver(driver_id),
    PRIMARY KEY (team_id, driver_id)
);


