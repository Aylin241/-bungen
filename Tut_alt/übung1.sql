--Welche Bücher (mit Titel und Erscheinungsjahr) wurden vom Heyne-Verlag herausgegeben? 
select year, title
from lib_book lb
inner join lib_publisher lp on lb.pub_id=lp.pub_id
where pub_name like 'Heyne';

--Welche Bücher (mit Titel und Erscheinungsjahr) wurden nicht von Verlegern aus Koeln herausgegeben? 
select b.title, b.year
from lib_book b
inner join lib_publisher.p on b.pub_id = p.pub_id
inner join lib_city c on c.c_id = p.c_id
where c.name NOT LIKE 'koeln'; 

--Zu welchen Kategorien sind keine Bücher vorhanden?
select cat_name
from lib_category
where cat_id not in (select cat_id
					from lib_book);

--Ermittle alle Jahre, in denen Bücher erschienen sind. 
select distinct year 
from lib_book 
where year is not null;


--Welche Bücher (Titel  und Erscheinungsjahr) wurden vom „Fischer“-Verlag herausgegeben oder gehören zur Kategorie „Fachbuch“?
select title, year
from lib_book b
inner join lib_publisher p on b.pub_id=p.pub_id
inner join lib_category c on b.cat_id=c.cat_id
where pub_name like 'Fischer' or cat_name like 'Fachbuch';


--Welche Bücher (mit Titel und Erscheinungsjahr) wurden von einem Autor verfasst, dessen Nachname mit „F“ beginnt und mit „ein“ endet? 
-- Achtung, es soll kein Buch mehrfach aufgelistet werden.
select distinct title, year
from lib_book b
inner join lib_did_write dw on b.book_id=dw.book_id
inner join lib_author a on dw.auth_id=a.auth_id
where surname like 'F%ein';





















