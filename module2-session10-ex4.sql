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
    create table ProductSummary (
    SummaryID int primary key,
    TotalQuantity int
    );
    --Thêm 1 bản ghi khởi tạo cho bảng ProductSummary
    insert into ProductSummary (SummaryID, TotalQuantity)
    values (1,0);
    --Thêm dữ liệu mẫu vào bảng Products
    INSERT INTO Products (ProductName, Quantity) VALUES
('Banh Mi', 100),
('Banh Ngot', 50),
('Tra Sua', 30);
select * from Products;
--Tính và cập nhật tổng kho ban đầu vào ProductSummary
update ProductSummary
set TotalQuantity = (select sum(Quantity) from Products)
where SummaryID = 1;
select * from ProductSummary;
--Trigger ghi log khi thay đổi số lượng (InventoryChanges)
delimiter $$
create trigger AfterProductUpdate
after update on Products 
for each row
begin
if Old.Quantity <> New.Quantity then
    insert into InventoryChanges (ProductID, OldQuantity, NewQuantity)
    values (Old.ProductID, Old.Quantity, New.Quantity);
    end if;
end$$
delimiter ;
--Trigger cập nhật tổng kho (AfterProductUpdateSummary)
delimiter $$
create trigger AfterProductUpdateSummary
after update on Products
for each row
begin
   update ProductSummary
   set TotalQuantity = (select sum(Quantity) from Products)
   where SummaryID = 1;
   end$$
   
   delimiter ;
   --TEST TRIGGER
   update Products
   set Quantity = 200
   where ProductID = 2;
   SELECT * FROM ProductSummary;
   select * from Products;
   --them 1 dong co productID=3
   insert into Products (ProductID, ProductName, Quantity)
   values (3, 'Banh moi', 100);
   update Products
   set Quantity = 2
   where ProductID = 3;
   select * from Products;
   update Products
   set Quantity = Quantity + 100
   where ProductID = 3;
   
   
   
   
   

   









    
    

    

    
    
    
    
