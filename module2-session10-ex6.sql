use InVentoryManagement;
create table if not exists ProductRestock (
RestockID int auto_increment primary key,
ProductID int not null,
Quantity int,
RestockDate datetime,
foreign key (ProductID) references Products(ProductID)
);
--neu so luong <10 thi ghi phieu nhap
delimiter $$
create trigger
AfterProductUpdateRestock
after update on Products 
for each row
begin
if New.Quantity <10 then
insert into
ProductRestock (ProductID, Quantity, RestockDate)
values
(New.ProductID, New.Quantity, now());
end if;
end $$
delimiter ; 

update Products 
set Quantity = 5
where ProductID = 1;
select * from Products;
select * from ProductRestock;



