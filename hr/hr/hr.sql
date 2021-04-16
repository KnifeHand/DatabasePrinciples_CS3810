CREATE DATABASE hr;

USE hr;

CREATE TABLE Employees
(
    id   INT         NOT NULL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    sal  FLOAT       NOT NULL
    -- CHECK ( sal >= 50000 )
);

DELIMITER |
CREATE TRIGGER employees_sal_at_least_50K
    BEFORE INSERT
    ON Employees
    FOR EACH ROW
BEGIN
    IF NEW.sal < 50000 THEN
        SET NEW.sal = 50000;
    END IF;
END;
|
DELIMITER ;

INSERT INTO Employees
VALUES (1, 'Matt', 40001);

SELECT *
FROM hr.Employees;

