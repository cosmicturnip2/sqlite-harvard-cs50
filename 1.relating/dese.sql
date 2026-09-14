-- Exercise 1: List public schools in Massachusetts
SELECT name, city
  FROM schools
 WHERE type = 'Public School'
   AND state = 'MA';

-- Exercise 2: List districts with "non-op" in their name
SELECT name
  FROM districts
 WHERE name LIKE '%non-op%';

-- Exercise 3: Find the average per-pupil expenditure across districts
SELECT AVG(per_pupil_expenditure) AS "Average District Per-Pupil Expenditure"
  FROM expenditures;

-- Exercise 4: List the 10 cities with the most public schools
  SELECT city, COUNT(name)
    FROM schools
   WHERE type = 'Public School'
GROUP BY city
ORDER BY COUNT(name) DESC, city
   LIMIT 10;

-- Exercise 5: List cities with 3 or fewer public schools, most schools first
  SELECT city, COUNT(name)
    FROM schools
   WHERE type = 'Public School'
GROUP BY city
  HAVING COUNT(name) <= 3
ORDER BY COUNT(name) DESC, city;

-- Exercise 6: List schools with a 100% graduation rate
SELECT name
  FROM schools
 WHERE id IN
       (SELECT school_id
          FROM graduation_rates
         WHERE graduated = 100);

-- Exercise 7: List schools in the Cambridge district
SELECT name
  FROM schools
 WHERE district_id =
       (SELECT id
          FROM districts
         WHERE name = 'Cambridge');

-- Exercise 8: List each district's name and pupil count
SELECT districts.name, expenditures.pupils
  FROM districts
       INNER JOIN expenditures
       ON districts.id = expenditures.district_id;

-- Exercise 9: Find the district with the fewest pupils
  SELECT districts.name
    FROM districts
         INNER JOIN expenditures
         ON districts.id = expenditures.district_id
ORDER BY expenditures.pupils
   LIMIT 1;

-- Exercise 10: List the 10 public school districts with the highest per-pupil expenditure
  SELECT name, per_pupil_expenditure
    FROM districts
         INNER JOIN expenditures
         ON districts.id = expenditures.district_id
   WHERE type = 'Public School District'
ORDER BY per_pupil_expenditure DESC
   LIMIT 10;

-- Exercise 11: List schools' expenditure and graduation rate, highest expenditure first
  SELECT name, per_pupil_expenditure, graduated
    FROM expenditures
         INNER JOIN schools
         ON expenditures.district_id = schools.district_id
         INNER JOIN graduation_rates
         ON schools.id = graduation_rates.school_id
ORDER BY per_pupil_expenditure DESC, name;

-- Exercise 12: List above-average districts on both expenditure and exemplary staff rating
  SELECT name, per_pupil_expenditure, exemplary
    FROM districts
         INNER JOIN expenditures
         ON districts.id = expenditures.district_id
         INNER JOIN staff_evaluations
         ON expenditures.district_id = staff_evaluations.district_id
   WHERE type = 'Public School District'
     AND per_pupil_expenditure > (SELECT AVG(per_pupil_expenditure) FROM expenditures)
     AND exemplary > (SELECT AVG(exemplary) FROM staff_evaluations)
ORDER BY exemplary DESC, per_pupil_expenditure DESC;

-- Exercise 13: List the 20 districts with highest expenditure and exemplary ratings
  SELECT district_id, per_pupil_expenditure, pupils, exemplary, unsatisfactory
    FROM expenditures
         NATURAL JOIN staff_evaluations
ORDER BY per_pupil_expenditure DESC, exemplary DESC
   LIMIT 20;
