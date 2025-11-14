CREATE DATABASE QuanLyCuaHang;
USE QuanLyCuaHang;
CREATE TABLE KhachHang (
MaKH INT PRIMARY KEY,
TenKH VARCHAR(50) NOT NULL,
NgaySinh DATE,
DiaChi VARCHAR(100));
--CHEN 3 BAN GHI
INSERT INTO KhachHang (MaKH, TenKH, NgaySinh, DiaChi)
VALUES
(1, 'Pham Thi Huyen', '1992-02-03', 'Ca Mau'),
(2, 'Nguyen Van Anh', '1989-12-03', 'Hoi An'),
(3, 'Tran Thi Trung', '1964-12-04', 'Da Nang');
SELECT * FROM Khachhang;



