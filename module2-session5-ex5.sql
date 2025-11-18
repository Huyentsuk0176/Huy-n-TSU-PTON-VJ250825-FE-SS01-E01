create database session5_ex5DB;
use session5_ex5DB;
create table products (productID int primary key auto_increment,
productName varchar(100) not null);
create table orderDetails (orderDetailID int primary key auto_increment,
productID int not null,
quantity int not null,
price decimal(10,2) not null,
foreign key (productID)
references products(productID));
insert into products (productName) values
('Banh mi'), 
('Tra sua'), 
('Banh kem'), 
('Cafe'), 
('Mochi'),
insert into orderDetails (productID, quantity, price) values
(1, 20, 20.00),
(2, 30, 30.00),
(3, 40, 50.00),
(4, 50, 70.00),
(5, 80, 90.00);
select 
p.productID,
p.productName,
sum(od.quantity) as total_quantity
from products p
join orderDetails od
on p.productID = od.productID
group by p.productID,
p.productName
order by total_quantity desc;











