SET SEARCH_PATH TO carschema;
drop table if exists q4 cascade;

create table q4(
	customer_email varchar(50)
);

-- find changed reservations by customer under 30 in recent 18 months
drop view if exists changed_reserv cascade;
create view changed_reserv as
	select r1.id, c.email, r1.from_date
	from reservation r1 join reservation r2
			on r1.id = r2.old_reservation_id and
			   extract(month from r1.from_date) >= extract(month from current_timestamp) - 18
		join customer_reservation cr
			on cr.reservation_id = r1.id
		join customer c
			on c.age < 30 and c.email = cr.customer_email;

-- count the number of changed reservations
drop view if exists count_changed_reserv cascade;
create view count_changed_reserv as
	select email, count(id) as num
	from changed_reserv
	group by email;


-- the answer to the query 
insert into q4 (
	select email
	from count_changed_reserv
	where num >= 2
);

