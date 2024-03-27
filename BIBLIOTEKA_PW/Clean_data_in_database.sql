use LibraryPW;
GO
-- Wyłącz ograniczenia klucza obcego
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

-- Usuń dane z tabeli Config
DELETE FROM Config;
DBCC CHECKIDENT ('Config', RESEED, 0);

-- Usuń dane z tabeli Notifications
DELETE FROM Notifications;
DBCC CHECKIDENT ('Notifications', RESEED, 0);

-- Usuń dane z tabeli Rents
DELETE FROM Rents;
DBCC CHECKIDENT ('Rents', RESEED, 0);

-- Usuń dane z tabeli Orders
DELETE FROM Orders;
DBCC CHECKIDENT ('Orders', RESEED, 0);

-- Usuń dane z tabeli Users
DELETE FROM Users;
DBCC CHECKIDENT ('Users', RESEED, 0);

-- Usuń dane z tabeli Elementary_books
DELETE FROM Elementary_books;
DBCC CHECKIDENT ('Elementary_books', RESEED, 0);

-- Usuń dane z tabeli Employees
DELETE FROM Employees;
DBCC CHECKIDENT ('Employees', RESEED, 0);

-- Usuń dane z tabeli Libraries
DELETE FROM Libraries;
DBCC CHECKIDENT ('Libraries', RESEED, 0);

-- Usuń dane z tabeli Locations
DELETE FROM Locations;
DBCC CHECKIDENT ('Locations', RESEED, 0);

-- Usuń dane z tabeli Deliveries
DELETE FROM Deliveries;
DBCC CHECKIDENT ('Deliveries', RESEED, 0);

-- Usuń dane z tabeli Reviews
DELETE FROM Reviews;
DBCC CHECKIDENT ('Reviews', RESEED, 0);

-- Usuń dane z tabeli Books
DELETE FROM Books;
DBCC CHECKIDENT ('Books', RESEED, 0);

-- Usuń dane z tabeli Extensions
DELETE FROM Extensions;
DBCC CHECKIDENT ('Extensions', RESEED, 0);

-- Usuń dane z tabeli Open_hours
DELETE FROM Open_hours;
DBCC CHECKIDENT ('Open_hours', RESEED, 0);

-- Usuń dane z tabeli Invoices
DELETE FROM Invoices;
DBCC CHECKIDENT ('Invoices', RESEED, 0);

-- Usuń dane z tabeli Providers
DELETE FROM Providers;
DBCC CHECKIDENT ('Providers', RESEED, 0);

-- Usuń dane z tabeli Categories
DELETE FROM Categories;
DBCC CHECKIDENT ('Categories', RESEED, 0);

-- Usuń dane z tabeli Publishing_houses
DELETE FROM Publishing_houses;
DBCC CHECKIDENT ('Publishing_houses', RESEED, 0);

-- Usuń dane z tabeli Status
DELETE FROM Status;
DBCC CHECKIDENT ('Status', RESEED, 0);

-- Usuń dane z tabeli Authors
DELETE FROM Authors;
DBCC CHECKIDENT ('Authors', RESEED, 0);

-- Włącz ponownie ograniczenia klucza obcego
EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';
