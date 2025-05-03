SET SERVEROUTPUT ON;


ACCEPT account PROMPT 'Enter Account number';
ACCEPT choice PROMPT 'ENTER choice 1:Debit 2: Credit';
ACCEPT amount PROMPT 'Enter amount';


DECLARE
	balance NUMBER(20);
	account VARCHAR(20):='&account';
	choice NUMBER(20):=&choice;
	amount NUMBER(20):=&amount;
BEGIN
	IF choice =2 THEN
		UPDATE bank SET bal=bal+amount WHERE acc_num=account;
		DBMS_OUTPUT.PUT_LINE('Credited amount: '||amount)
	ELSIF choice=1 THEN
		UPDATE bank SET bal=bal-amount WHERE acc_nUm=account;
		DBMS_OUTPUT.PUT_LINE('Debited amount:' ||amount)
	ELSE
		DBMS_OUTPUT.PUT_LINE('Invalid Selection');
	END IF;
	
	SELECT bal INTO balance FROM bank where acc_number=account;
	DBMS_OUTPUT.PUT_LINE('Balance AMOUNT: '|| balance)
	
	IF balance<500 THEN
		DBMS_OUTPUT.PUT_LINE('warning critical')
	END IF;
END;
/

	