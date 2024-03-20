use master;
CREATE DATABASE LibraryPW;
GO

use LibraryPW;
GO

CREATE TYPE Bank_account_number FROM VARCHAR(26);
CREATE TYPE Phone_number FROM VARCHAR(15); --15 bo w wielu krajach moze byc inna liczba znakow, jednak max=15
CREATE TYPE Post_code FROM VARCHAR(8);
CREATE TYPE Open_hours FROM VARCHAR(11) -- HH:MM-HH-MM

use LibraryPW;
GO

CREATE TABLE Authors(
Author_ID int primary key IDENTITY (1,1),
Surename varchar(50) NOT NULL,
Name varchar(50) NOT NULL,
Biography varchar(255),
);

CREATE TABLE Publishing_houses(
Publishing_house_ID int primary key IDENTITY (1,1),
Name varchar(50),
);

CREATE TABLE Categories(
Category_ID int primary key IDENTITY (1,1),
Name varchar(50),
);

CREATE TABLE Reviews(
Review_ID int primary key IDENTITY (1,1),
Mark int NOT NULL,
Review varchar(255),
Hide int,
);

CREATE TABLE Providers(
Provider_ID int primary key IDENTITY (1,1),
Company_name varchar(50),
Adres varchar(255),
Phone_number Phone_number,
);

CREATE TABLE Invoices(
Invoice_ID int primary key IDENTITY (1,1),
Amount int NOT NULL CHECK(Amount >0),
Payment varchar(50) NOT NULL,
Bank_account_number  Bank_account_number,
);

CREATE TABLE Locations(
Location_ID int primary key IDENTITY (1,1),
City varchar(50) NOT NULL,
Street varchar(50) NOT NULL,
Number varchar(15) CHECK(Number >0),
Post_code Post_code,
);

CREATE TABLE Open_hours(
Open_hour_ID int primary key IDENTITY (1,1),
Day_of_week varchar(20),
Hours Open_hours,
Status varchar(20),
);

CREATE TABLE Employees(
Employee_ID int primary key IDENTITY (1,1),
Phone_number Phone_number NOT NULL,
Salary int NOT NULL CHECK(Salary >0),
Working_hours int CHECK(Working_hours >0),
Status varchar(50),
Login varchar(20) UNIQUE,
Password varchar(20)
);

CREATE TABLE Extensions(
Extension_ID int primary key IDENTITY (1,1),
Date_of_extension datetime  NOT NULL,
Numbers_of_days int NOT NULL CHECK(Numbers_of_days >=0),
Type varchar(20),
);

CREATE TABLE Books(
Book_ID int primary key IDENTITY (1,1),
Author_ID int,
Description varchar(255),
Title varchar(50) NOT NULL,
Publishing_year int CHECK(Publishing_year >0),
Publishing_house_ID int,
Category_ID int,
Review_ID int,
Numbers_of_books int CHECK(Numbers_of_books >=0),
foreign key (Author_ID) references Authors(Author_ID),
foreign key (Publishing_house_ID) references Publishing_houses(Publishing_house_ID),
foreign key (Category_ID) references Categories(Category_ID),
foreign key (Review_ID) references Reviews(Review_ID)
);

CREATE TABLE Deliveries(
Delivery_ID int primary key IDENTITY (1,1),
Book_ID int,
Provider_ID int,
Date_of_order datetime,
Order_status varchar(20),   
Invoice_ID int  NOT NULL,
foreign key (Book_ID) references Books(Book_ID),
foreign key (Provider_ID) references Providers(Provider_ID),
foreign key (Invoice_ID) references Invoices(Invoice_ID)
);

CREATE TABLE Libraries(
Library_ID int primary key IDENTITY (1,1),
Name varchar(50),
Location_ID int,
Open_hour_ID int,
Employee_ID int,
foreign key (Location_ID) references Locations(Location_ID),
foreign key (Open_hour_ID) references Open_hours(Open_hour_ID),
foreign key (Employee_ID) references Employees(Employee_ID)
);

CREATE TABLE Elementary_books(
Elementary_book_ID int primary key IDENTITY (1,1),
Book_ID int,
Library_ID int,
Status varchar(20),
Wear int CHECK(Wear >0),
foreign key (Book_ID) references Books(Book_ID),
foreign key (Library_ID) references Libraries(Library_ID)
);

CREATE TABLE Users(
User_ID int primary key IDENTITY (1,1),
Name varchar(50) NOT NULL,
Email varchar(50) NOT NULL,
Phone_number Phone_number,
Status varchar(20),
Rent_ID int,
Indeks int UNIQUE NOT NULL,
);

CREATE TABLE Orders(
Order_ID int primary key IDENTITY (1,1),
Elementary_book_ID int,
User_ID int,
Date datetime,
Pickup_time int CHECK(Pickup_time >=0),
foreign key (User_ID) references Users(User_ID),
foreign key (Elementary_book_ID) references Elementary_books(Elementary_book_ID)
);

CREATE TABLE Notifications(
Notification_ID int primary key IDENTITY (1,1),
Notification_type varchar(50),
Extension_ID int,
Date datetime,
Content varchar(255),
User_ID int,
foreign key (Extension_ID) references Extensions(Extension_ID),
foreign key (User_ID) references Users(User_ID)
);

CREATE TABLE Rents(
Rent_ID int primary key IDENTITY (1,1),
User_ID int,
Elementary_book_ID int,
Rent_date datetime  NOT NULL,
Return_date date NOT NULL,
Rental_time int CHECK(Rental_time >0),
Order_ID int,
Extension_ID int,
Employee_ID int,
foreign key (User_ID) references Users(User_ID),
foreign key (Elementary_book_ID) references Elementary_books(Elementary_book_ID),
foreign key (Order_ID) references Orders(Order_ID),
foreign key (Extension_ID) references Extensions(Extension_ID),
foreign key (Employee_ID) references Employees(Employee_ID)
);

CREATE TABLE Config(
Config_ID int primary key IDENTITY (1,1),
Name varchar(50),
Value int,
Modification_date datetime
);


use LibraryPW;
Go
Create view Book_view as
select
Books.Book_ID,
Books.Title,
Books.Description,
Books.Publishing_year,
Books.Numbers_of_books,
Publishing_houses.Name as Publishing_house,
Categories.Name as Category,
Reviews.Mark,
Reviews.Review
from Books
Left join 
Publishing_houses on Books.Publishing_house_ID=Publishing_houses.Publishing_house_ID
Left join
Categories on Books.Category_ID=Categories.Category_ID
Left join
Reviews on Books.Review_ID=Reviews.Review_ID


Go
Create view User_view as
select
Users.User_ID,
Users.Name,
Users.Email,
Users.Phone_number,
Users.Status,
Users.Indeks,
Books.Title,
Rents.Rent_ID,
Rents.Rent_date,
Rents.Return_date,
Rents.Rental_time
from Users
Left join
Rents on Users.User_ID=Rents.User_ID
Left join
Elementary_books on Rents.Elementary_book_ID=Elementary_books.Elementary_book_ID
Left join
Books on Elementary_books.Book_ID=Books.Title