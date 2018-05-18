--1.)
select column_name, constraint_name
from user_cons_columns
where constraint_name in (select constraint_name	
							from user_constraints
							where table_name like 'lib_rental'
							and constraint_type like 'P');





















