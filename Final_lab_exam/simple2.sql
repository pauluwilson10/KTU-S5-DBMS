DECLARE
    avr NUMBER(10,5);
    cdate VARCHAR(20);
BEGIN
    SELECT AVG(MARK) INTO avr from average;
    if avr<40 THEN
        dbms_output.put_line('Need Improvment');
    ELSE
        dbms_output.put_line('good average marks');
    end if;
    dbms_output.put_line('Date:'|| SYSDATE);
    cdate:=TO_CHAR(SYSDATE,'MONTH');
    dbms_output.put_line('Day:'|| cdate);
end;
/
	
		