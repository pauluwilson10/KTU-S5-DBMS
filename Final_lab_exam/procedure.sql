 SET SERVEROUTPUT ON;
    ACCEPT train_no PROMPT 'Enter train number: ';
    ACCEPT choice PROMPT 'Enter Choice 1: reserve  2: cancel: ';
    ACCEPT seats_requested PROMPT 'Enter seats: ';
    DECLARE
        train_no NUMBER:=&train_no;
        choice NUMBER:=&choice;
        seats_requested NUMBER:=&seats_requested;
    BEGIN

            IF choice = 1 THEN
                reserve(train_no, seats_requested);
            ELSIF choice = 2 THEN
                cancel(train_no, seats_requested);
            ELSE
                DBMS_OUTPUT.PUT_LINE('Invalid choice');
            END IF;
    END;
    /

    CREATE OR REPLACE PROCEDURE reserve(train_no IN NUMBER, seat IN NUMBER) AS
        available NUMBER(20);
    BEGIN
        SELECT seats INTO available FROM railway WHERE tno = train_no;

        IF seat <= available THEN
            UPDATE railway SET seats = seats - seat WHERE tno = train_no;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Reservation made for ' || seat || ' seats');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Not enough seats available');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Invalid train number');
    END reserve;
    /

    -- Cancellation procedure
    CREATE OR REPLACE PROCEDURE cancel(train_no IN NUMBER, seat IN NUMBER) AS
    BEGIN
        UPDATE railway SET seats = seats + seat WHERE tno = train_no;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Cancellation successful for ' || seat || ' seats.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Invalid train number');
    END cancel;
    /


