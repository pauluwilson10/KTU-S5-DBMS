CREATE OR REPLACE TRIGGER honor BEFORE INSERT OR DELETE OR UPDATE ON honors FOR EACH ROW



DECLARE
    message VARCHAR2(100); -- Use VARCHAR2 for PL/SQL strings
BEGIN
    IF DELETING THEN
        message := 'Deleted: ' || :old.name;
    ELSIF INSERTING THEN
        message := 'Inserting: ' || :new.name;
    ELSIF UPDATING THEN
        IF :new.name = :old.name THEN
            message := 'Updating: ' || :new.name;
        ELSE
            message := 'Updating: from ' || :old.name || ' to --> ' || :new.name;
        END IF;
    END IF;

    DBMS_OUTPUT.PUT_LINE(message);

END;
/
