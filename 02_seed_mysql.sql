-- Delete existing rows before re-populating, keeps the tables
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE customer;
TRUNCATE TABLE room;
TRUNCATE TABLE cuisine;
TRUNCATE TABLE theme;
TRUNCATE TABLE chef;
TRUNCATE TABLE booking;
TRUNCATE TABLE chef_booking;
TRUNCATE TABLE chef_cuisine;
TRUNCATE TABLE evaluation;
TRUNCATE TABLE maintenance;
TRUNCATE TABLE room_schedule;
TRUNCATE TABLE invoice;
TRUNCATE TABLE payment;
SET FOREIGN_KEY_CHECKS = 1;

-- Customer
INSERT INTO customer
VALUES ('161', 'Anchoro', 'Margaret', 'Monash University', NULL, NULL, NULL, NULL);

INSERT INTO customer
VALUES ('12', 'Natal', 'Wendy', NULL, NULL, NULL, NULL, NULL);

INSERT INTO customer
VALUES ('251', 'Wang', 'Pierre', NULL, NULL, NULL, NULL, NULL);

INSERT INTO customer
VALUES ('309', 'Sato', 'George', NULL, NULL, NULL, NULL, NULL);

INSERT INTO customer
VALUES ('102', NULL, 'Glen Eira', 'Caulfield City Council', NULL, NULL, NULL, NULL);

INSERT INTO customer
VALUES ('456', 'Acharya', 'Muriel', NULL, NULL, NULL, NULL, NULL);

-- Room
INSERT INTO room
VALUES ('12', 'Bay Watch Venue', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO room
VALUES ('25', 'Caulfield Sports Venue Hall', 123, 'Wide Rd', 'Caulfield', 80, 'YES', 'YES', NULL);

INSERT INTO room
VALUES ('27', 'The Tudor Room', 55, 'Narrow Lane', 'Caulfield', 40, 'YES', 'NO', NULL);

INSERT INTO room
VALUES ('1', 'Customer House', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Cuisine
INSERT INTO cuisine
VALUES ('Chinese', 30);

INSERT INTO cuisine
VALUES ('Western', NULL);

INSERT INTO cuisine
VALUES ('Japanese', NULL);

INSERT INTO cuisine
VALUES ('Indian', NULL);

-- Theme
INSERT INTO theme
VALUES (1, 'Birthday');

INSERT INTO theme
VALUES (2, 'Outdoor');

INSERT INTO theme
VALUES (3, 'For_All');

INSERT INTO theme
VALUES (4, 'Wedding');

INSERT INTO theme
VALUES (5, 'Kids');

-- Chef
INSERT INTO chef
VALUES ('12', 'Gilmore', 'Matt', 0400123123, NULL);

INSERT INTO chef
VALUES ('8', 'Kwong', 'Poh Ling', 0401010010, NULL);

-- Evaluation
INSERT INTO evaluation
VALUES (DATE '2021-06-11', 'NO', 'Several stoves in the kitchen are not working correctly, dishwasher non functional', '25', '12');

INSERT INTO evaluation
VALUES (DATE '2021-09-21', 'YES', NULL, '27', '8');

-- Booking
-- Params: book_id, book_sdate, book_stime, book_fdate, book_ftime, book_discount, book_guests, book_baserate, cuisine_cuis_name, room_room_id, theme_theme_id, customer_cust_id
INSERT INTO booking
VALUES (1, DATE '2021-11-02', TIME '18:00:00', DATE '2021-11-02', TIME '22:30:00', NULL, 60, 40, 'Chinese', '25', NULL, '161');

INSERT INTO booking
VALUES (2, DATE '2021-11-04', TIME '18:00:00', DATE '2021-11-04', TIME '22:00:00', NULL, 35, 65, 'Western', NULL, '1', '12');

INSERT INTO booking
VALUES (3, DATE '2021-11-06', TIME '19:00:00', DATE '2021-11-07', TIME '01:00:00', NULL, 30, 42, 'Chinese', '27', '2', '251');

INSERT INTO booking
VALUES (4, DATE '2021-11-06', TIME '19:30:00', DATE '2021-11-06', TIME '21:30:00', NULL, 70, 35, 'Japanese', '25', '2', '309');

INSERT INTO booking
VALUES (5, DATE '2021-11-07', TIME '18:00:00', DATE '2021-11-07', TIME '20:00:00', NULL, 56, 55, NULL, '12', '3', '102');

INSERT INTO booking
VALUES (6, DATE '2021-11-07', TIME '19:00:00', DATE '2021-11-08', TIME '01:00:00', NULL, 50, 60, 'Indian', NULL, '3', '456');

-- Chef booking
-- Params: book_id, chef_id
INSERT INTO chef_booking
VALUES ('1', '12', '12');

INSERT INTO chef_booking
VALUES ('1', '8', '12');

INSERT INTO chef_booking
VALUES ('2', '8', NULL);

-- Chef cuisine
-- Params: cuis_name, chef_id
INSERT INTO chef_cuisine
VALUES ('Chinese', '8', 4);

INSERT INTO chef_cuisine
VALUES ('Western', '8', 2);

INSERT INTO chef_cuisine
VALUES ('Chinese', '12', 10);

-- Maintenance
INSERT INTO maintenance
VALUES (1, DATE '2022-09-01', DATE '2022-09-10', '25');

INSERT INTO maintenance
VALUES (2, DATE '2022-09-12', DATE '2022-09-20', '27');

INSERT INTO maintenance
VALUES (3, DATE '2022-09-25', DATE '2022-10-02', '12');

-- Room schedule
-- Params: room_ID, main_ID, book_ID
INSERT INTO room_schedule
VALUES ('25', '1', '1');

INSERT INTO room_schedule
VALUES ('27', '2', '2');

INSERT INTO room_schedule
VALUES ('12', '3', '3');

INSERT INTO room_schedule
VALUES ('25', '1', '4');

-- Invoice
INSERT INTO invoice
VALUES (1, DATE '2021-11-10', 4875, '1');

INSERT INTO invoice
VALUES (2, DATE '2021-11-10', 3150, '2');

INSERT INTO invoice
VALUES (3, DATE '2021-11-12', 2640, '3');

INSERT INTO invoice
VALUES (4, DATE '2021-11-12', 5900, '4');

INSERT INTO invoice
VALUES (5, DATE '2021-11-16', 3280, '5');

INSERT INTO invoice
VALUES (6, DATE '2021-11-16', 4500, '6');

-- Payment
INSERT INTO payment
VALUES (1, DATE '2021-11-18', 4875, '1');

INSERT INTO payment
VALUES (2, DATE '2021-11-20', 5000, '4');

INSERT INTO payment
VALUES (3, DATE '2021-11-21', 900, '4');
