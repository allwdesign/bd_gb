DROP DATABASE IF EXISTS lesson3;

CREATE DATABASE lesson3;

USE lesson3;

CREATE TABLE IF NOT EXISTS staff
(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    post VARCHAR(25) NOT NULL,
    seniority INT UNSIGNED NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    age INT UNSIGNED NOT NULL
);

INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
    ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
    ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
    ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
    ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
    ('Иван', 'Иванов', 'Рабочий', 40, 30000, 59),
    ('Петр', 'Петров', 'Рабочий', 20, 25000, 40),
    ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
    ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
    ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
    ('Максим', 'Максимов', 'Рабочий', 2, 11000, 22),
    ('Юрий', 'Галкин', 'Рабочий', 3, 12000, 24),
    ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
    

# 1.Отсортируйте данные по полю заработная плата 
# (salary) в порядке: возрастания; 
SELECT * 
FROM staff
ORDER BY salary;

# 1.Отсортируйте данные по полю заработная плата 
# (salary) в порядке: убывания; 
SELECT * 
FROM staff
ORDER BY salary DESC;

# 2.Выведите 5 максимальных заработных плат (saraly)
SELECT DISTINCT salary 
FROM staff
ORDER BY salary DESC
LIMIT 5;

# 3.Посчитайте суммарную зарплату (salary) по каждой 
# специальности (роst)
SELECT 
	post AS 'Специальность', 
	SUM(salary) AS 'Суммарная зарплата' 
FROM staff
GROUP BY post;

# 4.Найдите кол-во сотрудников с специальностью (post) 
# «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT COUNT(*) AS 'Кол-во рабочих'
FROM staff 
WHERE post='Рабочий' AND age BETWEEN 24 AND 49;

# Или
SELECT COUNT(*) AS 'Кол-во рабочих' 
FROM staff
WHERE (age BETWEEN 24 AND 49)
GROUP BY post
HAVING post='Рабочий';


# 5.Найдите количество специальностей

# Подсчитываю только уникальные специальности
SELECT COUNT(DISTINCT post) AS 'Кол-во специальностей' FROM staff;

# Или с группировкой и с подзапросом 
SELECT COUNT(*) AS 'Кол-во специальностей'
FROM (SELECT post FROM staff GROUP BY post) AS result;

# 6.Выведите специальности, у которых средний возраст
# сотрудников меньше 30 лет включительно
SELECT post
FROM staff
GROUP BY post
HAVING AVG(age <= 30);
