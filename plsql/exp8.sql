-- Creating a function 'dc' to determine the customer category
CREATE OR REPLACE FUNCTION dc(account_balance NUMBER) 
RETURN VARCHAR2 IS
    customer_category VARCHAR2(20);
BEGIN
    IF account_balance > 50000 THEN
        customer_category := 'Platinum';
    ELSIF account_balance > 10000 THEN
        customer_category := 'Gold';
    ELSE
        customer_category := 'Silver';
    END IF;
    
    RETURN customer_category;
END;
/

