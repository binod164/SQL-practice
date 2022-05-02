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
