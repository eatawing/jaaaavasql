-- Schema for ？？？ (storing a subset of the Parliaments and Governments database)
-- available at https://www.avis.ca/
-- comment that answers these questions:
-- 1. What constraints from the domain could not be enforced?
-- 2. What constraints that could have been enforced were not enforced? Why not?


drop schema if exists carschema cascade;
create schema carschema;

set search_path to carschema;

create table customer(
    name VARCHAR(50) not null,
    age INT not null,
    email VARCHAR(100) PRIMARY KEY
);

create table model(
    id INT PRIMARY KEY,
    name VARCHAR(50) not null,
    vehicle_type VARCHAR(20),
    model_number INT not null,
    capacity INT not null
);

create table rental_station(
    station_code INT PRIMARY KEY,
    name VARCHAR(50) not null,
    address VARCHAR(50) not null,
    area_code VARCHAR(10) not null,
    city VARCHAR(20) not null,
); 

create table car(
    id INT PRIMARY KEY,
    license_plate_number VARCHAR(10) not null unique,
    station_code INT references rental_station(id),
    model_id INT references model(id)
);

CREATE TYPE reserv_status AS ENUM('Confirmed', 'Ongoing', 'Completed', 'Cancelled');

create table reservation(
    id INT PRIMARY KEY,
    from_date TIMESTAMP not null,
    to_date TIMESTAMP not null,
    car_id INT references car(id),
    old_reservation_id INT references reservation(id),
    status reserv_status not null
);

CREATE TABLE customer_reservation(
    customer_email VARCHAR(50) REFERENCES customer(email),
    reservation_id INT REFERENCES reservation(id),
    UNIQUE(customer_email, reservation_id)
);