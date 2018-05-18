--Wie heißt der Primary Key Constraint der Tabelle und für welche Spalte wurde er angelegt? 
select constraint_name, column_name, table_name
from user_cons_columns
where constraint_name IN (select constraint_name 
						  from user_constraints
						  where table_name like 'LIB_RENTAL' 
						  and constraint_type like 'P');

--Für welche Spalte der Tabelle „lib_rental“ wurde ein Foreign Key angelegt und welche Spalte in welcher Tabelle  wird referenziert? 
select constraint_name, column_name, table_name
from user_cons_columns
where constraint_name IN (select constraint_name 
						  from user_constraints
						  where table_name like 'LIB_RENTAL' 
						  and constraint_type like 'R');

--Welche Check Constraints wurden für die Tabelle „lib_rental! angelegt?
select constraint_name
from user_constraints
where table_name like 'LIB_RENTAL' 
and constraint_type like 'C';		  
						  
--Wurde für die Tabelle ein Unique Key Constraint angelegt? 					  
select constraint_name
from user_constraints
where table_name like 'LIB_RENTAL' 
and constraint_type like 'U';								  
						  
--Ermittle mithilfe eines SQL-Statements, aus welchen Spalten sich der Primary-Key der Tabelle lib_contains zusammensetzt. 
--Warum bezieht sich der Primary-Key hier nicht nur auf eine Spalte? 			  
select column_name, constraint_name
from user_cons_columns
where constraint_name like ( select constraint_name from user_constraints 
	                        where table_name like 'LIB_CONTAINS' 
							and constraint_type like 'P');						  
						  
--Wie viele Constraints existieren insgesamt im lib-Datenbankschema? 
select count (*)
from user_constraints
where table_name like 'LIB%';					  
						  
--Stelle mithilfe eines Constraints sicher, dass in einem Buchtitel in der Tabelle lib_book die Zeichen „?“ und „_“ nicht vorhanden sind. 	  
alter table lib_book
add constraint c_title 
check (title not like '%?%', '%_%');					  
				
--Welcher Constraint verhindert, dass in die Tabelle lib_category eine weitere Kategorie 
--eingefügt werden kann? ENTFERNE DEN CONSTRAINT. 
select constraint_name, search_condition
from user_constraints
where table_name like 'LIB_CATEGORY'
and constraint_type like 'C';
	
ALTER TABLE LIB_CATEGORY
DROP CONSTRAINT CAT_ID;















				
						  
