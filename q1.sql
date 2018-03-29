SET SEARCH_PATH TO carschema;
drop table if exists q1 cascade;

-- You must not change this table definition.

create table q1 (
	email VARCHAR(100),
	cancel_ratio REAL
);

--find all invalid changed reservations
drop view if exists old_cancelled_reserv cascade;
create view old_cancelled_reserv as
	select r1.id, r1.from_date, r1.to_date, r1.car_id, r1.old_reservation_id, r1.status
	from reservation r1 join reservation r2
		on r1.id = r2.old_reservation_id
	where r1.status = 'Cancelled' and 
	      r2.status <> 'Cancelled';

--link reservation id, customer email and reservation status together, 
--exclusive of the changed reservations
drop view if exists email_reserv cascade;
create view email_reserv as
	select customer_email as email, id, t.status
	from (select * from reservation except select * from old_cancelled_reserv) t join customer_reservation
		on id = reservation_id;

--count the number of cancelled reservations of each customer
drop view if exists num_cancelled_reserv cascade;
create view num_cancelled_reserv as
	select email, count(id) as cancelled
	from email_reserv
	where status = 'Cancelled'
	group by email;

--count the number of uncancelled(normal) reservations of each customer
drop view if exists num_normal_reserv cascade;
create view num_normal_reserv as
	select email, count(id) as normal
	from email_reserv
	where status = 'Completed' or
		  status = 'Confirmed' or
		  status = 'Ongoing'
	group by email;

--combine these two tables
drop view if exists email_can_norm cascade;
create view email_can_norm as
	select *
	from num_cancelled_reserv c natural full join num_normal_reserv n;

--calculate the ratios
drop view if exists ratios cascade;
create view ratios as
	select email, 
		case 
			when e.cancelled is null then 0.0
			when e.normal is null then e.cancelled
			else e.cancelled*1.0/e.normal
		end as cancel_ratio
	from email_can_norm e;

--select the top 2 ratios with emails
drop view if exists top_two_ratios cascade;
create view top_two_ratios as
	select email, cancel_ratio
	from ratios
	order by cancel_ratio desc, email
	limit 2;

-- the answer to the query 
insert into q1 (
	select * from top_two_ratios
);

