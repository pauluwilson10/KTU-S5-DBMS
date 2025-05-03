CREATE OR REPLACE TRIGGER calculate_total_average
BEFORE INSERT OR UPDATE ON students
FOR EACH ROW
BEGIN
    -- Calculate total and average
    :NEW.total := :NEW.mark1 + :NEW.mark2;
    :NEW.average := :NEW.total / 2;
END;
/
