-- =============================================
-- TẠO DATABASE SITE 2 (MÁY 2)
-- Chứa: Lớp (K2), SinhVien (K2), DangKy (Mảnh B - diem2, diem3)
-- =============================================
CREATE DATABASE QLDSV_Site2;
GO
USE QLDSV_Site2;
GO

-- 1. Bảng LỚP (Chỉ chứa Khoa K2)
CREATE TABLE LOP (
    MALOP CHAR(10) PRIMARY KEY,
    TENLOP NVARCHAR(50),
    KHOA CHAR(10) CHECK (KHOA = 'K2') -- Ràng buộc phân mảnh
);

-- 2. Bảng SINH VIEN (Chỉ chứa SV thuộc lớp của K2)
CREATE TABLE SINHVIEN (
    MSSV CHAR(10) PRIMARY KEY,
    HOTEN NVARCHAR(50),
    PHAI NVARCHAR(3),
    NGAYSINH DATE,
    MALOP CHAR(10) REFERENCES LOP(MALOP),
    HOCBONG FLOAT
);

-- 3. Bảng DANG KY - MẢNH B (Chứa diem2, diem3)
CREATE TABLE DANGKY (
    MSSV CHAR(10) NOT NULL,
    MSMON CHAR(10) NOT NULL,
    DIEM2 FLOAT,
    DIEM3 FLOAT,
    PRIMARY KEY (MSSV, MSMON)
);
GO

-- =============================================
-- INSERT DỮ LIỆU MOCK (SITE 2)
-- =============================================
-- Thêm Lớp K2
INSERT INTO LOP VALUES ('L3', N'Viễn Thông', 'K2');

-- Thêm Sinh Viên (K2) - 5 Sinh viên tiếp theo
INSERT INTO SINHVIEN VALUES ('SV06', N'Ngo Van F', 'Nam', '2003-06-06', 'L3', 200000);
INSERT INTO SINHVIEN VALUES ('SV07', N'Dang Thi G', N'Nữ', '2003-07-07', 'L3', 0);
INSERT INTO SINHVIEN VALUES ('SV08', N'Bui Van H', 'Nam', '2003-08-08', 'L3', 0);
INSERT INTO SINHVIEN VALUES ('SV09', N'Do Thi I', N'Nữ', '2003-09-09', 'L3', 150000);
INSERT INTO SINHVIEN VALUES ('SV10', N'Vu Van K', 'Nam', '2003-10-10', 'L3', 0);

-- Thêm Điểm 2, 3 cho các môn (Dữ liệu phân mảnh dọc - Mảnh B)
-- SV01 (SV của Site 1) nhưng diem2,3 nằm ở đây
INSERT INTO DANGKY (MSSV, MSMON, DIEM2, DIEM3) VALUES ('SV01', 'CSDL', 7.0, 8.0);
INSERT INTO DANGKY (MSSV, MSMON, DIEM2, DIEM3) VALUES ('SV01', 'TINHOC', 6.5, 7.0);

-- SV06 (SV của Site 2)
INSERT INTO DANGKY (MSSV, MSMON, DIEM2, DIEM3) VALUES ('SV06', 'CSDL', 6.0, 5.5);
INSERT INTO DANGKY (MSSV, MSMON, DIEM2, DIEM3) VALUES ('SV07', 'CSDL', 8.0, 9.5);