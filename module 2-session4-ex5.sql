CREATE DATABASE Students;
USE Students;
CREATE TABLE Students (
studentID INT PRIMARY KEY,
studentName VARCHAR(50) NOT NULL, 
major VARCHAR(50) NOT NULL);
DROP DATABASE Students;
CREATE TABLE Courses (
courseID INT PRIMARY KEY,
courseName VARCHAR(100) NOT NULL,
instructor VARCHAR(50) NOT NULL );
--INSERT them 4 sinh vien vao students
INSERT INTO Students (studentID, studentName, major) VALUES
(1, 'Alice', 'Computer Science'),
(2, 'Bob', 'Mathematics'),
(3, 'Charlie', 'Physics'),
(4, 'David', 'Biology');
SELECT * FROM Students;
--them 3 mon hoc vao Courses
INSERT INTO Courses (courseID, courseName, instructor) VALUES
( 1, 'Lap Trinh Vien', 'Dr.Tien'),
( 2, 'Toan Hoc', 'Tien Sy Phuoc'),
( 3, 'Tam Ly Hoc', 'Ms.Mai');
TRUNCATE TABLE Courses;
SELECT * FROM Students;
SELECT * FROM Courses;
--- update cap nhat . doi ten mon hoc co courseID=2 thanh 'advanced Mathematics'
UPDATE Courses
SET courseName = 'Advanced Mathematics'
WHERE courseID = 2;
--cap nhat chuyen nganh cua studentid =3 thanh 'engineering'
UPDATE Students
set major = 'Engineering'
WHERE studentID = 3;
SELECT * FROM Students;
-- xoa sinh vien co studentID = 1
DELETE FROM students
WHERE studentID = 1;
SELECT * FROM Students;
--xoa mon hoc co courseID = 3
DELETE FROM Courses
WHERE courseID = 3;
SELECT * FROM Students;
SELECT * FROM Courses;















