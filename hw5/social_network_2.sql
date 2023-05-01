USE lesson_4;
-- Получите друзей пользователя с id=1
-- (решение задачи с помощью представления “друзья”)
CREATE OR REPLACE VIEW friends
AS
	SELECT target_user_id AS id
	FROM friend_requests 
	WHERE status = 'approved' AND initiator_user_id = 1
	UNION 
	SELECT initiator_user_id 
	FROM friend_requests 
	WHERE status = 'approved' AND target_user_id = 1;

SELECT * FROM friends;

-- Создайте представление, в котором будут выводится все сообщения, в которых принимал 
-- участие пользователь с id = 1.
-- Т.е отправитель и получатель пользователь с id = 1.
CREATE OR REPLACE VIEW first_user_messages
AS
	SELECT * FROM messages
	WHERE from_user_id = 1 OR to_user_id = 1;

SELECT * FROM first_user_messages;

-- Получите список медиафайлов пользователя с количеством лайков(media m, likes l ,users u)
CREATE OR REPLACE VIEW users_media
AS
SELECT 
	m.id,
	m.filename,
	CONCAT(u.firstname, ' ', u.lastname) AS file_owner,
	COUNT(l.id) AS likes_quantity
FROM media m
LEFT JOIN likes l ON l.media_id = m.id
JOIN users u ON u.id = m.user_id
GROUP BY m.id
ORDER BY u.id;

SELECT * FROM users_media;

-- Получите количество групп у пользователей
SELECT 
	CONCAT(u.firstname, ' ', u.lastname) AS 'пользователь',
    COUNT(uc.community_id) AS 'кол-во групп'
FROM users AS u
LEFT JOIN users_communities AS uc
ON u.id = uc.user_id
GROUP BY u.id, uc.user_id;

-- Или с оконной функцией COUNT
SELECT 
	CONCAT(u.firstname, ' ', u.lastname) AS `user`,
    COUNT(uc.community_id) OVER(PARTITION BY uc.user_id ORDER BY uc.user_id) AS group_quantity
FROM users AS u
LEFT JOIN users_communities AS uc
ON u.id = uc.user_id;


SELECT 
	CONCAT(u.firstname, ' ', u.lastname) AS `user`,
    COUNT(uc.community_id) OVER w AS group_quantity
FROM users AS u
LEFT JOIN users_communities AS uc
ON u.id = uc.user_id
WINDOW w AS (PARTITION BY uc.user_id ORDER BY uc.user_id); -- Окно состоит из секций по пользователям

-- Вывести 3 пользователей с наибольшим количеством лайков за медиафайлы
SELECT 
	um.file_owner
FROM users_media as um
ORDER BY um.likes_quantity DESC
LIMIT 3;

-- Или с подзапросом и оконной функцией ранжирования
SELECT *
FROM 
	(
		SELECT 
			um.file_owner, um.likes_quantity,
			DENSE_RANK() OVER(ORDER BY um.likes_quantity DESC) AS `rank`
		FROM users_media as um
	) AS ranked_users_media
WHERE `rank` <= 3;

-- Или с представлением
CREATE OR REPLACE VIEW ranked_users_media
AS
	SELECT 
			um.file_owner, um.likes_quantity,
			DENSE_RANK() OVER(ORDER BY um.likes_quantity DESC) AS `rank`
	FROM users_media as um
	ORDER BY um.likes_quantity DESC;
    
SELECT *
FROM ranked_users_media
WHERE `rank` <= 3;