--1.)
insert into lib_rental(lend, l_id, lend_id)
values(sysdate, 17, (select lend_id
					from lib_lender
					where forename like 'Marina'));


--2.)
delete 
from lib_category
where cat_name like 'Kinderbuch';

--3.)
select title, year
from lib_book
where book_id not in (select book_id
						from lib_contains);

--4.)
update lib_publisher
set pub_name= 'Fischer'
where pub_name= 'Heyne';

--5.)
select title, year
from lib_book
where title like '_____-%';

--6.)
select forename, surname
from lib_lender
where lend_id in (select lend_id 
					from lib_rental
					where l_id in (select l_id 
									from lib_contains
									where book_id in (select book_id
														from lib_book
														where title like 'Investitionsrechnung')));
														
														
--7.)
update lib_book
set pages= pages-100
where title like 'Feuerstein';														
														
														
														
														
														
														
														
														
														
														
														
														
														
														
														
														
														
														
														
														
														
														

