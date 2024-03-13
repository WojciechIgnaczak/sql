use master;
CREATE DATABASE BibliotekaPW;

use BibliotekaPW;
CREATE TABLE Autor(
Autor_ID int primary key IDENTITY (1,1),
Nazwisko varchar(50) NOT NULL,
Imie varchar(50) NOT NULL,
Biografia varchar(255),
);

CREATE TABLE Wydawnictwo(
Wydawnictwo_ID int primary key IDENTITY (1,1),
Nazwa varchar(50),
);

CREATE TABLE Kategoria(
Kategoria_ID int primary key IDENTITY (1,1),
Nazwa varchar(50),
);

CREATE TABLE Recenzje(
Recenzja_ID int primary key IDENTITY (1,1),
Ocena int NOT NULL,
Opinia varchar(255),
Ukryj int,
);

CREATE TABLE Dostawcy(
Dostawca_ID int primary key IDENTITY (1,1),
Nazwa_firmy varchar(50),
Adres varchar(255),
Numer_telefonu varchar(15),
);

CREATE TABLE Faktury(
Faktura_ID int primary key IDENTITY (1,1),
Kwota int NOT NULL,
Rodzaj_platnosci varchar(50) NOT NULL,
Numer_konta_bankowego varchar(20),
);

CREATE TABLE Lokalizacja(
Lokalizacja_ID int primary key IDENTITY (1,1),
Miasto varchar(50) NOT NULL,
Ulica varchar(50) NOT NULL,
Numer varchar(15),
Kod_pocztowy varchar(6),
);

CREATE TABLE Godziny_otwarcia(
Godziny_otwarcia_ID int primary key IDENTITY (1,1),
Dzien_tygodnia varchar(20),
Godziny varchar(11),
Status varchar(20),
);

CREATE TABLE Pracownicy(
Pracownik_ID int primary key IDENTITY (1,1),
Numer_telefonu varchar(15) NOT NULL,
Pensja int NOT NULL,
Godziny_pracy int,
Status varchar(50),
Login varchar(20) UNIQUE,
Haslo varchar(20) UNIQUE,
);

CREATE TABLE Przedluzenia(
Przedluzenie_ID int primary key IDENTITY (1,1),
Data_przedluzenia date  NOT NULL,
Ilosc_dni int NOT NULL,
Typ varchar(20),
);

CREATE TABLE Books(
Book_ID int primary key IDENTITY (1,1),
Autor_ID int,
Opis varchar(255),
Tytul varchar(50) NOT NULL,
Rok_wydania int,
Wydawnictwo_ID int,
Kategoria_ID int,
Recenzja_ID int,
Ilosc_szt int,
foreign key (Autor_ID) references Autor(Autor_ID),
foreign key (Wydawnictwo_ID) references Wydawnictwo(Wydawnictwo_ID),
foreign key (Kategoria_ID) references Kategoria(Kategoria_ID),
foreign key (Recenzja_ID) references Recenzje(Recenzja_ID)
);

CREATE TABLE Dostawa(
Dostawa_ID int primary key IDENTITY (1,1),
Book_ID int,
Dostawca_ID int,
Data_zamowienia date,
Status_zamowienia varchar(20),   
Faktura_ID int  NOT NULL,
foreign key (Book_ID) references Books(Book_ID),
foreign key (Dostawca_ID) references Dostawcy(Dostawca_ID),
foreign key (Faktura_ID) references Faktury(Faktura_ID)
);

CREATE TABLE Biblioteki(
Biblioteka_ID int primary key IDENTITY (1,1),
Nazwa varchar(50),
Lokalizacja_ID int,
Godziny_otwarcia_ID int,
Pracownik_ID int,
foreign key (Lokalizacja_ID) references Lokalizacja(Lokalizacja_ID),
foreign key (Godziny_otwarcia_ID) references Godziny_otwarcia(Godziny_otwarcia_ID),
foreign key (Pracownik_ID) references Pracownicy(Pracownik_ID)
);

CREATE TABLE Ksiazka_elementarna(
Unikalna_ksiazka_ID int primary key IDENTITY (1,1),
Book_ID int,
Biblioteka_ID int,
Status varchar(20),
Zuzycie int,
foreign key (Book_ID) references Books(Book_ID),
foreign key (Biblioteka_ID) references Biblioteki(Biblioteka_ID)
);

CREATE TABLE Uzytkownicy(
Uzytkownik_ID int primary key IDENTITY (1,1),
Name varchar(50) NOT NULL,
Email varchar(50) NOT NULL,
Numer_telefonu varchar(15),
Status varchar(20),
Wypozyczenie_ID int,
Indeks int UNIQUE NOT NULL,
);

CREATE TABLE Zamowienia(
Zamowienie_ID int primary key IDENTITY (1,1),
Unikalna_ksiazka_ID int,
Uzytkownik_ID int,
Data date,
Czas_odbioru int,
foreign key (Uzytkownik_ID) references Uzytkownicy(Uzytkownik_ID),
foreign key (Unikalna_ksiazka_ID) references Ksiazka_elementarna(Unikalna_ksiazka_ID)
);

CREATE TABLE Notyfikacje(
Notyfikacja_ID int primary key IDENTITY (1,1),
Typ_notyfikacji varchar(50),
Przedluzenie_ID int,
Data date,
Tresc varchar(255),
Uzytkownik_ID int,
foreign key (Przedluzenie_ID) references Przedluzenia(Przedluzenie_ID),
foreign key (Uzytkownik_ID) references Uzytkownicy(Uzytkownik_ID)
);

CREATE TABLE Wypozyczenia(
Wypozyczenie_ID int primary key IDENTITY (1,1),
Uzytkownik_ID int,
Unikalna_ksiazka_ID int,
Data_wypozyczenia date  NOT NULL,
Data_zwrotu date NOT NULL,
Czas_wypozyczenia int,
Zamowienie_ID int,
Przedluzenie_ID int,
Pracownik_ID int,
foreign key (Uzytkownik_ID) references Uzytkownicy(Uzytkownik_ID),
foreign key (Unikalna_ksiazka_ID) references Ksiazka_elementarna(Unikalna_ksiazka_ID),
foreign key (Zamowienie_ID) references Zamowienia(Zamowienie_ID),
foreign key (Przedluzenie_ID) references Przedluzenia(Przedluzenie_ID),
foreign key (Pracownik_ID) references Pracownicy(Pracownik_ID)
);

CREATE TABLE Config(
Config_ID int primary key IDENTITY (1,1),
Nazwa varchar(50),
Wartosc int,
DataModyfikacji datetime
);