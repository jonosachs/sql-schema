# SQL Schema

Normalised SQL schema for a function center booking system.


## File structure


### Design

```text
normalisation.pdf       - Normalisation to 3NF
EER_diagram.pdf         - Logical level design, Enhanced Entity-Relationship diagram
```

### Schema

```text
01_schema.sql           - Creates all DB tables, drops existing tables
02_seed_psql.sql        - Seeds the DB with mock rows, deletes existing rows (Postgres)
02_seed_mysql.sql       - Seeds the DB with mock rows, deletes existing rows (MySQL)
```

## Running it with MySQL

### Create and seed the db

```bash
mysql -u root -e "CREATE DATABASE mydb;"
mysql -u root mydb < 01_schema.sql
mysql -u root mydb < 02_seed_mysql.sql
```

### Open in terminal

```bash
mysql -u root mydb
```

### Open in GUI

Open MySQL WorkBench and select mydb

## Running it with Postgres

### Create and seed the db

```text
createdb mydb 
psql -d mydb -f 01_schema.sql -f 02_seed_psql.sql
```

### Open in terminal

```bash
psql -d mybd
```

### Open in GUI:

Open in TablePlus etc. with a single command:

```bash
open "postgresql://user@localhost/mydb"
```
OR if passworded:

```bash
postgresql://user:password@localhost/mydb
```

## Debugging

Get user and port:

```bash
psql -d mydb -c "\conninfo"
```

Stop at the first error instead of cascading follow-on failures:

```text
psql -v ON_ERROR_STOP=1 -d mf -f mf_schema.sql

```

Get psql config path:

```bash
psql -tAc "SHOW hba_file;" postgres
```

## Known issues

- `room_schedule` duplicates room assignments already held by `booking` and `maintenance`, and the copies disagree (bookings 2 and 3).
- `room_schedule` has all three columns `NOT NULL` and in the PK, so it cannot record maintenance on a room with no booking.
- `chef_booking.chef_head` holds a chef id but has no foreign key, so invalid ids are accepted.
- `chef_head` belongs to the booking, not the chef/booking pair, so it repeats per row and breaks 2NF.
- `unq_date UNIQUE (book_sdate, book_stime)` allows only one booking company-wide per start time; it should include the room.
- Nothing prevents overlapping bookings in the same room, only identical start times.
- No check that a booking's finish is after its start.
- `booking.room_room_id` is nullable, yet room '1' is a "Customer House" placeholder; two conventions for the same thing.
- All money columns are `NUMERIC(8)`, which is scale 0, so `40.50` stores as `41`; should be `NUMERIC(10,2)`.
- `chef_phone NUMERIC(10)` drops the leading zero: `0400123123` stores as `400123123`; should be `VARCHAR`.
- `cust_streetnum NUMERIC(10)` cannot hold street numbers like "12A"; should be `VARCHAR`.
- `room_kitchen`, `room_parking` and `eval_pass` use `CHAR(3)` with a YES/NO check where `BOOLEAN` would do.
- `payment` PK is `(pay_id, invoice_inv_id)`, but the invoice is dependent on `pay_id`, so it is re
- The two CHECK constraints in `room` are unnamed, giving unhelpful error messages.
- No `ON DELETE` / `ON UPDATE` actions on any foreign key; all default to `NO ACTION`.
- No indexes on foreign key columns in the Postgres build; MySQL creates these automatically.
- Postgres and MySQL need separate seed files because MySQL's `TRUNCATE` takes one table at a time
