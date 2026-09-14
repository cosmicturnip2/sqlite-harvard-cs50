CREATE VIEW june_vacancies AS
  SELECT listings.id, property_type, host_name, COUNT(date) AS days_vacant
    FROM listings
         INNER JOIN availabilities
         ON listings.id = availabilities.listing_id
   WHERE date BETWEEN '2023-06-01' AND '2023-06-30'
     AND available = 'TRUE'
GROUP BY listings.id;

CREATE VIEW frequently_reviewed AS
  SELECT listings.id, property_type, host_name, COUNT(comments) AS reviews
    FROM listings
         INNER JOIN reviews
         ON listings.id = reviews.listing_id
GROUP BY listings.id
ORDER BY COUNT(comments) DESC, property_type, host_name
   LIMIT 100;
