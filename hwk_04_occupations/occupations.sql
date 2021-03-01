-- occupations database
-- created at: <02-23-2021>
-- author: <Matt Hurt>

CREATE DATABASE Occupations;

USE occupations;

DROP TABLE IF EXISTS Occupations;

-- TODO: create table Occupations
CREATE TABLE Occupations(
	code CHAR(10), 
	occupation VARCHAR(110), 
	job_family VARCHAR (1000)
);

-- TODO: populate table Occupations
LOAD DATA INFILE 'occupations.csv' 
	INTO TABLE Occupations FIELDS TERMINATED BY ','
	OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS(code, occupation, job_family);
    
-- TODO: a) the total number of occupations (expect 1016).
SELECT COUNT(occupation) AS 'TOTAL Occupations'
	FROM occupations;

-- TODO: b) a list of all job families in alphabetical order (expect 23).
SELECT DISTINCT job_family 
	FROM Occupations 
    ORDER BY job_family;

-- TODO: c) the total number of job families (expect 23)
SELECT DISTINCT count(DISTINCT job_family) FROM Occupations;

-- TODO: d) the total number of occupations per job family in alphabetical order of job family.
SELECT DISTINCT job_family,
COUNT(occupation) AS 'Occupations from job families'
FROM occupations
GROUP BY job_family
ORDER BY job_family ASC;
	
-- TODO: e) the number of occupations in the "Computer and Mathematical" job family (expect 38)
SELECT COUNT(occupations) 
FROM Occupations 
WHERE job_family = "Computer and Mathematical";

-- TODO: f) an alphabetical list of occupations in the "Computer and Mathematical" job family.
SELECT occupation 
FROM occupations 
WHERE job_family = "Computer and Mathematical" 
ORDER BY occupation ASC;

-- TODO: g) an alphabetical list of occupations in the "Computer and Mathematical" 
-- job family that begins with the word "Database"
SELECT occupation 
    FROM Occupations 
    WHERE (job_family = "Computer and Mathematical" 
    AND occupation LIKE "%Database%");
    
