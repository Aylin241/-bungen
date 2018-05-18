--An wie vielen Tagen wurden bisher Bücher ausgeliehen? 
select count(lend)
from lib_rental;

--Welche Bücher (title, year, pages) haben mehr Seiten als der Durchschnitt der Bücher der Bibliothek? Ordne die Bücher 
--aufsteigend nach dem Titel und innerhalb des Titels absteigend nach dem Erscheinungsjahr. 
select title, year, pages 
from lib_book
where pages > (select avg(pages) 
				from lib_book)
 order by title asc, year desc;


--Erzeuge eine Ausgabe, in der jeder Autor (nur auth_id) mit der Anzahl der von ihm verfassten Bücher 
--gelistet wird. Dabei sollen nur Autoren berücksichtigt werden, deren Nachname (surname) länger als 9 Zeichen ist und die mehr als ein Buch verfasst haben. 
select a.auth_id, count(book_id) as Anzahl_bücher
from lib_author a 
inner join lib_did_write dw on a.auth_id=dw.auth_id
where length(surname)>9
group by a.auth_id;


--In welcher Stadt wurde mehr als ein Buch herausgegeben? Erzeuge eine Ausgabe, die die c_id der Stadt und die Anzahl der dort herausgegebenen Bücher beinhaltet. 
select c.c_id, count(*) as buch_anzahl
from lib_city c
inner join  lib_publisher p on (c.c_id = p.c_id)
inner join lib_book b on (b.pub_id = p.pub_id)
group by c.c_id
having count(*) > 1; 

--Ermittle für jedes Jahr, in dem Bücher erschienen sind, die in diesem Jahr veröffentlichten Buchseiten und ordne die Ausgabe absteigend nach der Seitenzahl. 
select year, sum(pages) page
from lib_book
group by year
order by page desc;


--Erstelle eine View, in der alle Kunden der Bibliothek (nur lend_id) mit Datum ihres aktuellsten Ausleihvorgangs (lend) erfasst werden. 
create or replace view last_rental
as
select lend_id, max(lend) max_lend
from lib_rental
group by lend_id;
--Ermittle mithilfe der View alle Kunden (forename, surname und Datum des letzten Ausleihvorgangs), die länger als 2 Jahre keine Bücher 
--mehr ausgeliehen haben. Lasse dir dabei das Datum des letzten Ausleihvorgangs im folgenden Format ausgeben: ddmm-yy.  
select l.forename, l.surname, to_char(r.max_lend,'dd-mm-yy') datum 
from lib_lender l 
inner join last_rental r on (l.lend_id = r.lend_id)
where TRUNC(sysdate)> TRUNC(max_lend) + interval '2' YEAR; 
























