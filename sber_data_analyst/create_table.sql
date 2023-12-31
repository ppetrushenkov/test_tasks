--Task 1
DROP TABLE IF EXISTS t;
CREATE TABLE IF NOT EXISTS t (
	key SERIAL PRIMARY KEY,
	id int,
	phone varchar,
	mail varchar
);

--Task 2
DROP TABLE IF EXISTS loans_table;
CREATE TABLE IF NOT EXISTS loans_table (
LOAN_ID int,
CLIENT_ID int,
LOAN_DATE date,
LOAN_AMOUNT float);

DROP TABLE IF EXISTS clients_table;
CREATE TABLE IF NOT EXISTS clients_table (
CLIENT_ID int,
CLIENT_NAME VARCHAR(20),
BIRTHDAY date,
GENDER VARCHAR(20));