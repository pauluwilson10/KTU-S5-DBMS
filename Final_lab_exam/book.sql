CREATE OR REPLACE PROCEDURE Check_Overdue_Books AS
  CURSOR overdue_books_cursor IS SELECT BorrowID, BookID, MemberID, BorrowDate, ReturnDate FROM BORROW WHERE ReturnDate IS NULL AND BorrowDate < SYSDATE - 30;
  v_fine_amount NUMBER;
BEGIN
  FOR overdue_book IN overdue_books_cursor LOOP
    v_fine_amount := (SYSDATE - overdue_book.BorrowDate - 30) * 2;
    
    UPDATE BORROW
    SET FINE = v_fine_amount
    WHERE BorrowID = overdue_book.BorrowID;
  END LOOP;
END Check_Overdue_Books;

/

CREATE OR REPLACE TRIGGER AfterInsertOnBorrow AFTER INSERT ON BORROW FOR EACH ROW



SET SERVEROUTPUT ON;
DECLARE
    available_copies NUMBER;
BEGIN
    check_overdue_Books;
    SELECT AvailableCopies INTO available_copies FROM BOOKS WHERE BookID = :NEW.BookID;
    IF available_copies > 0 THEN
        UPDATE BOOKS SET AvailableCopies = AvailableCopies - 1
        WHERE BookID = :NEW.BookID;
	DBMS_OUTPUT.PUT_LINE('updated');
	
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERRORS');
    END IF;
END;
/


