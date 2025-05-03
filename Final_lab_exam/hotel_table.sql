-- Creating tables
CREATE TABLE guest (
    name VARCHAR2(100),
    address VARCHAR2(100),
    roomno NUMBER,
    check_in_date DATE,
    check_out_date DATE
);

CREATE TABLE bill (
    name VARCHAR2(100),
    billamount NUMBER(20)
);

CREATE TABLE room (
    roomno NUMBER(10) PRIMARY KEY NOT NULL,
    charge_day NUMBER(20)
);

CREATE TABLE history (
    name VARCHAR2(100),
    check_out_date DATE
);

-- Inserting sample data into tables
-- Guest table
INSERT INTO guest VALUES ('John Doe', '123 Main St', 101, TO_DATE('2024-11-10', 'YYYY-MM-DD'), TO_DATE('2024-11-15', 'YYYY-MM-DD'));
INSERT INTO guest VALUES ('Jane Smith', '456 Elm St', 102, TO_DATE('2024-11-12', 'YYYY-MM-DD'), TO_DATE('2024-11-16', 'YYYY-MM-DD'));
INSERT INTO guest VALUES ('Mike Brown', '789 Oak St', 103, TO_DATE('2024-11-08', 'YYYY-MM-DD'), TO_DATE('2024-11-13', 'YYYY-MM-DD'));

-- Bill table
INSERT INTO bill VALUES ('John Doe', 5000);
INSERT INTO bill VALUES ('Jane Smith', 4000);
INSERT INTO bill VALUES ('Mike Brown', 3500);

-- Room table
INSERT INTO room VALUES (101, 1000);
INSERT INTO room VALUES (102, 1200);
INSERT INTO room VALUES (103, 900);

-- History table
INSERT INTO history VALUES ('John Doe', TO_DATE('2024-11-15', 'YYYY-MM-DD'));
INSERT INTO history VALUES ('Mike Brown', TO_DATE('2024-11-13', 'YYYY-MM-DD'));

-- Commit changes
COMMIT;







