--Räume  Scott das Recht ein, alle Einträge in der Tabelle „lib_book“ anzusehen, 
--neue Zeilen einzufügen, Zeilen zu löschen und nur den Titel ändern zu dürfen  
grant select, insert, update(title)
on lib_book
to scott;

--Erstelle eine Namensliste, in der Vor- und Nachnamen aller Autoren und aller Kunden in einer Übersicht erfasst werden. 
--Sortiere die Liste aufsteigend nach Nachnamen und innerhalb des Nachnamens absteigend nach dem Vornamen. 
select a.forename, a.surname, ll.forename, ll.surname
from lib_author a
inner join lib_did_write dw on a.auth_id=dw.auth_id
inner join lib_contains c on dw.book_id=c.book_id
inner join lib_rental l on c.l_id=l.l_id
inner join lib_lender ll on l.lend_id=ll.lend_id
order by a.forename asc, ll.forename asc, a.surname desc, ll.surname desc;


--Welche Bücher (book_id) wurden bisher am häufigsten ausgeliehen? 
select lib_book.book_id
from lib_book
inner join lib_contains on lib_book.book_id=lib_contains.book_id
group by lib_book.book_id
having count(*) in (select max(count(*))
					from lib_contains
					group by book_id);















