DROP DATABASE IF EXISTS lesson_three;
CREATE DATABASE lesson_three;
USE lesson_three;

-- Персонал
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT, 
	salary INT, 
	age INT
);

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT, 
	salary INT, 
	age INT
);

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);

-- Проверка 
SELECT id, firstname, lastname, post, seniority, salary, age  FROM staff;

/*Выведите все записи, отсортированные по полю "age" по возрастанию
Выведите все записи, отсортированные по полю “firstname"
Выведите записи полей "firstname ", “lastname", "age", отсортированные по полю "firstname " в алфавитном порядке по убыванию
Выполните сортировку по полям " firstname " и "age" по убыванию*/

-- Выведите все записи, отсортированные по полю "age" по возрастанию
SELECT * FROM staff 
order by age;

-- Выведите все записи, отсортированные по полю “firstname"
select * from staff
order by firstname; 

-- Выведите записи полей "firstname ", “lastname", "age", отсортированные по полю "firstname " в алфавитном порядке по убыванию
select firstname, lastname, age from staff
order by firstname DESC; 

-- Выполните сортировку по полям " firstname " и "age" по убыванию
select * from staff
order by firstname desc, age DESC; 

/*1. Найдите количество сотрудников с должностью «Рабочий» 
2. Посчитайте ежемесячную зарплату начальников
3. Выведите средний возраст сотрудников, у которых заработная плата больше 30000
4. Выведите максимальную и минимальную заработные платы*/

select count(*) from staff
where post='рабочий';

-- 2. Посчитайте ежемесячную зарплату начальников
select sum(Salary) from staff
where post='начальник';

-- 3. Выведите средний возраст сотрудников, у которых заработная плата больше 30000
select avg(age) from staff
where salary>30000;

-- 4. Выведите максимальную и минимальную заработные платы
select min(salary), max(salary) from staff;

-- Работа персонала
DROP TABLE IF EXISTS activity_staff;
CREATE TABLE activity_staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	staff_id INT NOT NULL,
	date_activity DATE,
	count_pages INT,
	FOREIGN KEY (staff_id) REFERENCES staff (id) ON DELETE CASCADE ON UPDATE CASCADE  
);

-- Наполнение данными
INSERT INTO activity_staff (staff_id, date_activity, count_pages)
VALUES
(1, '2022-01-01', 250),
(2, '2022-01-01', 220),
(3, '2022-01-01', 170),
(1, '2022-01-02', 100),
(2, '2022-01-02', 220),
(3, '2022-01-02', 300),
(7, '2022-01-02', 350),
(1, '2022-01-03', 168),
(2, '2022-01-03', 62),
(3, '2022-01-03', 84);

-- 1. Выведите общее количество напечатанных страниц каждым сотрудником
select sum(count_pages), staff_id from activity_staff
group by staff_id;

select firstname, lastname, sum(count_pages) from activity_staff, staff
where staff_id = staff.id
group by staff_id;

-- 2. Посчитайте количество страниц за каждый день
select date_activity, sum(count_pages) from activity_staff
group by date_activity;

-- 3. Найдите среднее арифметическое по количеству ежедневных страниц
select date_activity, avg(count_pages) from activity_staff
group by date_activity;


/*Сгруппируйте данные о сотрудниках по возрасту: 
1 группа – младше 20 лет
2 группа – от 20 до 40 лет
3 группа – старше  40 лет 
Для каждой группы  найдите суммарную зарплату*/

select avg(salary), 
case
when age<25 then '1 группа'
when age<40 then '2 группа'
else '3 группа'
end as age_cat
from staff
group by age_cat;

-- 1. Выведите id сотрудников, которые напечатали более 500 страниц за всех дни
select firstname, lastname, sum(count_pages) as total_page from activity_staff, staff
where staff_id = staff.id
group by staff_id
HAVING sum(count_pages)>500;

-- 2.  Выведите  дни, когда работало более 3 сотрудников Также укажите кол-во сотрудников, которые работали в выбранные дни.
select date_activity, count(staff_id) as count_workers from activity_staff
group by date_activity
HAVING count(staff_id)>3;

-- 3. Выведите среднюю заработную плату по должностям, которая составляет более 30000
select post, avg(salary) as avg_salary from staff
group by post
HAVING avg(salary)>30000;
