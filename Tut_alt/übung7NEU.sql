--3.)
select a.forename, a.surname, ll.forename, ll.surname
from lib_author a
inner join lib_did_write dw on a.auth_id=dw.auth_id
inner join lib_contains c on dw.book_id=c.book_id
inner join lib_rental l on c.l_id=l.l_id
inner join lib_lender ll on l.lend_id=ll.lend_id
order by a.forename asc, ll.forename asc, a.surname desc, ll.surname desc;

--4.)
select lb.book_id
from lib_book lb
inner join lib_contains lc on lb.book_id=lc.book_id
group by lb.book_id
having count(*) in (select max(count(*))
					from lib_contains
					group by book_id);





















