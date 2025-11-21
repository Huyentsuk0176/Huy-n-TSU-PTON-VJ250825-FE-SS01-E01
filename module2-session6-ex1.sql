create database session6_ex1;
use session6_ex1;
create table categories (
id int primary key auto_increment,
name varchar(100)
);
create table products (
id int primary key auto_increment,
name varchar(100), 
price float,
category_id int,
foreign key (category_id)
references categories(id)
);
---them du lieu mau cho categories
insert into categories (name) values
('do uong'),
('do an vat'),
('banh ngot');
----them 3 san pham vao products
insert into products 
( name, price, category_id) values
('tra sua', 50, 1),
('banh trang trom', 20, 2),
('banh bong lan', 60, 3);
--cap nhat lai gia banh bong lan len 120 k
update products
set price = 120
where id = 3;
select * from products;
--xoa 1 san pham
delete from products
where id = 2;
--hien thi tat ca san pham , sap xep theo gia giam dan
select p.id, p.name, p.price,
c.name as category_name
from products p
join categories c on
p.category_id = c.id
order by p.price desc;
--thong ke so luong san pham theo tung danh muc
select c.name as category_name,
count(p.id) as 
total_products
from categories c
left join products p on
p.category_id = c.id
group by c.id, c.name;



