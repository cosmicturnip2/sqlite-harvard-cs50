# SQLite · Harvard CS50 SQL

Exercises and schema designs from Harvard's CS50 SQL course (edX), organized
by course module.

## Academic honesty

This repository contains my own solutions to CS50 SQL's problem sets,
shared for portfolio purposes after completing the course. If you are
currently enrolled in CS50, please review and follow
[CS50's Academic Honesty policy](https://cs50.harvard.edu/x/2023/honesty/)
before referring to any code here — submitting this work, or work derived
from it, as your own violates that policy.

## Style guide

SQL in this repository follows
[Simon Holywell's SQL Style Guide](https://www.sqlstyle.guide/), chosen for
being dialect-agnostic and broadly adopted across the industry.

## Structure

```
SQLite-Harvard_CS50/
├── 0.querying/      Filters, aggregations, ordering
│   ├── players.sql
│   ├── cyberchase.sql
│   └── views.sql
├── 1.relating/      Joins, sets, subqueries
│   ├── moneyball.sql
│   ├── dese.sql
│   └── packages.sql
├── 2.designing/     Schemas, constraints
│   ├── donut_shop_schema.sql
│   ├── linkedin_schema.sql
│   └── atl_airport_schema.sql
├── 3.writing/       Importing, updating, cleaning data
│   ├── meteorites.sql
│   └── pentest.sql
├── 4.viewing/       Views, CTEs, window functions
│   ├── cipher_message.sql
│   ├── listings_views.sql
│   └── census.sql
└── 5.optimising/    Indexes, query analysis
    └── indexes.sql
```

Each module folder contains one `.sql` file per dataset used in that
module's exercises.

## License

MIT — see [LICENSE](LICENSE)
