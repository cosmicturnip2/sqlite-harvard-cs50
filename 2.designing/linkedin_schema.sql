CREATE TABLE users (
    id         INTEGER NOT NULL,
    first_name TEXT    NOT NULL,
    last_name  TEXT    NOT NULL,
    username   TEXT    UNIQUE NOT NULL,
    password   TEXT    NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE schools (
    id       INTEGER NOT NULL,
    name     TEXT    UNIQUE NOT NULL,
    type     TEXT    NOT NULL,
    location TEXT,
    founded  INTEGER,
    PRIMARY KEY (id)
);

CREATE TABLE companies (
    id       INTEGER NOT NULL,
    name     TEXT    UNIQUE NOT NULL,
    industry TEXT    NOT NULL,
    location TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE followings (
    followed_id INTEGER NOT NULL REFERENCES users (id),
    follower_id INTEGER NOT NULL REFERENCES users (id),
    PRIMARY KEY (followed_id, follower_id)
);

CREATE TABLE school_affiliations (
    school_id  INTEGER NOT NULL REFERENCES schools (id),
    user_id    INTEGER NOT NULL REFERENCES users (id),
    start_date TEXT    NOT NULL,
    end_date   TEXT,
    degree     TEXT    NOT NULL,
    PRIMARY KEY (school_id, user_id)
);

CREATE TABLE company_affiliations (
    company_id INTEGER NOT NULL REFERENCES companies (id),
    user_id    INTEGER NOT NULL REFERENCES users (id),
    start_date NUMERIC NOT NULL,
    end_date   NUMERIC,
    title      TEXT    NOT NULL,
    PRIMARY KEY (company_id, user_id)
);
