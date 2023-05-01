DROP DATABASE IF EXISTS lesson5;
CREATE DATABASE lesson5;

USE lesson5;
CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- Создайте представление, в которое попадут автомобили 
-- стоимостью  до 25 000 долларов
CREATE OR REPLACE VIEW cars_upper_25000_view
AS
SELECT name, cost
FROM cars
WHERE cost < 25000;

SELECT * FROM cars_upper_25000_view;
    
-- Изменить в существующем представлении порог для стоимости:
-- пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW cars_upper_25000_view
AS
	SELECT name, cost
	FROM cars
	WHERE cost < 30000;

SELECT * FROM cars_upper_25000_view;

-- Создайте представление, в котором будут только
-- автомобили марки “Шкода” и “Ауди”
CREATE OR REPLACE VIEW skoda_and_audi
AS
	SELECT name, cost
    FROM cars
    WHERE name IN ('Skoda', 'Audi');
    
SELECT * FROM skoda_and_audi;