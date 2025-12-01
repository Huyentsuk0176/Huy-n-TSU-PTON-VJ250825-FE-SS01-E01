create database if not exists InventoryManagement;
CREATE DATABASE InventoryManagement;
USE InventoryManagement;
create table Products(
     ProductID int primary key auto_increment,
     Productname varchar(100),
     Quantity int,
     Price decimal(10,2)
);
select * from products;
--tao trigger cap nhat lastupdated
delimiter $$
create trigger 
AfterProductUpdateSetDate
before update on Products
for each row
begin
    set New.LastUpdated = current_timestamp;
    end$$
    delimiter ;
    update Products
    set Quantity = Quantity + 5
    where ProductID = 1;
    update Products
    set Quantity = Quantity + 100
    where ProductID = 2;
    select * from Products;
    
    
    
    
    
