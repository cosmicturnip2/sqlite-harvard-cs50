-- Exercise 1: Find the birthplace of Jackie Robinson
SELECT birth_city, birth_state, birth_country
  FROM players
 WHERE first_name = 'Jackie'
   AND last_name = 'Robinson';

-- Exercise 2: Find which hand Babe Ruth bats with
SELECT bats
  FROM players
 WHERE first_name = 'Babe'
   AND last_name = 'Ruth';

-- Exercise 3: Find players who have no recorded debut date
SELECT id
  FROM players
 WHERE debut IS NULL;

-- Exercise 4: List players not born in the USA, alphabetically
  SELECT first_name, last_name
    FROM players
   WHERE birth_country != 'USA'
ORDER BY first_name, last_name;

-- Exercise 5: List right-handed batters, alphabetically
  SELECT first_name, last_name
    FROM players
   WHERE bats = 'R'
ORDER BY first_name, last_name;

-- Exercise 6: List players born in Pittsburgh, PA, most recent debut first
  SELECT first_name, last_name, debut
    FROM players
   WHERE birth_city = 'Pittsburgh'
     AND birth_state = 'PA'
ORDER BY debut DESC, first_name, last_name;

-- Exercise 7: Count players who bat and throw with opposite hands
SELECT COUNT(*)
  FROM players
 WHERE (bats = 'R' AND throws = 'L')
    OR (bats = 'L' AND throws = 'R');

-- Exercise 8: Average height and weight of players debuting in 2000 or later
SELECT ROUND(AVG(height), 2) AS 'Average Height',
       ROUND(AVG(weight), 2) AS 'Average Weight'
  FROM players
 WHERE debut >= '2000-01-01';

-- Exercise 9: List players whose final game was in 2022, alphabetically
  SELECT first_name, last_name
    FROM players
   WHERE strftime('%Y', final_game) = '2022'
ORDER BY first_name, last_name;

-- Exercise 10: List players taller than average height, tallest average first
  SELECT first_name, last_name
    FROM players
   WHERE height > (SELECT AVG(height) FROM players)
ORDER BY (SELECT AVG(height) FROM players) DESC, first_name, last_name;
