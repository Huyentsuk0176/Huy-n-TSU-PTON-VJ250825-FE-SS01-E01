create database QuanLyKhachSanDB;
use QuanLyKhachSanDB;
create table Customer(
customer_id varchar(5) primary key,
customer_full_name varchar(100)not null,
customer_email varchar(100) not null unique,
customer_phone varchar(15) not null,
customer_address varchar(255) not null);

create table Room(
room_id varchar(5) primary key,
room_type varchar(50) not null,
room_price decimal(10,2) not null,
room_status varchar(20) not null,
room_area int not null );

create table Booking(
booking_id int primary key auto_increment,
customer_id varchar(5) not null,
room_id varchar(5) not null,
check_in_date date not null,
check_out_date date not null,
total_amount decimal(10,2),
foreign key(customer_id) references Customer(customer_id),
foreign key(room_id) references Room(room_id));

create table Payment(
payment_id int primary key auto_increment,
booking_id int not null,
payment_method varchar(50) not null,
payment_date date not null,
payment_amount decimal(10,2) not null,
foreign key(booking_id) references Booking(booking_id));

insert into Customer
(customer_id, customer_full_name, customer_email, customer_phone, customer_address) values
('C001', 'Nguyen Anh Tu', 'tu.nguyen@example.com', '0912345678', 'Ha Noi,Viet Nam'),
('C002', 'Tran Thi Mai', 'mai.tran@example.com', '0923456789', 'Ho Chi Minh,Viet Nam'),
('C003', 'Le Minh Hoang', 'hoang.le@example.com', '0934567890', 'Da Nang,Viet Nam'),
('C004', 'Pham Hoang Nam', 'nam.pham@example.com', '0945678901', 'Hue,Viet Nam'),
('C005', 'Vu Minh Thu', 'thu.vu@example.com', '0956789012', 'Hai Phong,Viet Nam');

insert into Room
(room_id, room_type, room_price, room_status, room_area) values
('R001', 'Single', 100.0, 'Available', 25), 
('R002', 'Double', 150.0, 'Booked', 40), 
('R003', 'Suite', 250.0, 'Available', 60), 
('R004', 'Single', 120.0, 'Booked', 30), 
('R005', 'Double', 160.0, 'Available', 35);

insert into Booking
(booking_id, customer_id, room_id, check_in_date, check_out_date, total_amount) values
(1, 'C001', 'R001', '2025-03-01', '2025-03-05', 400.0),
(2, 'C002', 'R002', '2025-03-02', '2025-03-06', 600.0),
(3, 'C003', 'R003', '2025-03-03', '2025-03-07', 1000.0),
(4, 'C004', 'R004', '2025-03-04', '2025-03-08', 480.0),
(5, 'C005', 'R005', '2025-03-05', '2025-03-09', 800.0);

insert into Payment
(payment_id, booking_id, payment_method, payment_date, payment_amount) values
(1, 1, 'Cash', '2025-03-05', 400.0),
(2, 2, 'Credit Card', '2025-03-06', 600.0),
(3, 3, 'Bank Transfer', '2025-03-07', 1000.0),
(4, 4, 'Cash', '2025-03-08', 480.0),
(5, 5, 'Credit Card', '2025-03-09', 800.0);

update Booking b 
join Room r on b.room_id = r.room_id
set b.total_amount = r.room_price* datediff(b.check_out_date, b.check_in_date)
where room_status = 'Booked'
and check_in_date < curdate();

delete from Payment
where payment_method = 'Cash'
and payment_amount <500;

select
customer_id, customer_full_name, customer_email, customer_phone, customer_address
from customer
order by customer_full_name asc;

select
room_id, room_type, room_price, room_status, room_area
from Room
order by room_price desc;

select
c.customer_id, c.customer_full_name,
r.room_id,
b.check_in_date, b.check_out_date
from Booking b 
join Customer c on b.customer_id = c.customer_id
join Room r on b.room_id = r.room_id;

select
c.customer_id, c.customer_full_name,
p.payment_method, p.payment_amount
from Payment p 
join Booking b on p.booking_id = b.booking_id
join Customer c on b.customer_id = c.customer_id
order by p.payment_amount desc;

select * from customer
order by customer_full_name
limit 3 offset 1;

select customer_id, customer_full_name, customer_email, customer_phone
from customer
where customer_full_name like '%Minh%' or '%HaNoi%'
order by customer_full_name asc;

create view v_room_customer_before_2025_03_10 as
select
r.room_id,
r.room_type,
c.customer_id,
c.customer_full_name
from Booking b 
join Room r on b.room_id = r.room_id
join Customer c on b.customer_id = c.customer_id
where check_in_date <'2025-03-10';

create view v_customer_room_area as
select
c.customer_id,
c.customer_full_name,
r.room_id,
r.room_area
from booking b 
join Customer c on b.customer_id = c.customer_id
join Room r on b.room_id = r.room_id
where r.room_area > 30;

delimiter $$
create trigger check_insert_booking
before insert on Booking
for each row
begin
if New.check_in_date > New.check_out_date then
signal sqlstate '45000'
set message_text = 'ngay dat phong khong the sao ngay tra phong duoc';
end if;
end $$
delimiter ; 

delimiter $$
create procedure add_customer (
in p_customer_id varchar(5),
p_customer_full_name varchar(100),
P_customer_email varchar(100),
p_customer_phone varchar(15),
p_customer_address varchar(255))
begin
insert into Customer (
customer_id,
customer_full_name,
customer_email,
customer_phone,
customer_address)
values
(p_customer_id,
p_customer_full_name,
p_customer_email,
p_customer_phone,
p_customer_address);
end $$
delimiter ;

call add_customer ('C006', 'Pham Thi Huyen', 'huyen.pham@example.com', '07092253835', 'Ca Mau');

delimiter $$
create procedure add_payment
(in 
p_booking_id int,
p_payment_method varchar(50),
p_payment_date date,
p_payment_amount decimal(10,2))
begin
insert into Payment
(booking_id,
payment_method,
payment_date,
payment_amount
)
values
(p_booking_id,
p_payment_method,
p_payment_date,
p_payment_amount
);
end$$
delimiter ;


call add_payment(1,'Credit Card', '2025-10-01',600);

























