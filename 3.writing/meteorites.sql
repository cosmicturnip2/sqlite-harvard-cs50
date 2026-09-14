-- Create temptable
CREATE TABLE IF NOT EXISTS temptable (
    name      TEXT,
    id        TEXT,
    nametype  TEXT,
    class     TEXT,
    mass      NUMERIC,
    discovery TEXT,
    year      INTEGER,
    lat       NUMERIC,
    long      NUMERIC
);

-- Import CSV into temptable
-- NOTE: requires the sqlite3 command-line shell specifically -- .import is a
-- shell dot-command, not standard SQL, and will not run through a plain SQL
-- driver or most other database clients.
-- .import --csv --skip 1 meteorites.csv temptable

-- Cleaning 1a: drop id column
ALTER TABLE temptable
DROP COLUMN id;

-- Cleaning 1b: remove nametype = 'Relict' rows, then drop nametype column
DELETE FROM temptable
      WHERE nametype = 'Relict';

ALTER TABLE temptable
DROP COLUMN nametype;

-- Cleaning 2: convert '' into NULL
UPDATE temptable
   SET mass = CASE WHEN mass = '' THEN NULL ELSE mass END,
       year = CASE WHEN year = '' THEN NULL ELSE year END,
       lat  = CASE WHEN lat = '' THEN NULL ELSE lat END,
       long = CASE WHEN long = '' THEN NULL ELSE long END;

-- Cleaning 3: round decimals
UPDATE temptable
   SET mass = ROUND(mass, 2),
       lat  = ROUND(lat, 2),
       long = ROUND(long, 2);

-- Create table meteorites
CREATE TABLE IF NOT EXISTS meteorites (
    id        INTEGER NOT NULL,
    name      TEXT,
    class     TEXT,
    mass      NUMERIC,
    discovery TEXT,
    year      INTEGER,
    lat       NUMERIC,
    long      NUMERIC,
    PRIMARY KEY (id)
);

-- Insert temptable into meteorites
INSERT INTO meteorites (name, class, mass, discovery, year, lat, long)
     SELECT name, class, mass, discovery, year, lat, long
       FROM temptable
   ORDER BY year, name;

-- Drop temptable
DROP TABLE temptable;
