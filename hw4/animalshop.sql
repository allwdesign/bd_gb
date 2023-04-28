DROP DATABASE IF EXISTS animalshop;

CREATE DATABASE animalshop;

USE animalshop;

CREATE TABLE `shops` (
    `id` INT,
    `shopname` VARCHAR (100),
    PRIMARY KEY (id)
);
CREATE TABLE `cats` (
    `name` VARCHAR (100),
    `id` INT,
    PRIMARY KEY (id),
    shops_id INT,
    CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id)
        REFERENCES `shops` (id)
);

INSERT INTO `shops`
VALUES 
	(1, "Четыре лапы"),
        (2, "Мистер Зоо"),
        (3, "МурзиЛЛа"),
        (4, "Кошки и собаки");

INSERT INTO `cats`
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);
        
SELECT *
FROM cats;

SELECT *
FROM shops;

# Вывести всех котиков по магазинам по id
# (условие соединения shops.id = cats.shops_id)
SELECT cats.name, shops.shopname
FROM cats
JOIN shops
ON shops.id = cats.shops_id;

# Вывести магазин, в котором продается кот “Мурзик”
SELECT shops.shopname
FROM shops
JOIN cats
ON shops.id = cats.shops_id
WHERE cats.name = 'Murzik';

# Или
SELECT shops.shopname
FROM shops
WHERE shops.id IN (SELECT shops_id FROM cats WHERE cats.name = 'Murzik');

# Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”
SELECT shops.shopname, cats.name
FROM shops -- левая таблица
LEFT JOIN cats -- правая таблица
ON shops.id = cats.shops_id
WHERE (cats.name != 'Murzik' AND cats.name != 'Zuza') 
OR cats.name IS NULL;

