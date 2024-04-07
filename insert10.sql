INSERT INTO Rents (user_id, elementary_book_id, rent_date, return_date, order_id, extension_id, employee_id) VALUES
(1, 1, '2024-03-27', '2024-04-03', 1, NULL, 1),
(2, 2, '2024-03-28', '2024-04-04', 2, 2, 2),
(3, 3, '2024-03-29', '2024-04-05', 3, NULL, 3),
(4, 4, '2024-03-30', '2024-04-06', 4, 4, 4),
(5, 5, '2024-03-31', '2024-04-07', 5, 5, 5),
(6, 6, '2024-04-01', '2024-04-08',  6, 6, 6),
(7, 7, '2024-04-02', '2024-04-09', 7, NULL, 7),
(8, 8, '2024-04-03', '2024-04-10', 8, 8, 8),
(9, 9, '2024-04-04', '2024-04-11', 9, 9, 9),
(10, 10, '2024-04-05', '2024-04-12', 10, 10, 10);

INSERT INTO Orders (elementary_book_id, user_id, date, pickup_time) VALUES
(1, 1, '2024-03-27', 1),
(25, 2, '2024-03-28', 2),
(50, 3, '2024-03-29', 7),
(75, 4, '2024-03-30', 14),
(100, 5, '2024-03-31', 1),
(12, 6, '2024-04-01', 2),
(37, 7, '2024-04-02', 7),
(62, 8, '2024-04-03', 14),
(87, 9, '2024-04-04', 1),
(101, 10, '2024-04-05', 2);

INSERT INTO Users (name, email, phone_number, status_id, indeks) VALUES
('Adam Kowalski', 'adam.kowalski@pw.edu.pl', '123456789', 7, '000000'),
('Anna Nowak', 'anna.nowak@pw.edu.pl', '987654321', 8, '000001'),
('Piotr Wiśniewski', 'piotr.wisniewski@pw.edu.pl', '555444333', 7, '000002'),
('Maria Dąbrowska', 'maria.dabrowska@pw.edu.pl', '111222333', 8, '000003'),
('Andrzej Lewandowski', 'andrzej.lewandowski@example.com', '999888777', 7, '000004'),
('Magdalena Wójcik', 'magdalena.wojcik@example.com', '777888999', 7, '000005'),
('Krzysztof Kamiński', 'krzysztof.kaminski@example.com', '333222111', 8, '000006'),
('Barbara Kowalczyk', 'barbara.kowalczyk@example.com', '444555666', 7, '000007'),
('Marek Zieliński', 'marek.zielinski@pw.edu.pl', '666777888', 7, '000008'),
('Agnieszka Szymańska', 'agnieszka.szymanska@example.com', '888999000', 8, '000009');

INSERT INTO Elementary_books (book_id, library_id, status_id, wear) VALUES
(1, 3, 5, 25),
(2, 15, 6, 56),
(3, 8, 5, 12),
(4, 2, 6, 78),
(5, 1, 5, 44),
(6, 10, 6, 39),
(7, 7, 5, 67),
(8, 18, 6, 90),
(9, 5, 5, 15),
(10, 13, 6, 20);