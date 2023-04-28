DROP DATABASE IF EXISTS tests; 

CREATE DATABASE tests;

USE tests;

CREATE TABLE test_a (id INT, data VARCHAR(45));
CREATE TABLE test_b (id INT);
INSERT INTO test_a(id, data) VALUES
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');
INSERT INTO test_b(id) VALUES
(10),
(30),
(50);

# Напишите запрос, который вернет строки из
# таблицы test_a, id которых нет в таблице test_b,
# НЕ используя ключевого слова NOT.
SELECT *
FROM test_a
WHERE id <> ALL(SELECT id FROM test_b); -- эквивалентно id NOT IN (10, 30, 50)