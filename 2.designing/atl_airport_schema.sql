CREATE TABLE passengers (
    id         INTEGER NOT NULL,
    first_name TEXT    NOT NULL,
    last_name  TEXT    NOT NULL,
    age        INTEGER,
    PRIMARY KEY (id)
);

CREATE TABLE airlines (
    id         INTEGER NOT NULL,
    name       TEXT    UNIQUE NOT NULL,
    concourses TEXT    NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE flights (
    id                INTEGER NOT NULL,
    number            TEXT    NOT NULL,
    airline_id        INTEGER REFERENCES airlines (id),
    departs_from_code TEXT    NOT NULL,
    arrives_to_code   TEXT    NOT NULL,
    departure_time    TEXT    NOT NULL,
    arrival_time      TEXT    NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE checkins (
    id           INTEGER NOT NULL,
    dateandtime  NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    passenger_id INTEGER REFERENCES passengers (id),
    flight_id    INTEGER REFERENCES flights (id),
    PRIMARY KEY (id)
);
