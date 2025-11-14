USE QuanLyCuahang; 
CREATE TABLE SanPham(
MaSP INT PRIMARY KEY, 
TenSP VARCHAR(100) NOT NULL, 
Gia DECIMAL(10,2),
SoLuongLon INT DEFAULT 0);
--THEM COT MOTA- ALTER TABLE
ALTER TABLE SanPham
ADD COLUMN MoTa TEXT;
--CHEN 3 BAN GHI VAO MAU SAN PHAM
INSERT INTO SanPham (MaSP, TenSP, Gia, SoLuongLon, MoTa)
VALUES
(1, 'Banh Montbanc', 40000, 100, 'Banh kem, thom'),
(2, 'Keo chocolate', 52000, 1000, 'Dam Da, Ngot'),
(3, 'Mut Tao', 72000, 500, 'Set,Chua Ngot');
SELECT * FROM SanPham;
--truy van cac san pham cos gia tren 50000
SELECT * FROM SanPham
WHERE Gia > 50000;





