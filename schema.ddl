-- Schema for ？？？ (storing a subset of the Parliaments and Governments database)
-- available at https://www.avis.ca/
-- comment that answers these questions:
-- 1. What constraints from the domain could not be enforced?
-- 2. What constraints that could have been enforced were not enforced? Why not?



drop schema if exists carschema cascade;
create schema carschema;

set search_path to carschema;