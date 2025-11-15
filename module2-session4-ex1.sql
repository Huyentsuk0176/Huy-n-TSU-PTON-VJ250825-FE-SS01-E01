CREATE DATABASE Students;
USE Students;
CREATE TABLE Students (
StudentID INT,
Name VARCHAR(50),
Age INT,
Major VARCHAR(50));
INSERT INTO Students (StudentID, Name, Age, Major) VALUES
(1, 'Alice',20, 'Computer Science'),
(2, 'Bob', 22, 'Mathematics'),
(3, 'Charlie', 21, 'Physics');
SELECT * FROM Students;



