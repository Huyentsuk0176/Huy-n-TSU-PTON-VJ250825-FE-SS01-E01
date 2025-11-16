DROP DATABASE Students;
CREATE DATABASE Students;
USE Students;

-- 1. Tạo bảng Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Major VARCHAR(50)
);

-- 2. Thêm dữ liệu sinh viên
INSERT INTO Students (StudentID, Name, Age, Major) VALUES
(1, 'Alice', 20, 'Computer Science'),
(2, 'Bob', 22, 'Mathematics'),
(3, 'Charlie', 21, 'Physics');

-- 3. Hiển thị tất cả sinh viên
SELECT * FROM Students;

