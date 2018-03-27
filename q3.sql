
SET SEARCH_PATH TO carschema;
drop table if exists q3 cascade;

-- You must not change this table definition.

create table q3(
MODEL_NAME VARCHAR(50)
);



DROP VIEW IF EXISTS completed_2017_reser CASCADE;
create view completed_2017_reser as
	select id as reservation_id, from_date, to_date, car_id, status 
	from reservation 
	where status = 'Completed' and
		from_date >= '2017-01-01' and
		to_date < '2018-01-01'
	;


DROP VIEW IF EXISTS toronto_station CASCADE;
create view toronto_station as
	select * 
	from rental_station
	where city = 'Toronto';


DROP VIEW IF EXISTS completed_2017_toronto_reser CASCADE;
create view completed_2017_toronto_reser as
select distinct * 
from completed_2017_reser
		Natural Join
	(select id as car_id, station_code, model_id 
		from car) as car
		Natural Join
	(select station_code from toronto_station) toronto_station
;


DROP VIEW IF EXISTS model_rent_count CASCADE;
create view model_rent_count as
select model_id, count(model_id) as model_rented_times
from completed_2017_toronto_reser
group by model_id;


-- debug info
-- select model_name, model_rented_times
-- 	from model_rent_count
-- 			Natural join
-- 		 (select id as model_id, name 
-- 		 	as model_name from model) model
-- 	order by model_rented_times DESC, model_name


-- the answer to the query 
insert into q3 (
	select model_name
	from model_rent_count
			Natural join
		 (select id as model_id, name 
		 	as model_name from model) model
	order by model_rented_times DESC, model_name
	limit 1
);

