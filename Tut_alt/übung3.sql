--Ermittle, warum du INSERT-Rechte auf die Tabelle SCOTT.EMP und UPDATE-Rechte auf die Tabelle SCOTT.DEPT besitzt.
--Wurden die Tabellen-Rechte direkt an dich bzw. an PUBLIC vergeben?
SELECT Grantee, Privilege
FROM ALL_TAB_PRIVS
WHERE TABLE_SCHEMA= 'SCOTT' AND TABLE_NAME in ('EMP', 'DEPT'); --Die Rechte wurden an Public vergeben

--Welche Rollen besitzt du direkt? 
select username, granted_role
from user_role_privs; --FH_Trier 


--Welche Rollen sind diesen Rollen zugeordnet? 
select Role, granted_role
from ROLE_ROLE_PRIVS; --FH_Trier ist die Rolle WI_Student zugeordnet























