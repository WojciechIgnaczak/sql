select
Uzytkownicy.Uzytkownik_ID,
Uzytkownicy.Name,
Uzytkownicy.Email,
Uzytkownicy.Numer_telefonu,
Uzytkownicy.Status,
Uzytkownicy.Indeks,
Books.Tytul,
Wypozyczenia.Wypozyczenie_ID,
Wypozyczenia.Data_wypozyczenia,
Wypozyczenia.Data_zwrotu,
Wypozyczenia.Czas_wypozyczenia
from Uzytkownicy
Left join
Wypozyczenia on Uzytkownicy.Uzytkownik_ID=Wypozyczenia.Uzytkownik_ID
Left join
Ksiazka_elementarna on Wypozyczenia.Unikalna_ksiazka_ID=Ksiazka_elementarna.Unikalna_ksiazka_ID
Left join
Books on Ksiazka_elementarna.Book_ID=Books.Tytul