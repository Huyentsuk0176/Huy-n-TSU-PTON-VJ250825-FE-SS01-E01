create database if not exists HotelManagementDB;
use HotelManagementDB;
create table Project (ProjectID int primary key auto_increment,
Projectname varchar(100), startdate DATE, endDate DATE, budget DEcimal(18,2));
create table employee (employeeID int primary key auto_increment, employeeName varchar(100), position varchar(50));
create table assignment (assignmentID int primary key auto_increment, employeeID int, projectID int, startdate date,  enddate date,
foreign key (EmployeeID)
references employee(employeeID),
foreign key (ProjectID)
references Project(ProjectID));
create table task (taskID int primary key auto_increment, taskName varchar(100),
projectID int, startdate date, enddate date, status varchar(50),
foreign key (projectID) references Project(projectID));
show tables;




