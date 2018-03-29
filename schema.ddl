-- Schema for ？？？ (storing a subset of the Parliaments and Governments database)
-- available at https://www.avis.ca/
-- comment that answers these questions:
-- 1. What constraints from the domain could not be enforced?

-- 2. What constraints that could have been enforced were not enforced? Why not?


-- https://piazza.com/class/jc8j5fv9n7e39n?cid=787
-- check the age of customer > 0
-- check the number of seat > 0
-- make sure the customer have license
-- customers can not reserve a car that is not available in time he/ she want to reserve. (if the status is not cancelled)



drop schema if exists carschema cascade;
create schema carschema;

set search_path to carschema;


create table customer(
    name VARCHAR(50) not null,
    age INT not null,
    email VARCHAR(50) PRIMARY KEY
);

create table model(
    id INT PRIMARY KEY,
    name VARCHAR(50) not null,
    vehicle_type VARCHAR(20) not null,
    model_number INT not null,
    capacity INT not null,
    check(capacity > 0)
);


CREATE TABLE rental_station(
    station_code INT primary key,
    -- The name of the station
    name VARCHAR(50) NOT NULL UNIQUE,
    address VARCHAR(100) NOT NULL,
    area_code VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL
);


create table car(
    id INT PRIMARY KEY,
    license_plate_number VARCHAR(10) not null unique,
    station_code INT REFERENCES rental_station(station_code),
    model_id INT REFERENCES model(id),
);


CREATE TYPE reserv_status AS ENUM('Confirmed', 'Ongoing', 'Completed', 'Cancelled');


create table reservation(
    id INT PRIMARY KEY,
    from_date TIMESTAMP not null,
    to_date TIMESTAMP not null,
    car_id INT references car(id),
    old_reservation_id INT references reservation(id),
    status reserv_status not null,
    check(from_date <= to_date)
);

CREATE TABLE customer_reservation(
    customer_email VARCHAR(50) REFERENCES Customer(email),
    reservation_id INT REFERENCES Reservation(id),
    UNIQUE(customer_email, reservation_id)
);


