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
