-- 1.Show first name, last name, and gender of patients who's gender is 'M'
SELECT first_name,last_name, gender FROM patients
WHERE gender = "M";


-- 2.Show first name and last name of patients who does not have allergies (null).
SELECT first_name,last_name FROM patients
WHERE allergies IS null;

--3.Show first name of patients that start with the letter 'C'
SELECT first_name FROM patients
WHERE first_name LIKe "C%";

--4.Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name,last_name FROM patients
WHERE weight Between 100 and 120;

--5.Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients
SET allergies = "NKA"
WHERE allergies IS null;

--6.Show first name and last name concatinated into one column to show their full name.
SELECT CONCAT(first_name,' ', last_name) AS full_name
FROM patients;

--7.Show first name, last name, and the full province name of each patient.
SELECT first_name,last_name,province_name FROM patients
JOIN provinces
WHERE patients.province_id = provinces.province_id;

--8.Show how many patients have a birth_date with 2010 as the birth year.
SELECT Count(*) FROM patients
WHERE YEAR(birth_date) = 2010;

--9.Show the first_name, last_name, and height of the patient with the greatest height.
SELECT first_name,last_name,height FROM patients
WHERE height = (SELECT MAX(height) from patients);

--10.Show all columns for patients who have one of the following patient_ids:
-- 1,45,534,879,1000

SELECT * FROM patients
WHERE patient_id in (1,45,534,879,1000);

--11.Show the total number of admissions
SELECT COunt(*) from admissions;

--12.Show unique birth years from patients and order them by ascending.
SELECT DIstinct YEAR(birth_date) from patients
ORDER BY YEAR(birth_date);

--13.Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
SELECT first_name
  FROM patients
  GROUP BY first_name
  HAVING count(*) = 1;

  --14.Show patient_id and first_name from patients where their first_name start and ends with 's' and is atleast 5 characters long.
  SELECT patient_id,first_name
  FROM patients
  Where first_name like "s___%s";

  --15.Show patient_id, first_name, last_name from patients whos primary_diagnosis is 'Dementia'.Primary diagnosis is stored in the admissions table.
SELECT patients.patient_id,first_name, last_name
  FROM patients
  JOIN admissions
  ON patients.patient_id = admissions.patient_id
  Where primary_diagnosis = "Dementia";

--16.Show patient_id, first_name, last_name from the patients table.
-- Order the rows by the first_name ascending and then by the last_name descending.
SELECT patient_id,first_name, last_name
  FROM patients
  ORDER by first_name ASC, last_name DESC;

  --17.Show the total amount of male patients and the total amount of female patients in the patients table
  SELECT (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;  

  --18.Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
  SELECT first_name, last_name, allergies FROM patients
WHERE allergies in ("Penicillin", "Morphine")
ORder by allergies, first_name, last_name;

--19Table: Person

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | personId    | int     |
-- | lastName    | varchar |
-- | firstName   | varchar |
-- +-------------+---------+
-- personId is the primary key column for this table.
-- This table contains information about the ID of some persons and their first and last names.
 

-- Table: Address

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | addressId   | int     |
-- | personId    | int     |
-- | city        | varchar |
-- | state       | varchar |
-- +-------------+---------+
-- addressId is the primary key column for this table.
-- Each row of this table contains information about the city and state of one person with ID = PersonId.
 

-- Write an SQL query to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.

-- Return the result table in any order.

-- The query result format is in the following example.


SELECT firstName,lastName,city,state from Person
LEFT JOIN Address
ON Person.personId = Address.personId;

--20.+-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | email       | varchar |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table contains an email. The emails will not contain uppercase letters.
 

-- Write an SQL query to report all the duplicate emails.
SELECT email FROM Person
GROUP BY email
HAVING COUNT(email)>1

--21.Table: Customers

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table indicates the ID and name of a customer.
 

-- Table: Orders

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | customerId  | int  |
-- +-------------+------+
-- id is the primary key column for this table.
-- customerId is a foreign key of the ID from the Customers table.
-- Each row of this table indicates the ID of an order and the ID of the customer who ordered it.


SELECT Customers.name As Customers FROM Customers 
WHERE Customers.id NOT IN
(SELECT customerId FROM Orders);

--22.+-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- | salary      | int     |
-- | managerId   | int     |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 

-- Write an SQL query to find the employees who earn more than their managers.

-- Return the result table in any order.

-- The query result format is in the following example.

SELECT
    a.Name AS 'Employee'
FROM
    Employee AS a,
    Employee AS b
WHERE
    a.ManagerId = b.Id
        AND a.Salary > b.Salary
;

--23. +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | email       | varchar |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table contains an email. The emails will not contain uppercase letters.
 

-- Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. Note that you are supposed to write a DELETE statement and not a SELECT one.

-- Return the result table in any order.

-- The query result format is in the following example.

DELETE p1 FROM Person p1,
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id;

--24.+-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | student     | varchar |
-- | class       | varchar |
-- +-------------+---------+
-- (student, class) is the primary key column for this table.
-- Each row of this table indicates the name of a student and the class in which they are enrolled.
 

-- Write an SQL query to report all the classes that have at least five students.

-- Return the result table in any order.

SELECT class FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;


--25.Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
-- Field	Type
-- ID	NUMBER
-- NAME	VARCHAR2(17)
-- COUNTRY CODE	VARCHAR2(3)
-- DISTRICT	VARCHAR2(20)
-- POPULATION	NUMBER

SELECT * FROM CITY
WHERE COUNTRYCODE="USA" AND POPULATION>100000;


--26.Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.

SELECT NAME FROM CITY
WHERE COUNTRYCODE = "USA" AND POPULATION>120000;

--27.Query all columns for a city in CITY with the ID 1661.

SELECT * FROM CITY
WHERE ID = 1661;

--28.Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT * FROM CITY
WHERE COUNTRYCODE = "JPN";

--29.Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT NAME FROM CITY
WHERE COUNTRYCODE = "JPN";

--30.Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
-- Field	Type
-- ID	NUMBER
-- CITY	VARCHAR2(21)
-- STATE	VARCHAR2(2)
-- LAT_N	NUMBER
-- LONG_W	NUMBER


SELECT DISTINCT CITY FROM STATION 
WHERE MOD(ID,2)=0;

--31.Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION;

--32.Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.

SELECT CITY, LENGTH(CITY) FROM STATION 
ORDER BY LENGTH(CITY), CITY LIMIT 1;
SELECT CITY, LENGTH(CITY) FROM STATION 
ORDER BY LENGTH(CITY) DESC, CITY LIMIT 1;

--33.Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%';

--34.Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

SELECT DISTINCT CITY FROM STATION 
WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u';

--35.Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE upper(SUBSTR(CITY,1,1)) IN ('A','E','I','O','U') AND lower(RIGHT(CITY,1)) IN ('a','e','i','o','u');
--OR
SELECT DISTINCT CITY FROM STATION WHERE upper(SUBSTR(CITY,1,1)) IN ('A','E','I','O','U') AND lower(SUBSTR(CITY,LENGTH(CITY),1)) IN ('a','e','i','o','u');     


--36.Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION 
WHERE upper(SUBSTR(CITY,1,1)) NOT IN ("A","E","I","O","U");

--37.Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.

SELECT DISTINCT CITY FROM STATION 
WHERE upper(SUBSTR(CITY,LENGTH(CITY),1)) NOT IN ("A","E","I","O","U");

--38.Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE upper(SUBSTR(CITY,1,1)) NOT IN ('A','E','I','O','U') OR lower(SUBSTR(CITY,LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');    

--39.Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE upper(SUBSTR(CITY,1,1)) NOT IN ('A','E','I','O','U') AND lower(SUBSTR(CITY,LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');    

--40.Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
-- Input Format

-- The STUDENTS table is described as follows:

-- Column	Type
-- ID	INTEGER
-- NAME	STRING
-- MARKS	INTEGER
-- The Name column only contains uppercase (A-Z) and lowercase (a-z) letters.

-- Sample Input

-- ID	NAME	MARKS
-- 1	ASHLEY	81
-- 2	SAMANTHA	75
-- 4	JULIA	76
-- 3	JULIA	84
-- Sample Output

-- Ashley Julia Belvet

SELECT NAME FROM STUDENTS
WHERE MARKS > 75
ORDER BY (RIGHT(NAME,3)), ID;

--41.###Employee Names
-- Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

-- Input Format

-- The Employee table containing employee data for a company is described as follows:

-- Column	Type
-- employee_id	INTEGER
-- name	STRING
-- months	INTEGER
-- salary	INTEGER
-- where employee_id is an employee's ID number, name is their name, months is the total number of months they've been working for the company, and salary is their monthly salary.

-- Sample Input

-- employee_id	name	marks	salary
-- 12228	Rose	15	1968
-- 33645	Angela	1	3443
-- 45692	Frank	17	1608
-- 56118	Patrick	7	1345
-- 59725	Lisa	11	2330
-- 74197	Kimberly	16	4372
-- 78454	Bonnie	8	1771
-- 83565	Michael	6	2017
-- 98607	Todd	5	3396
-- 99989	Joe	9	3573
-- Sample Output

-- Angela Bonnie Frank Joe Kimberly Lisa Michael Patrick Rose Todd

SELECT name FROM Employee
ORDER BY name;

--42.Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  per month who have been employees for less than  months. Sort your result by ascending employee_id.
SELECT name FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id;

--43.The Blunder
-- Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

-- Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.

SELECT CEIL(AVG(Salary)-AVG(replace(Salary, 0 ,""))) FROM EMPLOYEES;