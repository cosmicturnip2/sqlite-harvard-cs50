-- Exercise 1: Find the drop-off address and type for a congratulatory package
SELECT address, type
  FROM addresses
 WHERE id =
       (SELECT address_id
          FROM scans
         WHERE action = 'Drop'
           AND package_id =
               (SELECT id
                  FROM packages
                 WHERE contents LIKE '%congratulatory%'));

-- Exercise 2 (first version): earlier attempt at the same result
SELECT (SELECT contents FROM packages WHERE from_address_id IS NULL), type
  FROM addresses
 WHERE id =
       (SELECT address_id
          FROM scans
         WHERE action = 'Drop'
           AND package_ID =
               (SELECT id
                  FROM packages
                 WHERE from_address_id IS NULL));

-- Exercise 2 (final version): contents and drop-off address type for
-- packages with no return address
SELECT packages.contents, addresses.type
  FROM packages
       INNER JOIN scans
       ON scans.package_id = packages.id
       INNER JOIN addresses
       ON addresses.id = scans.address_id
 WHERE packages.from_address_id IS NULL
   AND scans.action = 'Drop';

-- Exercise 3 (first version): earlier attempt at the same result
SELECT (SELECT contents
          FROM packages
         WHERE from_address_id =
               (SELECT id
                  FROM addresses
                 WHERE address = '109 Tileston Street')) AS contents,
       name
  FROM drivers
 WHERE id =
       (SELECT driver_id
          FROM scans
         WHERE action = 'Pick'
           AND package_ID =
               (SELECT id
                  FROM packages
                 WHERE from_address_id =
                       (SELECT id
                          FROM addresses
                         WHERE address = '109 Tileston Street'))
      ORDER BY timestamp DESC
         LIMIT 1);

-- Exercise 3 (final version): contents and driver of the most recent pickup
-- from a specific address
  SELECT packages.contents, drivers.name
    FROM packages
         INNER JOIN scans
         ON scans.package_id = packages.id
         INNER JOIN drivers
         ON drivers.id = scans.driver_id
   WHERE from_address_id =
         (SELECT id
            FROM addresses
           WHERE address = '109 Tileston Street')
     AND action = 'Pick'
ORDER BY scans.timestamp DESC
   LIMIT 1;
