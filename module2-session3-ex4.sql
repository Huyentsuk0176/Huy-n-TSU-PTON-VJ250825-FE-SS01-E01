CREATE DATABASE QuanLyTMDT;
USE QuanLyTMDT;
--Tao bang danh muc co khoa chinh
CREATE TABLE DanhMuc (
MaDM INT PRIMARY KEY,
TenDM VARCHAR(100) NOT NULL);
--tao bang sanpham (co khoa ngoai lien ket DanhMuc)
CREATE TABLE SanPham (
MaSP INT PRIMARY KEY,
TenSP VARCHAR (100) NOT NULL,
Gia DECIMAL(10,2) NOT NULL,
MaDM INT,
FOREIGN KEY (MaDM) REFERENCES DanhMuc(MaDM));
-chen du lieu mau vao danh muc
INSERT INTO DanhMuc (MaDM, TenDM)
VALUES
(1, 'Do uong'),
(2, 'Do an'),
(3, 'Thoi trang');
--chen 3 ban ghi vao san pham
INSERT INTO SanPham (MaSP, TenSP, Gia, MaDM)
VALUES
(1, 'Tra sua', 20000, 1),
(2, 'Com tam', 50000, 2),
(3, 'Ao dam', 200000, 3);
SELECT * FROM SanPham;
--truy van san pham thuoc danhmuc madm=1
SELECT * FROM SanPham
WHERE MaDM = 1;





