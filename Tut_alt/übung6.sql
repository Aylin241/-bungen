--Welche Bücher (title, year) wurden von Verlegern herausgegeben, die mit „O“ beginnen? 
select title, year
from lib_book
where pub_id in (select pub_id
				from lib_publisher
				where pub_name like 'O%');


select title, year
from lib_book b
inner join lib_publisher p on b.pub_id=p.pub_id
where pub_name like 'O%';

--Welche Autoren (forename, surname) haben Bücher verfasst, die im Jahr 2009 veröffentlicht und von Heyne herausgegeben wurden? 
select forename, surname
from lib_author
where auth_id in (select auth_id
				from lib_did_write
				where book_id in (select book_id
								from lib_book
								where pub_id in (select pub_id
												from lib_publisher	
												where year=2009 and pub_name like 'Heyne')));


select forename, surname
from lib_author a
inner join lib_did_write dw on a.auth_id=dw.auth_id
inner join lib_book b on dw.book_id=b.book_id
inner join lib_publisher p on b.pub_id=p.pub_id
where b.year=2009 and p.pub_name='Heyne';

--Welcher Verleger (pub_name) hat keine Bücher veröffentlicht? 
select pub_name
from lib_publisher
where pub_id not in (select pub_id
					from lib_book);



----------------------------------------

--Lege einen neuen Autor „Max Moeller“ an. Wähle dabei eine Autor-ID, die bisher nicht vergeben wurde.
-- Trage ihn als zusätzlichen Autor für das Buch „Java 5“ ein. 
insert into lib_author
values(20, 'Max', 'Moeller');

insert into Lib_did_write
values(10, 20);

--Ändere den Vornamen des Autors, der Limit verfasst hat, in „Peter“ um. 
update lib_author
set forename = 'Peter'
where auth_id= 0;


select auth_id
from lib_author
where auth_id in (select auth_id
				from lib_did_write
				where book_id in ( select book_id
									from lib_book
									where title like 'Limit'));

-----------------------------------------

--Tabelle erstellen
Create Table lib_game (
g_id		NUMBER(4)		NOT NULL,
g_name		VARCHAR2(30)	NOT NULL,
g_date		DATE			NOT NULL,
price		NUMBER(4, 2)
);

--Füge eine Spalte „usk“ hinzu, in der die Altersbeschränkung (2-stellige Zahl) eingetragen werden soll. 
ALTER TABLE lib_game 
	ADD ( usk NUMBER(2) );
 

-- Tabelle CREDIT des Nutzers Richard im Schema „Richard“ 
--Wurden die Tabellen-Rechte direkt an dich bzw. an PUBLIC vergeben?  
SELECT GRANTEE, PRIVILEGE 
FROM ALL_TAB_PRIVS
WHERE TABLE_SCHEMA= 'Richard' 
	AND TABLE_NAME= 'CREDIT';

--Welche Rollen besitzt du direkt? 
select username, granted_role
from user_role_privs;

---------------------------------------------

--Wie viele Seiten hat jeder Verleger (pub_id, pub_name) insgesamt veröffentlicht? 
select p.pub_id, sum(pages)
from lib_publisher p
inner join lib_book b on p.pub_id=b.pub_id
group by p.pub_id;


--Erhöhe bei allen Büchern, deren Erscheinungsjahr mehr als 10 Jahre zurückliegt, die Edition um 1. 
update lib_book
set edition =edition+1
where year < 2017-10;


--Stelle sicher, dass in der Tabelle lib_rental das Rückgabedatum (return) eines Ausleihvorgangs entweder NULL oder größer/gleich dem Ausleihdatum (lend) ist
ALTER TABLE lib_rental
ADD CONSTRAINT const_ruck  
CHECK (    
			(rückgabe is null )
			or
			(rückgabe >= lend)
		);


















