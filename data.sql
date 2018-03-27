

-- customer
insert into customer values ('Sofia Jan', 24, 'j.s@mail.com');
insert into customer values ('Atena Najm', 39, 'a.n@mail.com');


-- model
insert into model values (1, 'BMW X5', 'SUV', 415, 5);
insert into model values (2, 'Mercedes E400', 'Luxury', 1848, 4);
insert into model values (8, 'Kia T21', 'Economy', 1221, 4);


-- rental_station
insert into rental_station values (1001, 'SuperCar College', '333 College St', '5T1P7', 'Toronto');
insert into rental_station values (1002, 'SuperCar Billy Bishop Airport', '200 Spadina Ave', 'M5V1A1', 'Toronto');
insert into rental_station values (1009, 'SuperCar West Montreal', '7000 Avenue Van Horne', 'H3S2B2', 'Montreal');

-- car
insert into car values (101, 'torc566', 1001, 1);
insert into car values (102, 'torc212', 1001, 8);
insert into car values (126, 'mowe502', 1009, 8);





-- reservation
insert into reservation values (22001, '2017-09-01 09:00:00', '2017-09-03 17:00:00', 101, NULL, 'Completed');
insert into reservation values (22002, '2018-03-17 16:00:00', '2018-03-25 16:00:00', 101, NULL, 'Cancelled');
insert into reservation values (22032, '2017-09-22 16:00:00', '2017-09-23 08:00:00', 126, NULL, 'Cancelled');



-- customer_reservation
insert into customer_reservation values ('j.s@mail.com', 22001);
insert into customer_reservation values ('a.n@mail.com', 22032);






