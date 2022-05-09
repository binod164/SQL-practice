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
    p1.Email = p2.Email AND p1.Id > p2.Id