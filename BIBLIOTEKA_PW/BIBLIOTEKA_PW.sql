USE master;
CREATE DATABASE LibraryPW;
GO

USE LibraryPW;
GO

CREATE TYPE bank_account_number FROM VARCHAR(30);
CREATE TYPE phone_number FROM VARCHAR(20); --+48 111 111 111 
CREATE TYPE post_code FROM VARCHAR(8);
CREATE TYPE open_hours FROM VARCHAR(11); -- HH:MM-HH:MM

USE LibraryPW;
GO

CREATE TABLE Authors(
author_id INT PRIMARY KEY IDENTITY (1,1),
surename VARCHAR(50) NOT NULL,
name VARCHAR(50) NOT NULL,
biography NTEXT,
username VARCHAR(50)
);

CREATE TABLE Status(-- 1,2-employees, 3,4-deliveries, 5,6-elementary_books, 7,8,9-users, 10,11-invoices
status_id INT PRIMARY KEY IDENTITY(1,1),
kind_of_status CHAR(50)
);

CREATE TABLE Publishing_houses(
publishing_house_id INT PRIMARY KEY IDENTITY (1,1),
name VARCHAR(50)
);

CREATE TABLE Categories(
category_id INT PRIMARY KEY IDENTITY (1,1),
name VARCHAR(50)
);

CREATE TABLE Providers(
provider_id INT PRIMARY KEY IDENTITY (1,1),
company_name VARCHAR(60),
adres VARCHAR(255),
phone_number phone_number
);

CREATE TABLE Invoices(
invoice_id INT PRIMARY KEY IDENTITY (1,1),
amount INT NOT NULL CHECK(amount > 0),
status_id int CHECK(status_id in(10,11)),
bank_account_number bank_account_number
FOREIGN KEY (status_id) REFERENCES Status(status_id)
);

CREATE TABLE Locations(
location_id INT PRIMARY KEY IDENTITY (1,1),
city VARCHAR(50) NOT NULL,
street VARCHAR(50) NOT NULL,
number VARCHAR(10), -- 999/BBB/999
post_code post_code
);

CREATE TABLE Extensions(
extension_id INT PRIMARY KEY IDENTITY (1,1),
date_of_extension DATETIME  NOT NULL,
numbers_of_days INT NOT NULL CHECK(numbers_of_days >= 0),
type VARCHAR(20)
);

CREATE TABLE Books(
book_id INT PRIMARY KEY IDENTITY (1,1),
author_id INT,
description ntext,
title VARCHAR(100) NOT NULL,
publishing_year INT CHECK(publishing_year > 0),
publishing_house_id INT,
category_id INT,
numbers_of_books INT CHECK(numbers_of_books >= 0),
FOREIGN KEY (author_id) REFERENCES Authors(author_id),
FOREIGN KEY (publishing_house_id) REFERENCES Publishing_houses(publishing_house_id),
FOREIGN KEY (category_id) REFERENCES Categories(category_id),
);

CREATE TABLE Reviews(
review_id INT PRIMARY KEY IDENTITY (1,1),
mark INT NOT NULL CHECK (mark BETWEEN 1 AND 5),
review ntext,
hide INT,
book_id INT
FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Deliveries(
delivery_id INT PRIMARY KEY IDENTITY (1,1),
book_id INT,
provider_id INT,
date_of_order DATETIME,
status_id INT CHECK(status_id in(3,4)),
invoice_id INT NOT NULL,
FOREIGN KEY (book_id) REFERENCES Books(book_id),
FOREIGN KEY (provider_id) REFERENCES Providers(provider_id),
FOREIGN KEY (invoice_id) REFERENCES Invoices(invoice_id),
FOREIGN KEY (status_id) REFERENCES Status(status_id)
);

CREATE TABLE Libraries(
library_id INT PRIMARY KEY IDENTITY (1,1),
name VARCHAR(100),
location_id INT,
FOREIGN KEY (location_id) REFERENCES Locations(location_id),
);

CREATE TABLE Open_hours_per_day (
open_hour_per_day_id INT PRIMARY KEY IDENTITY(1,1),
library_id INT,
day_of_week VARCHAR(10),
open_time TIME,
close_time TIME,
FOREIGN KEY (library_id) REFERENCES Libraries(library_id)
);

CREATE TABLE Employees(
employee_id INT PRIMARY KEY IDENTITY (1,1),
name varchar(50),
surename varchar(100),
phone_number phone_number NOT NULL,
salary INT NOT NULL CHECK(salary > 0),
working_hours_per_day INT CHECK(working_hours_per_day > 0),
status_id INT CHECK(status_id in(1,2)),
login VARCHAR(20) UNIQUE,
password VARCHAR(100),
library_id int
FOREIGN KEY (library_id) REFERENCES Libraries(library_id),
FOREIGN KEY (status_id) REFERENCES Status(status_id)
);

CREATE TABLE Elementary_books(
elementary_book_id INT PRIMARY KEY IDENTITY (1,1),
book_id INT,
library_id INT,
status_id INT CHECK(status_id in(5,6)),-- 5- 6-
wear INT CHECK(wear > 0),
FOREIGN KEY (book_id) REFERENCES Books(book_id),
FOREIGN KEY (library_id) REFERENCES Libraries(library_id),
FOREIGN KEY (status_id) REFERENCES Status(status_id)
);

CREATE TABLE Users(
user_id INT PRIMARY KEY IDENTITY (1,1),
name VARCHAR(50) NOT NULL,
email VARCHAR(256) NOT NULL,
phone_number phone_number,
status_id INT CHECK(status_id in(7,8,9)),
indeks INT UNIQUE NOT NULL,
FOREIGN KEY (status_id) REFERENCES Status(status_id)
);
CREATE TABLE Orders(
order_id INT PRIMARY KEY IDENTITY (1,1),
elementary_book_id INT,
user_id INT,
date DATETIME,
pickup_time INT CHECK(pickup_time >= 0),
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (elementary_book_id) REFERENCES Elementary_books(elementary_book_id)
);

CREATE TABLE Rents(
rent_id INT PRIMARY KEY IDENTITY (1,1),
user_id INT,
elementary_book_id INT,
rent_date DATETIME NOT NULL,
return_date DATETIME NOT NULL,
rental_time AS (DATEDIFF(day, rent_date, return_date)),
order_id INT,
extension_id INT,
employee_id INT,
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (elementary_book_id) REFERENCES Elementary_books(elementary_book_id),
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (extension_id) REFERENCES Extensions(extension_id),
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);


CREATE TABLE Notifications(
notification_id INT PRIMARY KEY IDENTITY (1,1),
notification_type VARCHAR(50),
extension_id INT,
date DATETIME,
content VARCHAR(255),
user_id INT,
FOREIGN KEY (extension_id) REFERENCES Extensions(extension_id),
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Config(
config_id INT PRIMARY KEY IDENTITY (1,1),
name VARCHAR(50),
value VARCHAR(50),
modification_date DATETIME
);

USE LibraryPW;
GO

CREATE VIEW Book_view AS
SELECT
Books.book_id,
Books.title,
Books.description,
Books.publishing_year,
Books.numbers_of_books,
Publishing_houses.name AS publishing_house,
Categories.name AS category,
Reviews.mark,
Reviews.review
FROM Books
LEFT JOIN 
Publishing_houses ON Books.publishing_house_id = Publishing_houses.publishing_house_id
LEFT JOIN
Categories ON Books.category_id = Categories.category_id
LEFT JOIN
Reviews ON Books.book_id = Reviews.book_id;

GO

CREATE VIEW User_view AS
SELECT
Users.user_id,
Users.name,
Users.email,
Users.phone_number,
Users.status_id,
Status.kind_of_status,
Users.indeks,
Books.title,
Rents.rent_id,
Rents.rent_date,
Rents.return_date,
Rents.rental_time
FROM Users
LEFT JOIN
Rents ON Users.user_id = Rents.user_id
LEFT JOIN
Elementary_books ON Rents.elementary_book_id = Elementary_books.elementary_book_id
LEFT JOIN
Books ON Elementary_books.book_id = Books.book_id
LEFT JOIN
Status ON Users.status_id=Status.status_id;

GO

CREATE VIEW Library_view AS
SELECT
Libraries.library_id,
Libraries.name AS library_name,
Locations.city,
Locations.street,
Locations.number,
Locations.post_code,
Open_hours_per_day.day_of_week,
Open_hours_per_day.open_time,
Open_hours_per_day.close_time
FROM
Libraries
JOIN
Locations ON Libraries.location_id = Locations.location_id
LEFT JOIN
Open_hours_per_day ON Libraries.library_id = Open_hours_per_day.library_id;

GO

CREATE VIEW Elementary_book_view AS
SELECT
Elementary_books.elementary_book_id,
Elementary_books.book_id,
Elementary_books.library_id,
Elementary_books.status_id,
Elementary_books.wear,
Status.kind_of_status AS status,
Books.title AS book_title,
Libraries.name AS library_name
FROM 
Elementary_books
JOIN 
Status ON Elementary_books.status_id = Status.status_id
JOIN 
Books ON Elementary_books.book_id = Books.book_id
JOIN 
Libraries ON Elementary_books.library_id = Libraries.library_id;
