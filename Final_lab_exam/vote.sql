SET SERVEROUTPUT ON;

-- Procedure to get the party with the maximum votes
CREATE OR REPLACE PROCEDURE get_max_votes_party AS
   max_party_id NUMBER;
   max_votes NUMBER;
BEGIN
   SELECT party, votes 
   INTO max_party_id, max_votes
   FROM result
   WHERE votes = (SELECT MAX(votes) FROM result);

   DBMS_OUTPUT.PUT_LINE('Party with maximum votes: PARTY ' || max_party_id);
   DBMS_OUTPUT.PUT_LINE('Number of votes: ' || max_votes);
END get_max_votes_party;
/

-- Trigger to update the result table after a valid vote is cast
CREATE OR REPLACE TRIGGER resultupdate
AFTER INSERT ON votes
FOR EACH ROW
BEGIN
    IF :new.validity = 'VALID' THEN
        UPDATE result 
        SET votes = votes + 1 
        WHERE party = :new.vchoice;
    END IF;
END resultupdate;
/

SET SERVEROUTPUT ON;
accept x prompt'enter user id';
accept y prompt 'enter password';
accept choice prompt 'enter party id';
-- Anonymous block to handle voting
DECLARE
    un VARCHAR2(20) := '&x';
    pw VARCHAR2(20) := '&y';
    choice NUMBER := &choice;
    valid NUMBER := 0;
    validchoice NUMBER := -1;
    actual_password VARCHAR2(20);
    actual_party NUMBER;
BEGIN
    BEGIN
        SELECT password INTO actual_password FROM voters WHERE voterid = un;
        IF actual_password = pw THEN
            valid := 1;
            DBMS_OUTPUT.PUT_LINE('Valid voter');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Incorrect password');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Voter ID not found');
    END;

    IF valid = 1 THEN
        BEGIN
            SELECT party INTO actual_party FROM candidate WHERE party = choice;
            validchoice := 1;
            DBMS_OUTPUT.PUT_LINE('Valid choice selected');
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                validchoice := 0;
                DBMS_OUTPUT.PUT_LINE('Invalid choice selected');
        END;
    END IF;

    IF validchoice = 1 THEN
        INSERT INTO votes (voterid, vchoice, validity) 
        VALUES (un, choice, 'VALID');
        DBMS_OUTPUT.PUT_LINE('Vote recorded as valid');
    ELSE
        INSERT INTO votes (voterid, vchoice, validity) 
        VALUES (un, choice, 'INVALID');
        DBMS_OUTPUT.PUT_LINE('Vote recorded as invalid');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Transaction completed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error encountered: ' || SQLERRM);
END;
/