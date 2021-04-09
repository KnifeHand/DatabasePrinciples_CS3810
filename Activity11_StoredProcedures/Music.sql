-- In class Activity 11
-- Date: April 6, 2021

# Create the music database based on the following SQL schema:
CREATE DATABASE music;

USE music;

CREATE TABLE Albums
(
    id     INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title  VARCHAR(30) NOT NULL,
    artist VARCHAR(30) NOT NULL,
    year   INT         NOT NULL
);
CREATE TABLE Tracks
(
    id   INT         NOT NULL,
    num  INT         NOT NULL,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (id, num),
    FOREIGN KEY (id) REFERENCES Albums (id)
);

DELIMITER |
CREATE FUNCTION check_year(year INT) RETURNS INT
BEGIN
    DECLARE result INT;
    IF year >= 1950 THEN
        Set result = year;
    Else
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Year is invalid!!!';
    end if;
    RETURN (result);
end;
|
DELIMITER ;

# Create a function called check_year that accepts an integer and checks
# if the given value is >= 1950, returning the value if valid or raising
# an exception otherwise. Try to add the following albums in table Albums

-- try to insert an album that has an invalid year
INSERT INTO Albums (title, artist, year)
VALUES ('Roots', 'Sepultura', check_year(1925));
-- now insert the following two albums
INSERT INTO Albums (title, artist, year)
VALUES ('Roots', 'Sepultura', check_year(1996));
INSERT INTO Albums (title, artist, year)
VALUES ('Morbid Visions', 'Sepultura', check_year(1986));

# When testing the function, if you run into an error that says
# “DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and
# binary logging is enabled” you need to enable the
# following configuration setting:
SET GLOBAL log_bin_trust_function_creators = 1;

-- Insert the following rows in table Tracks:
INSERT INTO Tracks
VALUES (1, 1, 'Roots Bloody Roots');
INSERT INTO Tracks
VALUES (1, 2, 'Attitude');
INSERT INTO Tracks
VALUES (1, 3, 'Ratamahatta');
INSERT INTO Tracks
VALUES (2, 1, 'Morbid Visions');
INSERT INTO Tracks
VALUES (2, 2, 'Mayhem');

-- Create a procedure called number_albums that shows
-- the number of albums of a given artist. Call the procedure using:
CALL number_albums('Sepultura');

# Output should be:
# +--------+
# | albums |
# +--------+
# |      2 |
# +--------+
DELIMITER
|
CREATE PROCEDURE number_albums(IN artist VARCHAR(30))
BEGIN
    SELECT COUNT(*) FROM Albums WHERE Albums.artist = artist;
END;
|
DELIMITER ;

# Create a procedure called albums_number_tracks that shows the
# year, title and number of tracks of each album of a given artist
# sorted by year and title. Call the procedure using:
CALL albums_number_tracks('Sepultura');

# Output should be:
# +------+----------------+--------+
# | year | title          | tracks |
# +------+----------------+--------+
# | 1986 | Morbid Visions | 2      |
# | 1996 | Roots          | 3      |
# +------+----------------+--------+
DELIMITER |
CREATE PROCEDURE albums_number_tracks(IN artist VARCHAR(30))
BEGIN
    SELECT year, title, COUNT(*) AS tracks
    FROM Albums
             NATURAL JOIN Tracks
    WHERE Albums.artist = artist
    GROUP BY id;
END;
|
DELIMITER ;

# Stored Procedures
# This short tutorial illustrates how to make a stored procedure
# call from within a Java code.  It assumes that you have already
# ran Activity 11 (Links to an external site.) and have the music
# database created with tables Albums and Tracks.  This tutorial
# will show how to call stored procedure "albums_number_tracks"
# that shows the year, title and number of tracks of each album
# of a given artist sorted by year and title.

# Step 1: Create a User for Remote Database Access
# Named this user music and grant full access to the database to it.
# We will use '012345' as the password for this user.
CREATE USER 'music' IDENTIFIED BY '12345';
GRANT ALL ON TABLE * TO 'music';

# Step 2: Create a Properties File to Store Database Info
# Contents of config.properties:
# server=localhost
# user=music
# password=12345
# database=music
