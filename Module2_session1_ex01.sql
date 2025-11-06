--1. chọn tất cả các cột từ bảng Books
SELECT *
FROM Books;
--2. chọn tên sách và tác giả của những cuốn sách có giá > 50
SELECT title, Author
FROM Books
WHERE Price >50