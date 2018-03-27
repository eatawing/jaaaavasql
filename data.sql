

-- customer
insert into customer values ('Sofia Jan', 24, 'j.s@mail.com');
insert into customer values ('Atena Najm', 39, 'a.n@mail.com');
insert into customer values ('Malik Abdullah', 27, 'malik_aa@mail.com');
insert into customer values ('Ian Hsu', 41, 'shenian@mail.com');
insert into customer values ('David Chen', 45, 'dchen@mail.com');
insert into customer values ('Yu Chang', 42, 'y.c@mail.com');




-- model
insert into model values (1, 'BMW X5', 'SUV', 415, 5);
insert into model values (2, 'Mercedes E400', 'Luxury', 1848, 4);
insert into model values (8, 'Kia T21', 'Economy', 1221, 4);
insert into model values (4, 'Dodge Grand Caravan', 'Mini Van', 2210, 7);



-- rental_station
insert into rental_station values (1001, 'SuperCar College', '333 College St', '5T1P7', 'Toronto');
insert into rental_station values (1002, 'SuperCar Billy Bishop Airport', '200 Spadina Ave', 'M5V1A1', 'Toronto');
insert into rental_station values (1009, 'SuperCar West Montreal', '7000 Avenue Van Horne', 'H3S2B2', 'Montreal');
insert into rental_station values (1008, 'SuperCar North Montreal', '2351 Rue Masson', 'H1Y1V8', 'Montreal');


-- car
insert into car values (101, 'torc566', 1001, 1);
insert into car values (102, 'torc212', 1001, 8);
insert into car values (126, 'mowe502', 1009, 8);
insert into car values (123, 'mono202', 1008, 4);



-- reservation
insert into reservation values (22001, '2017-09-01 09:00:00', '2017-09-03 17:00:00', 101, NULL, 'Completed');
insert into reservation values (22002, '2018-03-17 16:00:00', '2018-03-25 16:00:00', 101, NULL, 'Cancelled');
insert into reservation values (22032, '2017-09-22 16:00:00', '2017-09-23 08:00:00', 126, NULL, 'Cancelled');
-- for shared reservation
insert into reservation values (22030, '2018-03-26 10:00:00', '2018-03-29 16:00:00', 123, NULL, 'Confirmed');



-- customer_reservation
insert into customer_reservation values ('j.s@mail.com', 22001);
insert into customer_reservation values ('s.hilbert@mail.com', 22002);
insert into customer_reservation values ('s.hilbert@mail.com', 22003);
insert into customer_reservation values ('a.n@mail.com', 22032);
insert into customer_reservation values ('malik_aa@mail.com', 22032);
-- for shared cus_reservation
insert into customer_reservation values ('shenian@mail.com', 22030);
insert into customer_reservation values ('dchen@mail.com', 22030);
insert into customer_reservation values ('y.c@mail.com', 22030);

-- insert into customer_reservation values ('ma.smith@mail.com', 22008);
-- insert into customer_reservation values ('jparki@mail.com', 22008);


-- CUSTORMIZED TEST CASE FOR cus_reservation

-- insert into reservation values (30000, '2018-03-26 10:00:00', '2018-03-29 16:00:00', 101, NULL, 'Confirmed');
-- insert into customer_reservation values ('shenian@mail.com', 30000);
-- insert into customer_reservation values ('j.s@mail.com', 30000);

-- insert into customer_reservation values ('dchen@mail.com', 30001);
-- insert into reservation values (30001, '2018-03-26 10:00:00', '2018-03-29 16:00:00', 126, NULL, 'Confirmed');
-- insert into customer_reservation values ('y.c@mail.com', 30001);




-- CUSTORMIZED TEST CASE FOR q3
insert into car values (116, 'otta101', 1002, 1);
insert into reservation values (30009, '2017-09-22 16:00:00', '2017-09-23 08:00:00', 116, NULL, 'Completed');


insert into car values (105, 'torbb10', 1002, 2);
insert into reservation values (30010, '2017-09-22 16:00:00', '2017-09-23 08:00:00', 105, NULL, 'Completed');



