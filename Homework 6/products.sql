-- Matt Hurt
-- Homework 6: Triggers
-- Due date: April 8, 2021

DROP DATABASE IF EXISTS products;

CREATE DATABASE products;

USE products;

# DROP TABLE IF EXISTS Products;

CREATE TABLE Products
(
    id    INT PRIMARY KEY AUTO_INCREMENT,
    descr VARCHAR(25)    NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

ALTER TABLE Products ADD COLUMN cond VARCHAR(10) DEFAULT 'new';

DELIMITER |
CREATE TRIGGER change_cond
    BEFORE INSERT
    ON Products
    FOR EACH ROW
BEGIN
    IF NEW.cond NOT IN ('new' ,'used') THEN
        SET NEW.cond = 'new';
    END IF;
END;
|
DELIMITER ;

INSERT INTO PRODUCTS (descr, price, cond)
VALUES ('Ninja Sword', 250, 'new');
INSERT INTO PRODUCTS (descr, price, cond)
VALUES ('Dummy', 50, 'new');
INSERT INTO PRODUCTS (descr, price, cond)
VALUES ('Fake Blood', 5, 'used');
INSERT INTO PRODUCTS (descr, price, cond)
VALUES ('Rubber Ducky', 1, 'used');
INSERT INTO PRODUCTS (descr, price, cond)
VALUES ('Bathtub Soap', 3, 'used once');
INSERT INTO PRODUCTS (descr, price, cond)
VALUES ('Brazilian Coffee', 5, 'new');
INSERT INTO PRODUCTS (descr, price, cond)
VALUES ('Running Shoes', 50, 'fair');

