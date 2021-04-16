# Create a relational database system named orders that matches the given E/R
# model. Then add the following Products, making sure the “id” for the table
# is auto-incremented.

DROP DATABASE orders;

CREATE DATABASE orders;

USE orders;

# DROP TABLE Products;

CREATE TABLE Products
(
    id    INT PRIMARY KEY AUTO_INCREMENT,
    descr VARCHAR(25)    NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO PRODUCTS (descr, price)
VALUES ('Ninja Sword', 250);
INSERT INTO PRODUCTS (descr, price)
VALUES ('Dummy', 50);
INSERT INTO PRODUCTS (descr, price)
VALUES ('Fake Blood', 5);
INSERT INTO PRODUCTS (descr, price)
VALUES ('Rubber Ducky', 1);
INSERT INTO PRODUCTS (descr, price)
VALUES ('Bathtub Soap', 3);
INSERT INTO PRODUCTS (descr, price)
VALUES ('Brazilian Coffee', 5);
INSERT INTO PRODUCTS (descr, price)
VALUES ('Running Shoes', 50);

# After the inserts your table Items should look like the following:
# +--------+----+-----+
# | number | id | qtt |
# +--------+----+-----+
# | 101    | 1  | 1   |
# | 101    | 2  | 10  |
# | 101    | 3  | 5   |
# | 202    | 4  | 200 |
# | 202    | 6  | 10  |
# | 303    | 1  | 10  |
# | 303    | 7  | 1   |
# | 404    | 4  | 1   |
# | 404    | 7  | 3   |
# +--------+----+-----+

# DROP Table Orders;

CREATE TABLE Orders
(
    number INT PRIMARY KEY,
    date   DATE NOT NULL
);

INSERT INTO Orders
VALUES (101, '2017-09-12');
INSERT INTO Orders
VALUES (202, '2018-09-27');
INSERT INTO Orders
VALUES (303, '2018-09-30');
INSERT INTO Orders
VALUES (404, '2018-10-12');

# DROP TABLE Items;

CREATE TABLE Items
(
    number INT,
    id     INT,
    PRIMARY KEY (number, id),
    qtt    INT NOT NULL,
    FOREIGN KEY (number) REFERENCES Orders (number),
    FOREIGN KEY (id) REFERENCES Products (id)
);

-- Create the table Items, making sure to also create a trigger that ensures
# that column “qtt” is automatically set to 1 IF the value entered is less
# than or equal 0. The trigger must be set before populating the table!
# Try to run the following inserts AFTER your trigger is created (the inserts
# in red should “trigger the trigger”).
DELIMITER |
CREATE TRIGGER item_qtt_default
    BEFORE INSERT
    ON Items
    FOR EACH ROW
BEGIN
    IF NEW.qtt <= 0 THEN
        SET NEW.qtt = 1;
    END IF;
END;
|
DELIMITER ;

DELIMITER |

CREATE TRIGGER delete_orders
    BEFORE DELETE
    ON Orders
    FOR EACH ROW
BEGIN
    DELETE FROM Items WHERE number = OLD.number;
END;
|
DELIMITER ;

INSERT INTO Items
VALUES (101, 1, -1);
INSERT INTO Items
VALUES (101, 2, 10);
INSERT INTO Items
VALUES (101, 3, 5);
INSERT INTO Items
VALUES (202, 4, 200);
INSERT INTO Items
VALUES (202, 6, 10);
INSERT INTO Items
VALUES (303, 7, 0);
INSERT INTO Items
VALUES (303, 1, 10);
INSERT INTO Items
VALUES (404, 4, 1);
INSERT INTO Items
VALUES (404, 7, 3);

-- View 1: OrdersTotalByMonth
CREATE VIEW OrdersByTotalMonth
AS
SELECT YEAR(date) AS year, MONTH(date) AS month, FLOOR(SUM(qtt * price)) AS total
FROM Orders
         NATURAL JOIN Items
         NATURAL JOIN Products
GROUP BY year, month
ORDER BY year, month;

-- View 2: OrdersTotalByYear
CREATE VIEW OrdersTotalByYear AS
SELECT YEAR(date) AS year, FLOOR(SUM(qtt * price)) AS total
FROM Orders
         NATURAL JOIN Items
         NATURAL JOIN Products
GROUP BY year
ORDER BY year;
# +------+-------+
# | year | total |
# +------+-------+
# | 2017 | 775   |
# | 2018 | 2951  |
# +------+-------+

# challenge create another view called OrdersTotal2018Year that is similar to
# OrdersTotalByMonth but only shows orders placed in 2018.
CREATE VIEW OrdersTotalCurrentYear AS
SELECT YEAR(date) AS year, MONTH(date) AS month, FLOOR(SUM(qtt * price)) AS total
FROM Orders
         NATURAL JOIN Items
         NATURAL JOIN Products
GROUP BY year, month
HAVING year = YEAR(CURDATE())
ORDER BY year, month;

# Challenge:
# CREATE VIEW OrdersTotal2018Year AS
# SELECT YEAR(date) AS year, MONTH(date) AS month, FLOOR(SUM(qtt * price)) AS total
# FROM Orders
# NATURAL JOIN Items
# NATURAL JOIN Products
# GROUP BY year, month
# HAVING year = 2018
# ORDER BY year, month;
CREATE VIEW OrdersTotalYear2018 AS
SELECT YEAR(date) AS year, MONTH(date) AS month, FLOOR(SUM(qtt * price)) AS total
FROM Orders
         NATURAL JOIN Items
         NATURAL JOIN Products
GROUP BY year, month
HAVING year = 2018
ORDER BY year, month;

# +------+-------+-------+
# | year | month | total |
# +------+-------+-------+
# | 2018 | 9     | 2800  |
# | 2018 | 10    | 151   |
# +------+-------+-------+