DROP TABLE IF EXISTS chef_booking;

DROP TABLE IF EXISTS chef_cuisine;

DROP TABLE IF EXISTS evaluation;

DROP TABLE IF EXISTS payment;

DROP TABLE IF EXISTS invoice;

DROP TABLE IF EXISTS room_schedule;

DROP TABLE IF EXISTS maintenance;

DROP TABLE IF EXISTS booking;

DROP TABLE IF EXISTS chef;

DROP TABLE IF EXISTS cuisine;

DROP TABLE IF EXISTS room;

DROP TABLE IF EXISTS customer;

DROP TABLE IF EXISTS theme;

CREATE TABLE cuisine (
    cuis_name VARCHAR(50) NOT NULL,
    cuis_rate NUMERIC(10, 2),
    CONSTRAINT pk_cuisine PRIMARY KEY (cuis_name)
);

CREATE TABLE customer (
    cust_id VARCHAR(10) NOT NULL,
    cust_lname VARCHAR(50),
    cust_fname VARCHAR(50),
    cust_busname VARCHAR(50),
    cust_streetnum NUMERIC(10),
    cust_streetname VARCHAR(50),
    cust_suburb VARCHAR(50),
    cust_phone VARCHAR(10),
    CONSTRAINT pk_customer PRIMARY KEY (cust_id)
);

CREATE TABLE room (
    room_id VARCHAR(10) NOT NULL,
    room_name VARCHAR(50),
    room_streetnum NUMERIC(10),
    room_streetname VARCHAR(50),
    room_suburb VARCHAR(50),
    room_capacity NUMERIC(8),
    room_kitchen CHAR(3),
    CHECK (room_kitchen IN ('YES', 'NO')),
    room_parking CHAR(3),
    CHECK (room_parking IN ('YES', 'NO')),
    room_rate NUMERIC(10, 2),
    CONSTRAINT pk_room PRIMARY KEY (room_id)
);

CREATE TABLE theme (
    theme_id VARCHAR(10) NOT NULL,
    theme_name VARCHAR(50),
    CONSTRAINT pk_theme PRIMARY KEY (theme_id),
    CONSTRAINT unq_theme_name UNIQUE (theme_name)
);

CREATE TABLE maintenance (
    main_id VARCHAR(10) NOT NULL,
    main_start DATE,
    main_finish DATE,
    room_room_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_maintenance PRIMARY KEY (main_id),
    CONSTRAINT fk_maintenance_room FOREIGN KEY (room_room_id) REFERENCES room (room_id)
);

CREATE TABLE booking (
    book_id VARCHAR(10) NOT NULL,
    book_sdate DATE NOT NULL,
    book_stime TIME NOT NULL,
    book_fdate DATE NOT NULL,
    book_ftime TIME NOT NULL,
    book_discount NUMERIC(8),
    book_guests NUMERIC(8) NOT NULL,
    book_baserate NUMERIC(10, 2),
    cuisine_cuis_name VARCHAR(50),
    room_room_id VARCHAR(10),
    theme_theme_id VARCHAR(10),
    customer_cust_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_booking PRIMARY KEY (book_id),
    CONSTRAINT fk_booking_cuisine FOREIGN KEY (cuisine_cuis_name) REFERENCES cuisine (cuis_name),
    CONSTRAINT fk_booking_customer FOREIGN KEY (customer_cust_id) REFERENCES customer (cust_id),
    CONSTRAINT fk_booking_room FOREIGN KEY (room_room_id) REFERENCES room (room_id),
    CONSTRAINT fk_booking_theme FOREIGN KEY (theme_theme_id) REFERENCES theme (theme_id),
    CONSTRAINT unq_date UNIQUE (book_sdate, book_stime)
);

CREATE TABLE chef (
    chef_id VARCHAR(8) NOT NULL,
    chef_lname VARCHAR(50) NOT NULL,
    chef_fname VARCHAR(50) NOT NULL,
    chef_phone VARCHAR(10) NOT NULL,
    chef_rate NUMERIC(10, 2),
    CONSTRAINT pk_chef PRIMARY KEY (chef_id)
);

CREATE TABLE invoice (
    inv_id VARCHAR(10) NOT NULL,
    inv_date DATE,
    inv_amount NUMERIC(10),
    booking_book_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_invoice PRIMARY KEY (inv_id),
    CONSTRAINT fk_invoice_booking FOREIGN KEY (booking_book_id) REFERENCES booking (book_id)
);

CREATE TABLE room_schedule (
    room_room_id VARCHAR(10) NOT NULL,
    maintenance_main_id VARCHAR(10) NOT NULL,
    booking_book_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_room_schedule PRIMARY KEY (maintenance_main_id, booking_book_id, room_room_id),
    CONSTRAINT fk_room_schedule_booking FOREIGN KEY (booking_book_id) REFERENCES booking (book_id),
    CONSTRAINT fk_room_schedule_maintenance FOREIGN KEY (maintenance_main_id) REFERENCES maintenance (main_id),
    CONSTRAINT fk_room_schedule_room FOREIGN KEY (room_room_id) REFERENCES room (room_id)
);

CREATE TABLE chef_booking (
    booking_book_id VARCHAR(10) NOT NULL,
    chef_chef_id VARCHAR(8) NOT NULL,
    chef_head VARCHAR(8),
    CONSTRAINT pk_chef_booking PRIMARY KEY (booking_book_id, chef_chef_id),
    CONSTRAINT fk_chef_booking_booking FOREIGN KEY (booking_book_id) REFERENCES booking (book_id),
    CONSTRAINT fk_chef_booking_chef FOREIGN KEY (chef_chef_id) REFERENCES chef (chef_id)
);

CREATE TABLE chef_cuisine (
    cuisine_cuis_name VARCHAR(50) NOT NULL,
    chef_chef_id VARCHAR(8) NOT NULL,
    chef_experience NUMERIC(3),
    CONSTRAINT pk_chef_cuisine PRIMARY KEY (cuisine_cuis_name, chef_chef_id),
    CONSTRAINT fk_chef_cuisine_chef FOREIGN KEY (chef_chef_id) REFERENCES chef (chef_id),
    CONSTRAINT fk_chef_cuisine_cuisine FOREIGN KEY (cuisine_cuis_name) REFERENCES cuisine (cuis_name)
);

CREATE TABLE evaluation (
    eval_date DATE NOT NULL,
    eval_pass CHAR(3) CHECK (eval_pass IN ('YES', 'NO')),
    eval_comment VARCHAR(250),
    room_room_id VARCHAR(10) NOT NULL,
    chef_chef_id VARCHAR(8) NOT NULL,
    CONSTRAINT pk_evaluation PRIMARY KEY (eval_date, room_room_id),
    CONSTRAINT fk_evaluation_chef FOREIGN KEY (chef_chef_id) REFERENCES chef (chef_id),
    CONSTRAINT fk_evaluation_room FOREIGN KEY (room_room_id) REFERENCES room (room_id)
);

CREATE TABLE payment (
    pay_id VARCHAR(10) NOT NULL,
    pay_date DATE,
    pay_amount NUMERIC(10),
    invoice_inv_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_payment PRIMARY KEY (pay_id, invoice_inv_id),
    CONSTRAINT fk_payment_invoice FOREIGN KEY (invoice_inv_id) REFERENCES invoice (inv_id)
);
