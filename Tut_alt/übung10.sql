--Bevor Isbn geändert wird, wenn die Neue ISBN NR ungleich dem Alten ist, wird Fehler ausgegeben
CREATE OR REPLACE TRIGGER lib_book_isbn_u 
BEFORE UPDATE of ISBN ON lib_book 
FOR EACH ROW 

DECLARE  
 
BEGIN  
	IF :NEW.ISBN != :OLD.ISBN THEN 
	RAISE_APPLICATION_ERROR(-20001, ‘ISBN darf nachträglich nicht geändert werden‘);  
	END IF;  
 
EXCEPTION  
	WHEN OTHERS THEN 
	RAISE_APPLICATION_ERROR(-20010,'Trigger lib_book_isbn_u' || substr(SQLERRM,1,80)); 
END; 
/
 
-- Trigger, der sicherstellt, dass ein Ausleihvorgang nur für einen Kunden angelegt werden kann, der aktuell Mitglied der Bücherei ist 
CREATE OR REPLACE TRIGGER Aus_kunde
BEFORE INSERT OR UPDATE ON LIB_RENTAL
FOR EACH ROW

DECLARE
 
	v_lid lib_rental.l_id%TYPE;
BEGIN
  SELECT l_id INTO v_lid
  FROM lib_rental
  WHERE lend_id in (select lend_id 
					from lib_lender);
					
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20100,'KEIN KUNDE');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20020,' Trigger: '|| SUBSTR(SQLERRM,1,80) );
END;
/

---??????
insert into lib_rental
values(sysdate, to_date('17.01.2018', 'dd.mm.yyyy'), 10, 20);


--Schreibe einen Trigger, der sicherstellt, dass beim Einfügen in lib_category als Kategorie-ID eine 
--fortlaufende Nummer aus einer Sequenz vergeben wird. Diese Nummer soll bei 5 beginnen. 
CREATE SEQUENCE seq_cat
START WITH 5
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER T_cat
BEFORE INSERT OR UPDATE OF cat_id ON lib_category
FOR EACH ROW
DECLARE

BEGIN

    :NEW.cat_id := seq_cat.NEXTVAL;
  
END;
/
 

























































