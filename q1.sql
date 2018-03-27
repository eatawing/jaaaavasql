SET SEARCH_PATH TO carschema;
drop table if exists q1 cascade;

-- You must not change this table definition.

create table q1 (
	email VARCHAR(100),
	cancel_ratio REAL
);

drop view if exists email_reserv cascade;
create view email_reserv as
	select customer_email as email, id
	from reservation join customer_reservation
		on id = reservation_id;

drop view if exists old_cancelled_reserv cascade;
create view old_cancelled_reserv as
	select r1.id, r1.from_date, r1.to_date, t1.car_id, r1.old_reservation_id, r1.status
	from reservation r1 join reservatin r2
		on r1.id = r2.old_reservation_id
	where r1.status = "Cancelled" and 
	      r2.status <> "Cancelled";

drop view if exists num_cancelled_reserv cascade;
create view num_cancelled_reserv as
	select email, count(id)
	from email_reservation except old_cancelled_reserv
	where status = "Cancelled"
	group by email;

drop view if exists num_normal_reserv cascade;
create view num_normal_reserv as
	select email, count(id)
	from email_reservation
	where status = "Completed" or
		  status = "Confirmed" or
		  status = "Ongoing"
	group by email;

drop view if exists email_can_norm cascade;
create view email_can_norm as
	select c.email, c.count as cancelled, n.count as normal
	from num_cancelled_reserv c full join num_normal_reserv n
		on c.email = n.email;

drop view if exists ratios cascade;
create view ratios as
	select email, (1.0*(case when cancelled = null then 0 else cancelled) /
		   1.0*(case when normal = null then 1 else normal)) as cancel_ratio
	from email_can_normal;

drop view if exists top_two_ratios cascade;
create view top_two_ratios as
	select email, cancel_ratio
	from ratios
	order by cancel_ratio desc, email
	limit 2;

-- the answer to the query 
insert into q1 (
	select * from top_two_ratios;
);

