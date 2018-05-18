--Erfasse einen Ausleihvorgang für Marina Weller (Ausleihdatum heute – noch keine Rückgabe) 
--mit der l_id (Primärschlüssel) 17. Sie leiht sich die Bücher „Der Schwarm“ und „Limit“.  
insert into lib_rental(lend, l_id, lend_id)
values(sysdate,17,7);

--Lösche den Kategorie-Eintrag „Kinderbuch“ in der Tabelle lib_category. 
delete 
from lib_category
where cat_name like 'Kinderbuch';


--Welche Bücher (Titel und Erscheinungsjahr) wurden bisher noch nie ausgeliehen? 
select title,year
from lib_book
where book_id not in (select book_id 
						from lib_contains);


--Ändere bei allen Büchern, die von „Heyne“ herausgegeben wurden, den Verleger in „Fischer“ um. 
update lib_publisher
set pub_name= 'Fischer'
where pub_name= 'Heyne';


--Gebe alle Bücher aus (Titel und Erscheinungsjahr), deren Titel an sechster Stelle einen Bindestrich beinhaltet. 
 select title, year
 from lib_book
 where title like '_____-%';

--Welche Personen (Vorname und Nachname) haben sich bisher das Buch „Investitionsrechnung“ ausgeliehen? 
select forename, surname
from lib_lender l
inner join lib_rental r on l.lend_id=r.lend_id
inner join lib_contains c on r.l_id=c.l_id
inner join lib_book b on c.book_id=b.book_id
where title ='Investitionsrechnung';


select forename, surname
from lib_lender l
where l.lend_id in (select r.lend_id 
					from lib_rental r
					where r.l_id in	(select c.l_id 
									 from lib_contains c
									 where book_id in ( select b.book_id 
														from lib_book b
														where title like 'Investitionsrechnung')));

--Reduziere die Seitenzahl aller Bücher der Autoren mit dem Nachnamen „Feuerstein“ um 100. 
select b.book_id
from lib_book b
inner join lib_did_write dw on b.book_id=dw.book_id
inner join lib_author a on dw.auth_id=a.auth_id
where a.surname like 'Feuerstein';

Update lib_book b
set pages = pages-100
where book_id = 4 and book_id=15;














