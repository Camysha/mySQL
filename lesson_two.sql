USE lesson_two;

CREATE TABLE movies
(id INT PRIMARY KEY AUTO_INCREMENT,
title  VARCHAR(100) NOT NULL,
title_eng VARCHAR(100),
year_movie INT NOT NULL,
count_min INT,
storyline TEXT NOT NULL);

INSERT INTO movies (title, title_eng, year_movie, count_min, storyline)
	values ('Винни Пух', 'Mad bear', 1978, 40, 'мультик про медведя'),
	("Ёжик в тумане", " ", 1964, 26, "Про ежика, который ищет лошкадку"),
    ('Кунг-Фу Панда 4', 'Kung Fu Panda 4', 2024, 147, 'Продолжение приключений легендарного Воина Дракона, его верных друзей и наставника'),
    ('Властелин Колец', 'The lord of the rings',2004, 187, 'история про кольцо и хоббитов');
    
    
RENAME table movies TO cinema;

ALTER TABLE cinema 
add column status_active BIT, 
add	column genre_id INT AFTER title_eng;

CREATE TABLE genres
(id INT PRIMARY KEY AUTO_INCREMENT,
name_genr  VARCHAR(100) NOT NULL);

INSERT INTO genres (name_genr)
	values ('Мультфильм'),
	('Фэнтези');
    
-- До 50 минут -  Короткометражный фильм
-- От 50 минут до 150 минут  -  Среднеметражный фильм
-- Более 150 минут  -  Полнометражный фильм

SELECT * from cinema;

SELECT id, title, count_min,
CASE
	WHEN count_min <50 THEN 'Короткометражный фильм'
    WHEN count_min <150 THEN 'Среднеметражный фильм'
    WHEN count_min >=150 THEN 'Полнометражный фильм'
    ELSE 'НЕ ОПРЕДЕЛЕНО'
END AS 'ТИП ФИЛЬМА'
FROM cinema;

select id, title, count_min,
if (count_min < 50, "Короткометражка", 
	if (count_min < 150, "Среднеметражка", 
		if (count_min>= 150 , "Полнометражка", "Не определено")))
as "Тип фильма" From cinema;