-- Exercise 1: List each year's average salary, most recent year first
  SELECT year, ROUND(AVG(salary), 2) AS "average salary"
    FROM salaries
GROUP BY year
ORDER BY year DESC;

-- Exercise 2: List Cal Ripken's salary by year, most recent first
  SELECT year, salary
    FROM salaries
   WHERE player_id =
         (SELECT id
            FROM players
           WHERE first_name = 'Cal'
             AND last_name = 'Ripken')
ORDER BY year DESC;

-- Exercise 3: List Ken Griffey (b. 1969)'s home runs by year, most recent first
  SELECT year, HR AS "home runs"
    FROM performances
   WHERE player_id =
         (SELECT id
            FROM players
           WHERE first_name = 'Ken'
             AND last_name = 'Griffey'
             AND birth_year = 1969)
ORDER BY year DESC;

-- Exercise 4: List all players' 2001 salaries, lowest first
  SELECT first_name, last_name, salary
    FROM
        (SELECT id, first_name, last_name
           FROM players) AS minplayers
         INNER JOIN salaries
         ON minplayers.id = salaries.player_id
   WHERE year = '2001'
ORDER BY salary, first_name, last_name, player_ID
   LIMIT 50;

-- Exercise 5: List teams Satchel Paige played for
SELECT name
  FROM teams
 WHERE id IN
       (SELECT team_id
          FROM performances
         WHERE player_id =
               (SELECT id
                  FROM players
                 WHERE first_name = 'Satchel'
                   AND last_name = 'Paige'));

-- Exercise 6: List the 5 teams with the most hits in 2001
  SELECT name, SUM(H) AS "total hits"
    FROM performances
         INNER JOIN teams
         ON performances.team_id = teams.id
   WHERE performances.year = 2001
GROUP BY team_id
ORDER BY SUM(H) DESC
   LIMIT 5;

-- Exercise 7: Find the player with the highest salary
SELECT first_name, last_name
  FROM players
 WHERE id =
       (SELECT player_id
          FROM salaries
         WHERE salary = (SELECT MAX(salary) FROM salaries));

-- Exercise 8: Find the 2001 salary of the player with the most home runs
SELECT salary
  FROM salaries
 WHERE year = 2001
   AND player_id =
       (SELECT player_id
          FROM performances
         WHERE HR = (SELECT MAX(HR) FROM performances));

-- Exercise 9: List the 5 teams with the lowest average 2001 salary
  SELECT name, ROUND(AVG(salary), 2) AS "average salary"
    FROM salaries
         INNER JOIN teams
         ON teams.id = salaries.team_id
   WHERE salaries.year = 2001
GROUP BY team_id
ORDER BY AVG(salary)
   LIMIT 5;

-- Exercise 10: List every player's salary and home runs by year
  SELECT first_name, last_name, salary, HR, salaries.year
    FROM players
         INNER JOIN performances
         ON performances.player_id = players.id
         INNER JOIN salaries
         ON salaries.player_id = performances.player_id
            AND performances.year = salaries.year
ORDER BY players.id, salaries.year DESC, HR DESC, salary DESC;

-- Exercise 11: List the 10 best salary-per-hit values in 2001
  SELECT first_name, last_name, (salary / H) AS "dollars per hit"
    FROM players
         INNER JOIN performances
         ON players.id = performances.player_id
         INNER JOIN salaries
         ON performances.player_id = salaries.player_id
            AND performances.year = salaries.year
   WHERE performances.year = 2001
     AND H != 0
ORDER BY "dollars per hit", first_name, last_name
   LIMIT 10;

-- Exercise 12: List players who ranked in the top 10 for salary-per-hit and
-- salary-per-RBI in 2001, ordered by player id
SELECT first_name, last_name
  FROM
      (SELECT first_name, last_name, id
         FROM
             (SELECT first_name, last_name, players.id
                FROM performances
                     INNER JOIN players
                     ON players.id = performances.player_id
                     INNER JOIN salaries
                     ON salaries.player_id = players.id
                        AND performances.year = salaries.year
               WHERE performances.year = 2001
                 AND H > 0
             ORDER BY salary / H
                LIMIT 10)

       INTERSECT

       SELECT first_name, last_name, id
         FROM
             (SELECT first_name, last_name, players.id
                FROM performances
                     INNER JOIN players
                     ON players.id = performances.player_id
                     INNER JOIN salaries
                     ON salaries.player_id = players.id
                        AND performances.year = salaries.year
               WHERE performances.year = 2001
                 AND RBI > 0
             ORDER BY salary / RBI
                LIMIT 10))
 ORDER BY id;

-- Exercise 13: List friends common to two specific users
-- NOTE: parentheses around each INTERSECT side are intentionally omitted;
-- SQLite rejects a compound SELECT operand that starts with "(" (see
-- sqlite.org/lang_select.html and github.com/SeaQL/sea-query/issues/514).
SELECT friend_id
  FROM friends
 WHERE user_id =
       (SELECT id
          FROM users
         WHERE username = 'lovelytrust487')

INTERSECT

SELECT friend_id
  FROM friends
 WHERE user_id =
       (SELECT id
          FROM users
         WHERE username = 'exceptionalinspiration482');
