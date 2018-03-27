
SET SEARCH_PATH TO carschema;
drop table if exists q3 cascade;

-- You must not change this table definition.

create table q3(
MODEL_NAME VARCHAR(50)
);



DROP VIEW IF EXISTS not_cancelled_reser CASCADE;
create view not_cancelled_reser as
	select id as reservation_id, car_id, status 
	from reservation 
	where status != 'Cancelled';


DROP VIEW IF EXISTS shared_reserv CASCADE;
create view shared_reserv as
	select reservation_id, count(customer_email) as shared_count
	from customer_reservation
			natural join
		not_cancelled_reser
	group by reservation_id
	having count(customer_email)>1;


-- Debug info
-- select * 
-- from customer_reservation
-- 			natural join
-- 	 not_cancelled_reser
-- 			natural join
-- 	 shared_reserv



-- the answer to the query 
insert into q3 (
);

