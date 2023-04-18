USE lesson1;

CREATE TABLE IF NOT EXISTS smartphone
(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(45), 
    Manufacturer VARCHAR(45),
    ProductCount INT,
    Price INT
);

INSERT smartphone (ProductName, Manufacturer, ProductCount, Price)
VALUES
	('IPhone X', 'Apple', 3, 76000), -- id=1
	('IPhone 8', 'Apple', 2, 51000), -- id=2
	('Galaxy S9', 'Samsung', 2, 56000), -- id=3
	('Galaxy S8', 'Samsung', 1, 41000), -- id=4
	('P20 Pro', 'Huawei', 5, 36000); -- id=5

# 1. Все записи из таблицы
SELECT * FROM smartphone;

/* 
	2. Выведите название, производителя и цену для товаров,
	количество которых превышает 2
*/
SELECT ProductName, Manufacturer, Price
FROM smartphone
WHERE ProductCount>2;

/* 
	3. Выведите весь ассортимент товаров марки “Samsung”
*/
SELECT *
FROM smartphone
WHERE Manufacturer='Samsung';

/* 
	4. Выведите информацию о телефонах, где суммарный чек
	больше 100 000 и меньше 145 000**
*/
SELECT *
FROM smartphone
WHERE (ProductCount*Price)>100000 AND (ProductCount*Price)<145000;