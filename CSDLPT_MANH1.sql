-- 1. TẠO DATABASE
CREATE DATABASE CSDLPT_TH08_MANH1;
GO
USE CSDLPT_TH08_MANH1;
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
-- 3. NẠP DỮ LIỆU MẪU CHO MẢNH 1
----------------------------------------------------
PRINT N'Đang nạp dữ liệu cho Mảnh 1 (Thụy Điển + Nauy)...';
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
-- Dữ liệu TRUONGHOC (PHÂN MẢNH: Chỉ Thụy Điển & Nauy)
INSERT INTO TRUONGHOC VALUES('NU01', N'Nord University', N'Nauy', 925);
INSERT INTO TRUONGHOC VALUES('NU02', N'University of Oslo', N'Nauy', 8000);
INSERT INTO TRUONGHOC VALUES('TD01', N'Đại học Lund', N'Thụy Điển', 435900);
INSERT INTO TRUONGHOC VALUES('TD02', N'Đại học Karlstad', N'Thụy Điển', 13000);
GO
-- Dữ liệu DANGKY (PHÂN MẢNH DẪN XUẤT: Chỉ các đăng ký liên quan đến TRUONGHOC ở trên)
INSERT INTO DANGKY VALUES('HS02', 'NU01', 'TTM', CONVERT(DATE, '12/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
INSERT INTO DANGKY VALUES('HS04', 'NU02', 'TMQT', CONVERT(DATE, '12/03/2024', 103), CONVERT(DATE, '02/01/2025', 103));
INSERT INTO DANGKY VALUES('HS05', 'TD01', 'TMQT', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
INSERT INTO DANGKY VALUES('HS06', 'TD02', 'NHKS', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
INSERT INTO DANGKY VALUES('HS01', 'TD01', 'DS', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '01/09/2024', 103));
INSERT INTO DANGKY VALUES('HS02', 'TD02', 'DS', CONVERT(DATE, '12/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
INSERT INTO DANGKY VALUES('HS01', 'NU02', 'DS', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '02/01/2025', 103));
INSERT INTO DANGKY VALUES('HS02', 'NU02', 'DS', CONVERT(DATE, '12/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
INSERT INTO DANGKY VALUES('HS03', 'NU01', 'DS', CONVERT(DATE, '11/03/2024', 103), CONVERT(DATE, '01/09/2024', 103));
INSERT INTO DANGKY VALUES('HS04', 'NU01', 'CNVLM', CONVERT(DATE, '12/03/2024', 103), CONVERT(DATE, '01/01/2025', 103));
GO

----------------------------------------------------
-- 4. TẠO TÀI KHOẢN VÀ CẤP QUYỀN
----------------------------------------------------
PRINT N'Đang tạo Login và User cho Mảnh 1...';
GO
USE master;
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'demo_th08_m1')
BEGIN
    CREATE LOGIN demo_th08_m1 WITH PASSWORD = 'demo_th08_pass@';
END
GO
USE CSDLPT_TH08_MANH1;
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'demo_th08_m1')
BEGIN
    CREATE USER demo_th08_m1 FOR LOGIN demo_th08_m1;
END
GO
GRANT SELECT, EXECUTE TO demo_th08_m1;
GO

---------------------------------------------------------------------
-- 5. TẠO CÁC STORED PROCEDURE
---------------------------------------------------------------------
PRINT N'Đang tạo SP cho Mảnh 1...';
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
PRINT N'HOÀN TẤT KỊCH BẢN MẢNH 1.';
GO