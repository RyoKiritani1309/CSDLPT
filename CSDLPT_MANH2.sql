-- 1. TẠO DATABASE
CREATE DATABASE CSDLPT_TH08_MANH2;
GO
USE CSDLPT_TH08_MANH2;
GO

----------------------------------------------------
-- 2. TẠO CẤU TRÚC 4 BẢNG
----------------------------------------------------
PRINT N'Đang tạo 4 bảng...';
GO
-- Bảng DUHOCSINH (Sẽ được nhân bản toàn bộ)
CREATE TABLE DUHOCSINH(
    MADHS CHAR(4) PRIMARY KEY, HOTEN NVARCHAR(100), DIACHI NVARCHAR(100),
    DIEMTB FLOAT, IELTS FLOAT, TAICHINH FLOAT, DONVI NVARCHAR(10)
);
-- Bảng NGANHHOC (Sẽ được nhân bản toàn bộ)
CREATE TABLE NGANHHOC(
    MANG CHAR(5) PRIMARY KEY, TENNGANH NVARCHAR(100),
    IELTS FLOAT, SONAM INT
);
-- Bảng TRUONGHOC (Sẽ được phân mảnh ngang)
CREATE TABLE TRUONGHOC(
    MATR CHAR(4) PRIMARY KEY, TENTRUONG NVARCHAR(100),
    QUOCGIA NVARCHAR(50), HOCPHI FLOAT
);
-- Bảng DANGKY (Sẽ được phân mảnh ngang dẫn xuất)
CREATE TABLE DANGKY(
    MADHS CHAR(4), MATR CHAR(4), MANG CHAR(5),
    TGDANGKY DATE, TGHOC DATE, 
    PRIMARY KEY (MADHS, MATR, MANG),
    CONSTRAINT FK_DANGKY_DHS FOREIGN KEY (MADHS) REFERENCES DUHOCSINH(MADHS),
    CONSTRAINT FK_DANGKY_NGANH FOREIGN KEY (MANG) REFERENCES NGANHHOC(MANG),
    CONSTRAINT FK_DANGKY_TRUONG FOREIGN KEY (MATR) REFERENCES TRUONGHOC(MATR)
);
GO
PRINT N'-> Đã tạo xong 4 bảng.';
GO

----------------------------------------------------
-- 3. NẠP DỮ LIỆU MẪU CHO MẢNH 2
----------------------------------------------------
PRINT N'Đang nạp dữ liệu cho Mảnh 2 (Hà Lan)...';
GO
-- Dữ liệu DUHOCSINH (NHÂN BẢN TOÀN BỘ)
INSERT INTO DUHOCSINH VALUES('HS01', N'Nguyễn Hồng Đào', N'32 Hoàng Diệu', 7.6, 6.0, 1, N'Tỷ');
INSERT INTO DUHOCSINH VALUES('HS02', N'Lê Kim Ngân', N'147 Tân Thanh', 7.2, 6.0, 700, N'Triệu');
INSERT INTO DUHOCSINH VALUES('HS03', N'Đình Toàn Thắng', N'59 Phú Gia', 8.0, 6.5, 600, N'Triệu');
INSERT INTO DUHOCSINH VALUES('HS04', N'Nguyễn Thế Hạnh', N'12 Hoàng Mẫn', 9.6, 7.0, 1.5, N'Tỷ');
INSERT INTO DUHOCSINH VALUES('HS05', N'Lý Minh Thư', N'15 đường 3/2', 7.0, 6.5, 1.3, N'Tỷ');
INSERT INTO DUHOCSINH VALUES('HS06', N'Hồ Ái Lộc', N'6 Minh Khuê', 5.5, 6.5, 500, N'Triệu');
GO
-- Dữ liệu NGANHHOC (NHÂN BẢN TOÀN BỘ)
INSERT INTO NGANHHOC VALUES('TTM', N'Ngành Truyền thông – Marketing.', 6.0, 3);
INSERT INTO NGANHHOC VALUES('TMQT', N'Ngành Thương mại Quốc tế', 6.5, 4);
INSERT INTO NGANHHOC VALUES('DS', N'Ngành Trí tuệ nhân tạo (AI), Big Data.', 6.0, 4);
INSERT INTO NGANHHOC VALUES('NHKS', N'Ngành Dịch vụ nhà hàng, khách sạn', 7.0, 3);
INSERT INTO NGANHHOC VALUES('CKBD', N'Ngành Kỹ thuật, công nghệ, cơ khí, bán dẫn', 6.5, 4);
INSERT INTO NGANHHOC VALUES('CNVLM', N'Ngành Công nghệ mới, vật liệu mới', 6.5, 4);
GO
-- Dữ liệu TRUONGHOC (PHÂN MẢNH: Chỉ Hà Lan)
INSERT INTO TRUONGHOC VALUES('HL01', N'The Hague University of Applied Science', N'Hà Lan', 8000);
INSERT INTO TRUONGHOC VALUES('HL02', N'Amsterdam University of Applied Sciences', N'Hà Lan', 9800);
GO
-- Dữ liệu DANGKY (PHÂN MẢNH DẪN XUẤT: Chỉ các đăng ký liên quan đến TRUONGHOC ở trên)
INSERT INTO DANGKY VALUES('HS01', 'HL01', 'TTM', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
INSERT INTO DANGKY VALUES('HS03', 'HL02', 'TTM', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
INSERT INTO DANGKY VALUES('HS03', 'HL01', 'DS', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
INSERT INTO DANGKY VALUES('HS04', 'HL01', 'TMQT', CONVERT(DATE, '12/03/2024', 103), CONVERT(DATE, '02/01/2025', 103));
INSERT INTO DANGKY VALUES('HS05', 'HL01', 'TMQT', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
INSERT INTO DANGKY VALUES('HS06', 'HL01', 'CKBD', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
GO

----------------------------------------------------
-- 4. TẠO TÀI KHOẢN VÀ CẤP QUYỀN
----------------------------------------------------
PRINT N'Đang tạo Login và User cho Mảnh 2...';
GO
USE master;
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'demo_th08_m2')
BEGIN
    CREATE LOGIN demo_th08_m2 WITH PASSWORD = 'demo_th08_pass@';
END
GO
USE CSDLPT_TH08_MANH2;
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'demo_th08_m2')
BEGIN
    CREATE USER demo_th08_m2 FOR LOGIN demo_th08_m2;
END
GO
GRANT SELECT, EXECUTE TO demo_th08_m2;
GO

---------------------------------------------------------------------
-- 5. TẠO CÁC STORED PROCEDURE
---------------------------------------------------------------------
PRINT N'Đang tạo SP cho Mảnh 2...';
GO
CREATE PROC DULIEU_TRUONGHOC
AS BEGIN SELECT * FROM TRUONGHOC END
GO
CREATE PROC DULIEU_DUHOCSINH
AS BEGIN SELECT * FROM DUHOCSINH END
GO
CREATE PROC DULIEU_NGANHHOC
AS BEGIN SELECT * FROM NGANHHOC END
GO
CREATE PROC DULIEU_DANGKY
AS BEGIN SELECT * FROM DANGKY END
GO
PRINT N'HOÀN TẤT KỊCH BẢN MẢNH 2.';
GO