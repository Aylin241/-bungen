--1.)
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

--Umwandlung zur Prozedur /*wird berechnet seit wieviel Tagen der Kunde kein Buch ausgeliehen hat*/
Create or Replace Procedure p_lib (lend_id_in in NUMBER)
as
	v_lend  lib_rental.lend%TYPE;   
	v_surname lib_lender.surname%TYPE;
	v_date_diff NUMBER; 

BEGIN
	SELECT MAX(lend), surname INTO v_lend, v_surname
	FROM   lib_rental r
	INNER JOIN lib_lender l on r.lend_id=l.lend_id
	WHERE  r.lend_id = lend_id_in  
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

Declare 

Begin 
	p_lib(9);
End;
/

























