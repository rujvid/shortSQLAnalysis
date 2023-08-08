-- Short project using the "Suicides in India" dataset in Kaggle to analyze the data

select * from suicides_india

--DATA EXPLORATION
-- Get the number of records
SELECT COUNT(*) AS total_suicides FROM suicides_india si ;

-- Get sample of records and limit it to only 10
SELECT * FROM suicides_india si 
LIMIT 10;

-- Don't have any missing values and no data cleaning required for this project 

--DATA ANALYSIS
-- The total number of suicides in every state in descending order
SELECT state, COUNT(*) as suicides_each_state
FROM suicides_india si 
GROUP BY state
ORDER BY suicides_each_state DESC;


-- Suicides organized by gender and the age group
SELECT gender, age_group, COUNT(*) as suicides_age_gender
FROM suicides_india si 
GROUP BY gender, age_group
order by suicides_age_gender desc;


-- Counts the amount of suicides each year
SELECT "Year", COUNT(*) as suicides_each_year
FROM suicides_india si
GROUP BY "Year" 
ORDER BY "Year";

-- Finds the average amount of suicides each year
SELECT AVG(suicides_each_year) as average_each_year
FROM (
    SELECT "Year" , COUNT(*) as suicides_each_year
    FROM suicides_india si
    GROUP BY "Year"
) subquery;

-- Number of suicides organized by the cause and reason for death in descending order
SELECT "Type", type_code, COUNT(*) as cause_suicides
FROM suicides_india si 
GROUP BY "Type", type_code
order by cause_suicides desc;

-- Adds a temporary column in order to store the converted string gender values to integers
ALTER TABLE suicides_india 
ADD COLUMN new_gender INTEGER;

-- Convert "gender" column from VARCHAR to INTEGER
UPDATE suicides_india 
SET new_gender = CASE gender
                WHEN 'Male' THEN 1
                WHEN 'Female' THEN 2
             END;
-- Deletes the previous "gender" column
ALTER TABLE suicides_india 
DROP COLUMN gender;

-- Renames the new column to "gender"
ALTER TABLE suicides_india 
RENAME COLUMN new_gender TO gender;
SELECT * FROM suicides_india si;

-- Adds a new column to store the new integer gender values
ALTER TABLE suicides_india 
ADD COLUMN new_age INTEGER;

-- Changes the "age_group" column from VARCHAR to INT
UPDATE suicides_india 
SET new_age = CASE age_group
                WHEN '0-14' THEN 10
                WHEN '15-29' THEN 20
                when '30-44' then 30
                when '45-59' then 50
                when '60+' then 60
             END;
-- Deletes the previous "age_group" column
ALTER TABLE suicides_india 
DROP COLUMN age_group;

-- Renames the new column to "age_group"
ALTER TABLE suicides_india 
RENAME COLUMN new_age TO age_group;
SELECT * FROM suicides_india si;

--Finds the correlation between age and gender
select corr(gender, age_group)
from suicides_india si;



