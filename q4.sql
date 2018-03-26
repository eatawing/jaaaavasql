SET SEARCH_PATH TO parlgov;
drop table if exists q1 cascade;

-- You must not change this table definition.

create table q1(
century VARCHAR(2),
country VARCHAR(50), 
left_right REAL, 
state_market REAL, 
liberty_authority REAL
);


-- You may find it convenient to do this for each of the views
-- that define your intermediate steps.  (But give them better names!)
DROP VIEW IF EXISTS election_winners CASCADE;

-- Define views for your intermediate steps here.

-- Define views for your intermediate steps here.
create view election_winners as
	select election.id as election_id , cabinet_party.party_id 
	from election join cabinet
			on election.id = cabinet.election_id 
		join cabinet_party
			on cabinet.id = cabinet_party.cabinet_id 
	where cabinet_party.pm = true;



DROP VIEW IF EXISTS opt_ER CASCADE;
-- filter useless information for election_result
create view opt_ER as
	select id as elec_re_id, election_id, party_id, alliance_id
	from election_result;


DROP VIEW IF EXISTS opt_ER_null CASCADE;
-- Add id to alliance_id
create view opt_ER_null as
	select is_null.elec_re_id, is_null.election_id, 
		 is_null.party_id, is_null.elec_re_id as alliance_id
	from (select *
		from opt_ER
		where alliance_id is null) as is_null;


DROP VIEW IF EXISTS opt_ER_new CASCADE;
-- create a new selection_re view
create view opt_ER_new as
(select * from opt_ER where alliance_id is not null)
union
(select * from opt_ER_null);



DROP VIEW IF EXISTS cout_position CASCADE;
-- cout position value for each alliance/party
create view count_position as
select  alliance_id, count(alliance_id) as num_member,
	avg(left_right) as left_right, avg(state_market) as state_market, 
	avg(liberty_authority) as liberty_authority
from opt_ER_new natural left join party_position
group by alliance_id;


DROP VIEW IF EXISTS opt_ER_with_position CASCADE;
-- the election result with position value
create view opt_ER_with_position as
select *
from opt_ER_new natural join count_position;


DROP VIEW IF EXISTS election_20_century CASCADE;
create view election_20_century as
SELECT id AS election_id, country_id, e_date FROM election
WHERE e_type = 'Parliamentary election' AND
	e_date >= '1901-01-01' AND
	e_date < '2001-01-01'
ORDER BY country_id, e_date;

DROP VIEW IF EXISTS election_21_century CASCADE;
create view election_21_century as
SELECT id AS election_id, country_id, e_date FROM election
WHERE e_type = 'Parliamentary election' AND
	e_date >= '2001-01-01' AND
	e_date < '2101-01-01'
ORDER BY country_id, e_date;


DROP VIEW IF EXISTS winning_result_with_position_20 CASCADE;
-- winning result
create view winning_result_with_position_20 as
select distinct *
from election_winners natural join opt_ER_with_position
	natural join election_20_century;

DROP VIEW IF EXISTS winning_result_with_position_21 CASCADE;
-- winning result
create view winning_result_with_position_21 as
select distinct *
from election_winners natural join opt_ER_with_position
	natural join election_21_century;

DROP VIEW IF EXISTS c20 CASCADE;
-- 20 century
create view c20 as
select '20'::VARCHAR(2) as century, country_id as id, avg(left_right) as left_right, avg(state_market) as state_market, 
	avg(liberty_authority) as liberty_authority
from winning_result_with_position_20
group by country_id;

DROP VIEW IF EXISTS c21 CASCADE;
-- 21 century
create view c21 as
select '21'::VARCHAR(2) as century, country_id as id, avg(left_right) as left_right, avg(state_market) as state_market, 
	avg(liberty_authority) as liberty_authority
from winning_result_with_position_21
group by country_id;



-- the answer to the query 
insert into q1 (
		(select  century, name as country, left_right, state_market, liberty_authority
		from c20 natural join country)
	union
		(select  century, name as country, left_right, state_market, liberty_authority
		from c21 natural join country)
);

