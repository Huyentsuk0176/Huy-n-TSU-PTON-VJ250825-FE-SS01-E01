CREATE TABLE Students (
    StudentID INT,
    Name VARCHAR(50),
    Age INT,
    Major VARCHAR(50)
);
INSERT INTO Students (StudentID, Name, Age, Major)
VALUES
    (1, 'Alice', 20, 'Computer Science'),
    (2, 'Bob', 22, 'Mathematics'),
    (3, 'Charlie', 21, 'Physics');
UPDATE Students
SET Age = 23
WHERE StudentID = 2
LIMIT 1;

SELECT * FROM Students;

