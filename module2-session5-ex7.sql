create database bai7_session05;
use bai7_session05;
-- tao bang 
create table products (
	productID int primary key auto_increment,
    productName varchar(100) NOT NULL unique
);

create table regions (
	regionID int primary key auto_increment,
    regionName varchar(100) NOT NULL
);

create table sales (
	saleID int primary key auto_increment,
    producID int NOT NULL,
    regionID int NOT NULL,
    saleDate date NOT NULL,
    quantity int NOT NULL,
    amount decimal(10,2) NOT NULL,
    foreign key (producID) references products(productID),
    foreign key (regionID) references regions(regionID)
);

insert into products(productName) VALUES 
('AO polo'),
('Quan kaki'),
('Mu Son');

insert into regions(regionName) VALUES 
('HN'),
('HCM'),
('DN');

SELECT * FROM products;
SELECT * FROM regions;

insert into sales (producID,regionID,saleDate,quantity,amount) VALUE (1,1,'2025-11-11',2,200);
insert into sales (producID,regionID,saleDate,quantity,amount) VALUE (1,2,'2025-11-12',1,100);
insert into sales (producID,regionID,saleDate,quantity,amount) VALUE (3,3,'2025-11-12',1,50);
insert into sales (producID,regionID,saleDate,quantity,amount) VALUE (2,1,'2025-11-11',1,100);

SELECT * FROM sales;

SELECT temp.regionName,temp.productName,temp.total_qty
FROM (
	SELECT r.regionName, p.productName,r.regionID, SUM(s.quantity) as total_qty
	FROM sales s 
	JOIN products p ON s.producID = p.productID
	JOIN regions r ON r.regionID = s.regionID 
	group by r.regionName, p.productName ,r.regionID

) as temp JOIN (
	SELECT regionID,MAX(total_qty) AS max_qty FROM 
    (SELECT regionID,producID,SUM(quantity) AS total_qty FROM sales GROUP BY regionID,producID) AS t
    group by regionID
) AS m ON temp.regionID = m.regionID AND temp.total_qty = m.max_qty;