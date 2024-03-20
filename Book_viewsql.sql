use BibliotekaPW;
Go
create view Book_view as
select
Books.Book_ID,
Books.Tytul,
Books.Opis,
Books.Rok_wydania,
Books.Ilosc,
Wydawnictwo.Nazwa as Wydawnictwo,
Kategoria.Nazwa as Kategoria,
Recenzje.Ocena,
Recenzje.Opinia
from Books
Left join 
Wydawnictwo on Books.Wydawnictwo_ID=Wydawnictwo.Wydawnictwo_ID
Left join
Kategoria on Books.Kategoria_ID=Kategoria.Kategoria_ID
Left join
Recenzje on Books.Recenzja_ID=Recenzje.Recenzja_ID