--1.)
select count(lend)
from lib_rental;

--2.)
select title, year, pages
from lib_book
where pages > (select avg(pages)
				from lib_book)
order by title asc, year desc;

--3.)
select count(*), ldw.auth_id
from lib_did_write ldw
inner join lib_author la on ldw.auth_id=la.auth_id
where length(surname) > 9
group by ldw.auth_id
having count(*) > 1;

--4.)
select count(*), lc.c_id
from lib_city lc
inner join lib_publisher p on lc.c_id=p.c_id
inner join lib_book lb on lb.pub_id=lb.pub_id
group by lc.c_id
having count(*)> 1;


--5.)
select year, sum(pages)
from lib_book
where year is not null
group by year
order by sum(pages) desc;

















