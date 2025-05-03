SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION category(bal IN NUMBER)
RETURN VARCHAR2 AS
    cat VARCHAR2(20);
BEGIN
    IF bal > 5000 THEN
        cat := 'platinum';
    ELSIF bal > 1000 THEN
        cat := 'gold';
    ELSE
        cat := 'silver';
    END IF;
    
    RETURN cat;
END;
/


BEGIN
    FOR customer IN (SELECT cid, bal FROM balance) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || customer.cid || ' | Balance: ' || customer.bal || ' | Category: ' || category(customer.bal));
    END LOOP; 
END;
/

