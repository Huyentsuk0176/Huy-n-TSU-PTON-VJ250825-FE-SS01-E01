create database session5_ex6DB;
use session5_ex6DB;
create table sales (
saleID int primary key auto_increment,
saleDate date not null,
price decimal(10,2) not null);
insert into sales (saleDate, price) values
('2025-01-01', 1000),
('2025-01-02', 2000),
('2025-02-03', 3000),
('2025-02-04', 4000),
('2025-03-05', 5000),
('2025-04-06', 6000),
('2025-05-07', 7000);
select
year(saleDate) as year,
month(saleDate) as month,
sum(price) as total_revenue, 
count(*) as total_orders,
avg(price) as
avg_revenue_per_order
from sales
group by year(saleDate),
month(saleDate)
order by year, month;




