CREATE TABLE ingredients (
    id         INTEGER NOT NULL,
    name       TEXT    UNIQUE NOT NULL,
    usd_per_g  NUMERIC NOT NULL
               CONSTRAINT usd_per_g_positive
               CHECK (usd_per_g > 0),
    PRIMARY KEY (id)
);

CREATE TABLE donuts (
    id     INTEGER NOT NULL,
    name   TEXT    UNIQUE NOT NULL,
    gluten TEXT    NOT NULL,
    price  NUMERIC NOT NULL
           CONSTRAINT price_positive
           CHECK (price > 0),
    PRIMARY KEY (id)
);

CREATE TABLE donuts_ingredients (
    donut_id      INTEGER NOT NULL REFERENCES donuts (id),
    ingredient_id INTEGER NOT NULL REFERENCES ingredients (id),
    PRIMARY KEY (donut_id, ingredient_id)
);

CREATE TABLE customers (
    id         INTEGER NOT NULL,
    first_name TEXT    NOT NULL,
    last_name  TEXT    NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE orders (
    id          INTEGER NOT NULL,
    customer_id INTEGER NOT NULL REFERENCES customers (id),
    PRIMARY KEY (id)
);

CREATE TABLE orders_donuts (
    order_id INTEGER NOT NULL REFERENCES orders (id),
    donut_id INTEGER NOT NULL REFERENCES donuts (id),
    PRIMARY KEY (order_id, donut_id)
);

CREATE TABLE customers_history (
    customer_id INTEGER NOT NULL REFERENCES customers (id),
    order_id    INTEGER NOT NULL REFERENCES orders (id),
    PRIMARY KEY (customer_id, order_id)
);
