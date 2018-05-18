--Bei Eingabe von Buch_ID wird die Kategorie ausgegeben
CREATE OR REPLACE PROCEDURE get_cat_name(in_book_id IN NUMBER, out_cat_name OUT VARCHAR2 ) 
AS  

	v_cat_name lib_category.cat_name%TYPE; 
 
BEGIN  
	SELECT cat_name INTO v_cat_name  
	FROM lib_book b   
	INNER JOIN lib_category c ON (b.cat_id = c.cat_id)  
	WHERE book_id = in_book_id; 
 
	out_cat_name := v_cat_name; 
 
EXCEPTION  
	WHEN NO_DATA_FOUND THEN   
	RAISE_APPLICATION_ERROR(-20009,'Buch nicht vorhanden');  
	WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20010,'proc:get_cat_name: '|| substr(SQLERRM,1,80)); 
	
END;
/


DECLARE
	v_ok VARCHAR2(30);
BEGIN
	get_cat_name(4, v_ok);
	DBMS_OUTPUT.PUT_LINE(v_ok);
END;
/

--Prozedur, die bei Eingabe einer lend_id das aktuellste Ausleihdatum für diesen Kunden zurückgibt. 
--Rufe die Prozedur auf und lasse dir das aktuellste Ausleihdatum für den Kunden mit der lend_id 3 ausgeben 
CREATE OR REPLACE PROCEDURE ausleihe_p (lend_id_in IN Number, lend_out OUT DATE)
AS
	v_lend lib_rental.lend%TYPE;

BEGIN 

	select max(lend) into v_lend
	from lib_rental
	where l_id=lend_id_in;
	
	
	DBMS_OUTPUT.PUT_LINE('Kunde mit der Nr: ' || lend_id_in || ' Ausleihdatum: ' || v_lend);
	
		
EXCEPTION
	WHEN no_data_found THEN
		RAISE_APPLICATION_ERROR (-20050, '.... nicht vorhanden' ); 
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20060,'Problem:'||'....: '|| substr(SQLERRM,1,80));

END;
/

DECLARE
	v_ok DATE;
BEGIN
	ausleihe_p(3, v_ok);
	DBMS_OUTPUT.PUT_LINE(v_ok);
END;
/


----bei Eingabe von pub_id wird dazu die Stadt ausgegeben
CREATE OR REPLACE FUNCTION get_c_name(in_pub_id IN NUMBER)  
RETURN varchar2 
AS  
	v_c_name lib_city.name%TYPE; 
 
BEGIN  
	SELECT c.name INTO v_c_name  
	FROM lib_city c   
	INNER JOIN lib_publisher p ON (c.c_id = p.c_id)  
	WHERE pub_id = in_pub_id; 
 
	RETURN v_c_name; 
 
EXCEPTION  
	WHEN NO_DATA_FOUND THEN   
	RAISE_APPLICATION_ERROR(-20009,'Publisher nicht vorhanden');  
	WHEN OTHERS THEN     RAISE_APPLICATION_ERROR(-20010,'proc'||    'get_cat_name: '|| substr(SQLERRM,1,80)); 
END; 
/

select get_c_name(4)
from dual;


---Funktion, die bei Eingabe einer Autor-ID die insgesamt veröffentlichten Seiten des Autors ausgibt. 
CREATE OR REPLACE FUNCTION function_name (autor_id_in IN NUMBER)
RETURN NUMBER 
AS 
	v_pages lib_book.pages%TYPE;
BEGIN  
		select sum(pages) into v_pages
		from lib_book b
		inner join lib_did_write dw on b.book_id=dw.book_id
		inner join lib_author a on dw.auth_id=a.auth_id
		where a.auth_id=autor_id_in
		group by autor_id_in;
		
		RETURN v_pages;
		
EXCEPTION
		WHEN NO_DATA_FOUND THEN   
		RAISE_APPLICATION_ERROR(-20009,'Autor nicht gefunden');  
		WHEN OTHERS THEN     
		RAISE_APPLICATION_ERROR(-20010,'ERROR: '|| substr(SQLERRM,1,80)); 

END; 
/

select function_name(18)
from dual;



















































