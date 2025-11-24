-- =============================================
-- TẠO DATABASE TỔNG (SITE 0)
-- Chỉ chứa View và Linked Server, không chứa dữ liệu gốc
-- =============================================
CREATE DATABASE QLDSV_Tong;
GO
USE QLDSV_Tong;
GO

-- 1. CẤU HÌNH LINKED SERVER (Chạy 1 lần)
-- Link tới Site 1 (Chính máy này, nhưng dùng IP để giả lập phân tán hoặc dùng localhost)
-- Lưu ý: Thay 'IP_MAY_1' bằng IP Radmin máy 1, 'MatKhauSQL' bằng pass sa
EXEC sp_addlinkedserver @server='LINK_SITE1', @srvproduct='', @provider='SQLNCLI', @datasrc='25.9.113.243';
EXEC sp_addlinkedsrvlogin 'LINK_SITE1', 'false', NULL, 'sa', '123';

-- Link tới Site 2 (Máy kia)
-- Lưu ý: Thay 'IP_MAY_2' bằng IP Radmin máy 2
EXEC sp_addlinkedserver @server='LINK_SITE2', @srvproduct='', @provider='SQLNCLI', @datasrc='25.9.247.144,1433';
EXEC sp_addlinkedsrvlogin 'LINK_SITE2', 'false', NULL, 'sa', 'Admin#123456';
GO
	
-- 2. TẠO VIEW TOÀN CỤC (TRANSPARENCY)

-- View LOP: Hợp nhất (Union) từ 2 site
IF OBJECT_ID('v_Lop', 'V') IS NOT NULL DROP VIEW v_Lop;
GO

CREATE VIEW v_Lop AS
SELECT 
    MALOP, 
    TENLOP, 
    KHOA 
FROM LINK_SITE1.QLDSV_Site1.dbo.LOP
UNION ALL
SELECT 
    MALOP COLLATE DATABASE_DEFAULT, 
    TENLOP COLLATE DATABASE_DEFAULT, 
    KHOA COLLATE DATABASE_DEFAULT
FROM LINK_SITE2.QLDSV_Site2.dbo.LOP;
GO

-- View SINHVIEN: Hợp nhất (Union) từ 2 site
IF OBJECT_ID('v_SinhVien', 'V') IS NOT NULL DROP VIEW v_SinhVien;
GO

CREATE VIEW v_SinhVien AS
SELECT 
    MSSV, 
    HOTEN, 
    PHAI, 
    NGAYSINH, 
    MALOP, 
    HOCBONG
FROM LINK_SITE1.QLDSV_Site1.dbo.SINHVIEN
UNION ALL
SELECT 
    MSSV COLLATE DATABASE_DEFAULT, 
    HOTEN COLLATE DATABASE_DEFAULT, 
    PHAI COLLATE DATABASE_DEFAULT, 
    NGAYSINH, 
    MALOP COLLATE DATABASE_DEFAULT, 
    HOCBONG
FROM LINK_SITE2.QLDSV_Site2.dbo.SINHVIEN;
GO

-- View DANGKY: Kết nối (Join) mảnh A và mảnh B để tái tạo bảng gốc
-- Đây là kỹ thuật phục hồi phân mảnh dọc
IF OBJECT_ID('v_DangKy', 'V') IS NOT NULL DROP VIEW v_DangKy;
GO

CREATE VIEW v_DangKy AS
SELECT
    A.MSSV,
    A.MSMON,
    A.DIEM1,
    B.DIEM2,
    B.DIEM3
FROM LINK_SITE1.QLDSV_Site1.dbo.DANGKY A
INNER JOIN LINK_SITE2.QLDSV_Site2.dbo.DANGKY B
ON A.MSSV = B.MSSV COLLATE DATABASE_DEFAULT 
AND A.MSMON = B.MSMON COLLATE DATABASE_DEFAULT;
GO

SELECT * FROM LINK_SITE2.QLDSV_Site2.dbo.LOP;