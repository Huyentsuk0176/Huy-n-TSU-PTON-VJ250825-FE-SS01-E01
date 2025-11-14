create database if not exists companyBD;
use  companyDB;
create table products ( 
productID int auto_increment primary key,
productName varchar(100),
category varchar(50),
price decimal(10,2),
stockQuantity int);
show tables;
insert INTO products
(productName, category, price, stockQuantity)
values
('Monblanc cake', 'Dessert', 200, 50),
('obanzai', 'Food', 100, 80),
('tea-milk','Drink', 20, 100);
select*from products;

