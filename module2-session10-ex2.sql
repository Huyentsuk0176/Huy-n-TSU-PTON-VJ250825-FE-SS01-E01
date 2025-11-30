CREATE DATABASE IF NOT EXISTS InventoryManagement;
USE InventoryManagement;
SELECT DATABASE ();

DROP TABLE IF EXISTS products;
CREATE TABLE Products (
       ProductID INT AUTO_INCREMENT PRIMARY KEY,
       ProductName VARCHAR(100),
       Quantity INT
);
DROP TABLE IF EXISTS InventoryChanges;
CREATE TABLE InventoryChanges (
    ChangeID INT auto_increment primary KEY,
    ProductID int not null,
    OldQuantity int,
    NewQuantity int,
    ChangeDate datetime default current_timestamp,
    constraint fk_product
    foreign key (ProductID) references Products(ProductID)
);
insert into Products(ProductName, Quantity) values
('Banh phong tom', 50),
('Banh hat de', 100),
('Banh trung', 5);
select * from Products;

--trigger ghi log sau khi update
drop trigger if exists AfterProductUpdate;

delimiter $$
create trigger AfterProductUpdate
after update on Products
for each row
begin
if Old.Quantity<>New.Quantity then 
insert into InventoryChanges (ProductID, OldQuantity, NewQuantity)
values
(Old.ProductID, Old.Quantity, New.Quantity);
end if;
end$$
delimiter ; 
--trigger chong xoa neu so luong >10
delimiter $$
create trigger BeforeProductDelete
before delete on products
for each row
begin
   if Old.Quantity >10 then
      signal sqlstate '45000'
      set message_text = 'khong the xoa san pham vi so luong lon hon10';
      end if;
      end$$
      delimiter ;
      
      
update Products
set Quantity = 80
where ProductID= 1;
select * from InventoryChanges;
desc Products;
desc InventoryChanges;
show triggers;

delete from Products where ProductID = 2;
delete from Products where ProductID = 3;



      





