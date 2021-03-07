-- flowers database
-- created at: <03/01/2021>
-- author(s): <Matt Hurt>

-- database creation and use
CREATE DATABASE Flowers;

USE Flowers;

DROP TABLE IF EXISTS Flowers;

-- tables creation satisfying all of the requirements
CREATE TABLE FlowerInfo(
	flower_id INTEGER PRIMARY KEY,
	common_name CHAR(30),
	latin_name CHAR(35),
	cool_zone CHAR(5),
	hot_zone CHAR(5),
	deliver INTEGER,
	sun_needs VARCHAR(5)
	);
	
-- FlowersInfo table population
INSERT INTO FlowerInfo (flower_id, common_name, latin_name, cool_zone, hot_zone, deliver, sun_needs)
VALUES
	(101, 'Lady Fern', 'Atbyrium filix-femina', '2','9', 5, 'SH'),
	(102, 'Pink Caladiums', 'C.x borulanum', '10','10', 6,'PtoSH'),
	(103, 'Lily-of-the-Valley', 'Convallaria majalis', '2', '8', 5, 'PtoSH'),
	(105, 'Purple Liatris', 'Liatris spicata','3','8', 6, 'Stop'),
	(106, 'Black Eyed Susan', 'Rubeckia fulgida var. specios','4','9', 2,'Stop'),
	(107, 'Nikko Blue Hydrangea', 'Hydrangea macrophylla', '5','10', 4, 'PtoSH'),
	(108, 'Variegated Weigela', 'W. florida Variegata', '4','9', 8,'StoP'),
	(110, 'Lombardy Popular', 'Populus nigra Italica', '3','9', 9, 'S'),
	(111, 'Purple Leaf Plum Hedge', 'Prunus x cistena', '2','9', 7,'S'),
	(114, 'Thorndale Ivy', 'Hedera belix Thorndale', '3','8', 1, 'StoSH');
 
-- ------------------------------------------------------------------------------------------

-- tables creation	
CREATE TABLE Zones(
	zone_id INTEGER PRIMARY KEY,
	lowerTemp iNTEGER,  
	higherTemp INTEGER
	);

-- Populate 
INSERT INTO Zones (zone_id, lowerTemp, higherTemp)VALUES
	(2, -50, -40),
	(3, -40, -30),
	(4, -30, -20),
	(5, -20, -10),
	(6, -10, 0 ),
	(7, 0, 10 ),
	(8, 10, 20),
	(9, 20, 30),
	(10, 30, 40);
	
-- ------------------------------------------------------------------------------------------
CREATE TABLE Deliveries(
	delvery_id INTEGER PRIMARY KEY,
	category VARCHAR(6), 
	delSize FLOAT
	);

-- Populate 
INSERT INTO Deliveries (delvery_id, category, delSize)
VALUES(1, 'pot', 1.500),
	(2, 'pot', 2.250),
	(3, 'pot', 2.625),
	(4, 'pot', 4.250),
	(5, 'plant', NULL),
	(6, 'bulb', NULL),
	(7, 'hedge', 18.000),
	(8, 'shrub', 24.000),
	(9, 'tree', 36.000);
	
-- a) the total number of zones.
SELECT COUNT(zone_id)'Zone Total'
	FROM Zones;

-- b) the number of flowers per cool zone.
SELECT common_name, cool_zone
	FROM FlowerInfo WHERE cool_zone < 7;

-- c) common names of the plants that have delivery sizes less than 5.
SELECT common_name, deliver
FROM FlowerInfo
WHERE deliver < 5;

-- d) common names of the plants that require full sun (i.e., sun needs contains ‘S’).
SELECT common_name
FROM FlowerInfo
WHERE sun_needs = 'S';

-- e) all delivery category names order alphabetically (without repetition).
SELECT *
FROM Deliveries 
ORDER BY 1;

-- f) the exact output (see instructions)
SELECT common_name, lowerTemp, higherTemp, category 
FROM FlowerInfo, Zones, Deliveries
WHERE deliver = delvery_id AND cool_zone = zone_id
GROUP BY common_name;


-- g) plant names that have the same hot zone as “Pink Caladiums” (your solution MUST get the hot zone of “Pink Caladiums” in a variable).
SELECT common_name, hot_zone
FROM FlowerInfo
WHERE hot_zone = '10';

-- h) the total number of plants, the minimum delivery size, the maximum delivery size, and the average size based on the plants that have delivery sizes (note that the average value should be rounded using two decimals).
--SELECT * FROM FlowersInfo INNER JOIN Deliveries ON delSize;
SELECT COUNT(DISTINCT deliver), MIN(delsize), MAX(delSize), ROUND(AVG(delSize),2)
FROM FlowerInfo, Deliveries WHERE deliver = delvery_id AND delSize IS NOT NULL;

-- i) the Latin name of the plant that has the word ‘Eyed’ in its name (you must use LIKE in this query to get full credit).  
SELECT common_name'Plant with the word Eyed',latin_name
FROM FlowerInfo
WHERE common_name LIKE '%Eyed%';

-- j)  the exact output (see instructions)
SELECT category'Category', common_name'Name'
FROM FlowerInfo, Deliveries
WHERE delvery_id = deliver;
