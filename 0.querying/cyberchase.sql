-- Exercise 1: List episode titles from season 1
SELECT title
  FROM episodes
 WHERE season = 1;

-- Exercise 2: List season and title of the first episode in each season
SELECT season, title
  FROM episodes
 WHERE episode_in_season = 1;

-- Exercise 3: Find the production code for "Hackerized!"
SELECT production_code
  FROM episodes
 WHERE title = 'Hackerized!';

-- Exercise 4: List episode titles with no recorded topic
SELECT title
  FROM episodes
 WHERE topic IS NULL;

-- Exercise 5: Find the episode that aired on 2004-12-31
SELECT title
  FROM episodes
 WHERE air_date = '2004-12-31';

-- Exercise 6: List season 6 episodes that aired before 2008
SELECT title
  FROM episodes
 WHERE season = 6
   AND air_date < '2008-01-01';

-- Exercise 7: List episodes with "fractions" in their topic
SELECT title, topic
  FROM episodes
 WHERE topic LIKE '%fractions%';

-- Exercise 8: Count episodes that aired between 2018 and 2023
SELECT COUNT(*)
  FROM episodes
 WHERE air_date BETWEEN '2018-01-01' AND '2023-12-31';

-- Exercise 9: Count episodes that aired between 2002 and 2007
SELECT COUNT(*)
  FROM episodes
 WHERE air_date BETWEEN '2002-01-01' AND '2007-12-31';

-- Exercise 10: List id, title, and production code, ordered by production code
  SELECT id, title, production_code
    FROM episodes
ORDER BY production_code;

-- Exercise 11: List season 5 titles in reverse alphabetical order
  SELECT title
    FROM episodes
   WHERE season = 5
ORDER BY title DESC;

-- Exercise 12: Count the number of distinct episode titles
SELECT COUNT(DISTINCT title)
  FROM episodes;

-- Exercise 13: List each year aired, with the month/day the year began
  SELECT strftime('%Y', air_date), strftime('%m-%d', date(air_date, 'start of year'))
    FROM episodes
GROUP BY strftime('%Y', air_date);
