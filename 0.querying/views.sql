-- Exercise 1: List Japanese and English titles of all views
SELECT japanese_title, english_title
  FROM views;

-- Exercise 2: Find the average color of Hokusai's river-themed views
SELECT average_color
  FROM views
 WHERE artist = 'Hokusai'
   AND english_title LIKE '%river%';

-- Exercise 3: Count Hokusai views mentioning Fuji
SELECT COUNT(*)
  FROM views
 WHERE artist = 'Hokusai'
   AND english_title LIKE '%Fuji%';

-- Exercise 4: Count Hiroshige views mentioning "Eastern Capital"
SELECT COUNT(*)
  FROM views
 WHERE artist = 'Hiroshige'
   AND english_title LIKE '%Eastern Capital%';

-- Exercise 5: Find the maximum contrast among Hokusai's views
SELECT MAX(contrast) AS 'Maximum Contrast'
  FROM views
 WHERE artist = 'Hokusai';

-- Exercise 6: Find Hiroshige's average entropy, rounded to 2 decimal places
SELECT ROUND(AVG(entropy), 2) AS 'Hiroshige Average Entropy'
  FROM views
 WHERE artist = 'Hiroshige';

-- Exercise 7: List Hiroshige's 5 brightest views
  SELECT english_title
    FROM views
   WHERE artist = 'Hiroshige'
ORDER BY brightness DESC
   LIMIT 5;

-- Exercise 8: List Hokusai's 5 lowest-contrast views
  SELECT english_title
    FROM views
   WHERE artist = 'Hokusai'
ORDER BY contrast
   LIMIT 5;

-- Exercise 9: Find the view(s) with the highest brightness
SELECT english_title, artist
  FROM views
 WHERE brightness = (SELECT MAX(brightness) FROM views);

-- Exercise 10: List views mentioning Fuji, with a descriptive column header
  SELECT english_title AS "How Many Times is Fuji Mentioned?", artist
    FROM views
   WHERE english_title LIKE '%Fuji%'
ORDER BY artist;
