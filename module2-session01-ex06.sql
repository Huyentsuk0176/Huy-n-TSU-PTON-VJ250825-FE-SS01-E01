DROP DATABASE IF EXISTS eventmanagementdb;
CREATE DATABASE EventManagementDB
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
USE EventManagementDB;
CREATE TABLE Event (
EventID INT PRIMARY KEY AUTO_INCREMENT,
EventName VARCHAR(100) character SET utf8mb4 NOT NULL,
EventDate DATE NOT NULL,
Location VARCHAR(200)
character SET UTF8MB4,
BUDGET decimal(12,2)
);
CREATE TABLE Attendee (
AttendeeName VARCHAR(100)
CHARACTER SET utf8mb4 NOT NULL,
Email VARCHAR(100) CHARACTER SET UTF8MB4 UNIQUE
);
CREATE TABLE Sponsor (
SponsorID INT PRIMARY KEY auto_increment, 
SponsorName varchar(100)
character SET utf8mb4 NOT NULL,
FundAmount decimal(12,2)
);
create table EventAttendee (
EventID INT,
AttendeeID INT,
primary key (EventID,AttendeeID),
foreign key (EventID)
references Event (EventID)
on delete cascade on update cascade
);

SHOW tables;








