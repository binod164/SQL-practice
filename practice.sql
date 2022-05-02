-- 1.Show first name, last name, and gender of patients who's gender is 'M'
SELECT first_name,last_name, gender FROM patients
Where gender = "M";


-- 2.Show first name and last name of patients who does not have allergies (null).
SELECT first_name,last_name FROM patients
Where allergies IS null;

--3.Show first name of patients that start with the letter 'C'
SELECT first_name FROM patients
Where first_name LIKe "C%";
