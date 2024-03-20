use BibliotekaPW;

CREATE TYPE Bank_account_number FROM CHAR(26);
CREATE TYPE Post_code FROM CHAR(8);
CREATE TYPE Open_hours FROM CHAR(11); /* -- HH:MM-HH-MM */
CREATE TYPE Phone_number FROM CHAR(15);/* 15 bo w wielu krajach moze byc inna liczba znakow, jednak max=15 */
