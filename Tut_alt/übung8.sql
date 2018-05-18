--Analysiere den untenstehenden anonymen PL/SQL-Codeblock. Was macht er? 
--Passe den Block so an, dass außerdem der Name des Kunden mit der ID 9 ausgegeben wird 
DECLARE  
v_lend  lib_rental.lend%TYPE;   
v_surname lib_lender.surname%TYPE;
v_date_diff NUMBER; 

BEGIN   
	SELECT MAX(lend), surname INTO v_lend, v_surname
	FROM   lib_rental r
	INNER JOIN lib_lender l on r.lend_id=l.lend_id
	WHERE  r.lend_id = 9   
	GROUP BY r.lend_id, surname;
 
	v_date_diff := TRUNC(sysdate – v_lend); 
 
	DBMS_OUTPUT.PUT_LINE('Kunde ' || v_surname || ' mit der ID 9 hat seit : '||v_date_diff || ' Tagen keine Bücher mehr ausgeliehen'); 
  
EXCEPTION   
	WHEN NO_DATA_FOUND THEN    
		RAISE_APPLICATION_ERROR(-20001, 'Kunde mit der ID 9 hat bisher keine Bücher ausgeliehen!');   
	WHEN OTHERS THEN    
		DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ' || substr(sqlerrm,1,80));    
END;
/

/*Anonymer Block: Das heutige Datum wird von dem letzten Ausleihdatum des Kunden mit der ID 9 abgezogen.
so wird ermittelt, wie viel Tage seitdem vergangen sind.
*/




--Schreibe einen anonymen Codeblock, der den Titel und das Erscheinungsjahr des Buches mit der book_id 2 ausgibt. 
DECLARE
	v_title lib_book.title%TYPE;
	v_year lib_book.year%TYPE;
BEGIN

	select title, year into v_title, v_year
	from lib_book
	where book_id=2;
	
	
	if v_year <= 2018-15 THEN
	DBMS_OUTPUT.PUT_LINE('Klassiker: ' || v_title || ' ' ||v_year );
	else
	DBMS_OUTPUT.PUT_LINE('Klassiker: ' || v_title || ' ' ||v_year );
	end if;

EXCEPTION
	WHEN NO_DATA_FOUND THEN    
		RAISE_APPLICATION_ERROR(-20089, 'Buch existiert nicht!');   
	WHEN OTHERS THEN    
		DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ' || substr(sqlerrm,1,80));    
END;
/


--Alle Verleger aus Köln raussuchen von denen ausgabejahr, titel und Seitenzahl ausgeben
DECLARE  

	CURSOR cur_book (pub_id_in NUMBER) 
	IS   
	SELECT title, year, pages  
	FROM lib_book   
	WHERE pub_id = pub_id_in   
	ORDER BY year ASC; 
	
BEGIN  
	DBMS_OUTPUT.PUT_LINE('Liste aller Verleger in Koeln');  
	DBMS_OUTPUT.PUT_LINE('____________________________________________'); 
	
	FOR rec_pub IN (SELECT pub_name, pub_id 
					FROM lib_city c          
					INNER JOIN lib_publisher p ON (c.c_id = p.c_id)          
					WHERE UPPER(name) = 'KOELN') LOOP 
					
					DBMS_OUTPUT.PUT_LINE(rec_pub.pub_name||'; ID: ' || rec_pub.pub_id); 
					FOR rec_book IN cur_book(rec_pub.pub_id) LOOP    
					DBMS_OUTPUT.PUT_LINE('---'||rec_book.year || ' ' || rec_book.title || ' ' || 'Seitenzahl:  ' || rec_book.pages);   
					END LOOP;   
					DBMS_OUTPUT.PUT_LINE('---');  
	END LOOP; 
END;
/


--der für den Kunden mit der ID 9 ausgibt, welche Bücher (title und year) wann ausgeliehen (lend) und zurückgegeben (return) wurden. 
--wenn rückgabedatum leer, dann lend+31
DECLARE
	Cursor cur_id is
	select title, year, lend, rückgabe 
	from lib_book b
	inner join lib_contains c on b.book_id=c.book_id
	inner join lib_rental r on c.l_id=r.l_id
	where lend_id =9;
	
BEGIN
		FOR REC_CUR IN Cur_id 
		LOOP
			IF rückgabe is null THEN
			rec_cur.rückgabe := lend + interval '31' day
			DBMS_OUTPUT.PUT_LINE('Kunde mit der ID 9 hat das Buch : ' ||rec_cur.title || ' ' || rec_cur.year ||' am: ' || rec_cur.lend || ' ausgeliehen, und gibt es vorauss. am : ' ||  rec_cur.rückgabe || ' zurück. ');
			Else 
			DBMS_OUTPUT.PUT_LINE('Kunde mit der ID 9 hat das Buch : '|| rec_cur.title || ' ' || rec_cur.year ||' am: ' || rec_cur.lend || ' ausgeliehen, und hat es am : ' ||  rec_cur.rückgabe || ' zurückgegeben. ');
			END IF;
		END LOOP;
END;
/??????????????????????????






























