CREATE TABLE cipher (
    id      INTEGER NOT NULL,
    triplet INTEGER,
    number  INTEGER,
    PRIMARY KEY (id)
);

INSERT INTO cipher (triplet, number)
VALUES (1, 14), (1, 98), (1, 4),
       (2, 114), (2, 3), (2, 5),
       (3, 618), (3, 72), (3, 9),
       (4, 630), (4, 7), (4, 3),
       (5, 932), (5, 12), (5, 5),
       (6, 2230), (6, 50), (6, 7),
       (7, 2346), (7, 44), (7, 10),
       (8, 3041), (8, 14), (8, 5);

CREATE VIEW message AS
WITH prep AS (
    SELECT triplet,
           MAX(CASE WHEN tprow = 1 THEN number END) AS sentence_id,
           MAX(CASE WHEN tprow = 2 THEN number END) AS start,
           MAX(CASE WHEN tprow = 3 THEN number END) AS length
      FROM (SELECT triplet, number,
                   ROW_NUMBER() OVER (PARTITION BY triplet ORDER BY id) AS tprow
              FROM cipher)
  GROUP BY triplet
)
SELECT SUBSTR(sentences.sentence, start, length) AS phrase
  FROM prep
       INNER JOIN sentences
       ON sentences.id = sentence_id;
