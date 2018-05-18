--a1.)
select title,year
from lib_book lb
inner join lib_publisher lp on lb.pub_id=lp.pub_id
where upper(pub_name) like 'O%';

select title, year 
from lib_book
where pub_id in (select pub_id 
				from lib_publisher
				where upper(pub_name) like 'O%');

--a2.)
select forename, surname
from lib_author la
inner join lib_did_write ldw on la.auth_id=ldw.auth_id
inner join lib_book lb on ldw.book_id=lb.book_id
inner join lib_publisher lpp on lb.pub_id=lpp.pub_id
where year=2009 and pub_name like 'Heyne';

select forename, surname
from lib_author
where auth_id in (select auth_id 
					from lib_did_write
					where book_id in (select book_id	
										from lib_book
										where year=2009 and pub_id in(select pub_id
																		from lib_publisher	
																		where pub_name like 'Heyne')));

--a3.)
select pub_name
from lib_publisher
where pub_id not in (select pub_id
						from lib_book);

--b1.)
insert into lib_author(auth_id, forename, surname)
values(21, 'Max', 'Moeller');

insert into lib_did_write
values((select book_id
		from lib_book
		where title like 'Java 5'), 21);


--b2.)
delete 
from lib_city
where c_id not in (select c_id 
					from lib_publisher);

--b3.)
update lib_author
set forename= 'Peter'
where auth_id in (select auth_id
					from lib_did_write 
					where book_id in (select book_id 
										from lib_book
										where title like 'Limit'));


--c1.)		
Create Table lib_game(
g_id Number(4) not null,
g_name varchar2(30) not null,
g_date date not null,
price number(4,2));								
										
--c2.)
ALter table lib_game
add( usk number(2));							
										
--d1.)
select lp.pub_id, pub_name, sum(pages)
from lib_publisher lp
inner join lib_book lb on lp.pub_id=lb.pub_id
group by lp.pub_id, pub_name;									
										
--d2.)
update lib_book
set edition= edition+1
where year < 2018-10;										
										
										
--d5.)
select lcat.cat_id, count(*)
from lib_rental lr 
inner join lib_contains lc on lr.l_id=lc.l_id
inner join lib_book lb on lc.book_id=lb.book_id
inner join lib_category lcat on lb.cat_id=lcat.cat_id
where rückgabe is null
group by lcat.cat_id
order by count(*) desc;
										
--d6.)
alter table lib_rental
add constraint c_ruck
check (rückgabe is null or rückgabe >= lend);

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

