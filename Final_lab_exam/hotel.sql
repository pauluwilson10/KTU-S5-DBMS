
CREATE OR REPLACE PROCEDURE generate_bill(p_guest IN VARCHAR2) AS
    p_roomno          NUMBER;
    p_charge_per_day  NUMBER;
    p_check_in_date   DATE;
    p_check_out_date  DATE;
    p_billamount      NUMBER;
    p_unique_guest    NUMBER;
    p_total_revenue   NUMBER;
BEGIN
    -- Fetch guest details
    SELECT roomno, check_in_date, check_out_date 
    INTO p_roomno, p_check_in_date, p_check_out_date 
    FROM guest 
    WHERE name = p_guest;

    -- Fetch charge per day for the room
    SELECT charge_day 
    INTO p_charge_per_day 
    FROM room 
    WHERE roomno = p_roomno;

    -- Calculate the bill amount
    p_billamount := (p_check_out_date - p_check_in_date) * p_charge_per_day;

    -- Insert the bill into the BILL table
    INSERT INTO bill(name, billamount) 
    VALUES (p_guest, p_billamount);

    -- Update the history table
    INSERT INTO history(name, check_out_date) 
    VALUES (p_guest, p_check_out_date);

    -- Calculate the total revenue and unique guests for the current month, joining history for check_out_date
    SELECT SUM(billamount), COUNT(DISTINCT b.name) 
    INTO p_total_revenue, p_unique_guest
    FROM bill b	
    JOIN history h ON h.name = b.name
    WHERE EXTRACT(MONTH FROM h.check_out_date) = EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM h.check_out_date) = EXTRACT(YEAR FROM SYSDATE);

    -- Output the results
    DBMS_OUTPUT.PUT_LINE('The total revenue is: ' || p_total_revenue);
    DBMS_OUTPUT.PUT_LINE('The number of unique guests checked out is: ' || p_unique_guest);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for the specified guest or month.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END generate_bill;
/

-- Running the procedure:
SET SERVEROUTPUT ON;

ACCEPT p_name PROMPT 'Enter your name: ';
DECLARE
    p_name VARCHAR2(100) := '&p_name';
BEGIN
    -- Ensure the procedure 'generate_bill' is defined somewhere in your schema
    generate_bill(p_name);
END;
/
