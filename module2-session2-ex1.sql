create database IF NOT exists COMPANYDB;
use companyDB;
create table employees ( employeeID int auto_increment primary key,
FirstName varchar(50), 
lastname varchar(50),
hiredate date,
salary int);
alter table employees
add department varchar(50);
alter table employees
modify column salary
decimal(10,2);
DESC EMPLOYEES;
