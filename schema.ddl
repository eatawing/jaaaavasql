--  1. What constraints from the domain could not be enforced?
 
--  2. What constraints that could have been enforced were not enforced? Why not?
--     1) We could have added a constraint that each customer must have a valid driver's license,
--        however, there is no information about that in the databse.
--     2) The total rental time shall not exceeds certain length, but we don't have information about
--        the company's policy of that.
--     3) All reservations shall not be shared by a number of people that exceeds the car's capacity.
--        However, this requires assertion that might be too costly.
--     4) All cars cannot be rented for more than once in the same time. The problem is the same as 3).
--     5) Rental station area code shall match the city where it locates. But we don't have relevant 
--        database to enforce the constraint.
 
--------------------------------------------------------
drop schema if exists carschema cascade;
create schema carschema;

set search_path to carschema;

--------------------------------------------------------

-- records all registered customers
create table customer(
    -- customer full name
    name VARCHAR(100) not null,
    -- customer age
    age INT not null,
    -- customer registered email, used as customer ID and primary key
    email VARCHAR(50) PRIMARY KEY
);

-- records all car models avaiable
-- there can be multiple number of vehicles of each model
create table model(
    -- model id
    id INT PRIMARY KEY,
    -- model name
    name VARCHAR(50) not null,
    -- type of vehicle (eg. SUV, Sports, Economy, etc.)
    vehicle_type VARCHAR(30) not null,
    -- model number
    model_number INT not null,
    -- number of seats
    capacity INT not null,
    -- the capaity of the car should not be less than 1 seat
    check(capacity > 0),
    -- check that each model is inserted to the relation only once
    unique(name, vehicle_type, model_number, capacity)
);

-- records information of rental stations
CREATE TABLE rental_station(
    -- station code, used as primary key
    station_code INT primary key,
    -- the name of the station
    name VARCHAR(50) NOT NULL UNIQUE,
    -- the address of the station
    address VARCHAR(100) NOT NULL,
    -- the area code of the station
    area_code VARCHAR(10) NOT NULL,
    -- the name of the city where the station locates
    city VARCHAR(50) NOT NULL
);

-- records information of cars available for rental
create table car(
    -- car id, priarmy key
    id INT PRIMARY KEY,
    -- the license plate number of the car
    license_plate_number VARCHAR(10) not null unique,
    -- the rental station to which the car belongs
    station_code INT REFERENCES rental_station(station_code),
    -- the model ID of the car
    model_id INT REFERENCES model(id),
);

-- reserv_status is a type for reservation status
CREATE TYPE reserv_status AS ENUM('Confirmed', 'Ongoing', 'Completed', 'Cancelled');

-- records car reservation information
create table reservation(
    -- reservation ID
    id INT PRIMARY KEY,
    -- the time and date of when the car was/to be picked up
    from_date TIMESTAMP not null,
    -- the time and date of when the car was/to be returned
    to_date TIMESTAMP not null,
    -- the car ID of this reservation
    car_id INT references car(id),
    -- if a reservation is changed, it records the old reservation id,
    -- unless it remains NULL 
    old_reservation_id INT references reservation(id),
    -- reservation status
    status reserv_status not null,
    -- make sure that return date is not earlier than pick up date
    check(from_date < to_date)
);

-- records the customer of each reservation
-- there can be shared reservations, i.e. each reservation can be related to multiple customers
CREATE TABLE customer_reservation(
    -- email of customer who created the reservation
    customer_email VARCHAR(50) REFERENCES Customer(email),
    -- the reservation id
    reservation_id INT REFERENCES Reservation(id),
    -- make sure that each entrie is only inserted once
    UNIQUE(customer_email, reservation_id)
);


