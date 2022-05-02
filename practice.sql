-- 1.Show first name, last name, and gender of patients who's gender is 'M'
SELECT first_name,last_name, gender FROM patients
Where gender = "M";


-- 2.Show first name and last name of patients who does not have allergies (null).
SELECT first_name,last_name FROM patients
Where allergies IS null;

--3.Show first name of patients that start with the letter 'C'
SELECT first_name FROM patients
Where first_name LIKe "C%";

--4.Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name,last_name FROM patients
Where weight Between 100 and 120;

--5.Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients
SET allergies = "NKA"
Where allergies IS null;

--6.Show first name and last name concatinated into one column to show their full name.
SELECT CONCAT(first_name,' ', last_name) AS full_name
FROM patients;
