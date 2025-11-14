create database if not exists OrderDB;
use orderDB;
create table customers ( customerID int auto_increment primary key,
customername varchar (100), Phone varchar (20));
create table orders ( orderID int auto_increment primary key, 
orderdate date not null, customerID int,
Totalamount decimal(10,2) not null,
foreign key (customerID) references customers (customerID),
check (totalamount >= 0));
insert into customers (customername, phone)
value ('Pham Huyen', '07092253835');
select * from orders;
