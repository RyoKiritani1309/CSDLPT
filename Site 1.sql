-- =============================================
-- TẠO DATABASE SITE 1 (MÁY 1)
-- Chứa: Lớp (K1), SinhVien (K1), DangKy (Mảnh A - diem1)
-- =============================================
CREATE DATABASE QLDSV_Site1;
GO
USE QLDSV_Site1;
GO

-- 1. Bảng LỚP (Chỉ chứa Khoa K1)
CREATE TABLE LOP (
    MALOP CHAR(10) PRIMARY KEY,
    TENLOP NVARCHAR(50),
    KHOA CHAR(10) CHECK (KHOA = 'K1') -- Ràng buộc phân mảnh
);

-- 2. Bảng SINH VIEN (Chỉ chứa SV thuộc lớp của K1)
CREATE TABLE SINHVIEN (
    MSSV CHAR(10) PRIMARY KEY,
    HOTEN NVARCHAR(50),
    PHAI NVARCHAR(3),
    NGAYSINH DATE,
    MALOP CHAR(10) REFERENCES LOP(MALOP),
    HOCBONG FLOAT
);

-- 3. Bảng DANG KY - MẢNH A (Chỉ chứa diem1)
CREATE TABLE DANGKY (
    MSSV CHAR(10) NOT NULL,
    MSMON CHAR(10) NOT NULL,
    DIEM1 FLOAT,
    PRIMARY KEY (MSSV, MSMON)
    -- Lưu ý: Ở Site con, ta tạm bỏ qua FK tới SinhVien để dễ insert dữ liệu phân mảnh dọc
);
GO

-- =============================================
-- INSERT DỮ LIỆU MOCK (SITE 1)
-- =============================================
-- Thêm Lớp K1
INSERT INTO LOP VALUES ('L1', N'Công Nghệ PM', 'K1');
INSERT INTO LOP VALUES ('L2', N'Hệ Thống TT', 'K1');

-- Thêm Sinh Viên (K1) - 5 Sinh viên đầu
INSERT INTO SINHVIEN VALUES ('SV01', N'Nguyen Van A', 'Nam', '2003-01-01', 'L1', 1000000);
INSERT INTO SINHVIEN VALUES ('SV02', N'Tran Thi B', N'Nữ', '2003-02-02', 'L1', 0);
INSERT INTO SINHVIEN VALUES ('SV03', N'Le Van C', 'Nam', '2003-03-03', 'L2', 500000);
INSERT INTO SINHVIEN VALUES ('SV04', N'Pham Thi D', N'Nữ', '2003-04-04', 'L2', 0);
INSERT INTO SINHVIEN VALUES ('SV05', N'Hoang Van E', 'Nam', '2003-05-05', 'L1', 0);

-- Thêm Điểm 1 cho các môn (Dữ liệu phân mảnh dọc - Mảnh A)
-- SV01 học CSDL và TinHoc
INSERT INTO DANGKY (MSSV, MSMON, DIEM1) VALUES ('SV01', 'CSDL', 8.0);
INSERT INTO DANGKY (MSSV, MSMON, DIEM1) VALUES ('SV01', 'TINHOC', 7.5);

-- SV06 (Ở Site 2) cũng có diem1 nằm ở đây (do phân mảnh dọc toàn cục)
INSERT INTO DANGKY (MSSV, MSMON, DIEM1) VALUES ('SV06', 'CSDL', 5.0);
INSERT INTO DANGKY (MSSV, MSMON, DIEM1) VALUES ('SV07', 'CSDL', 9.0);

select * from LOP;
select * from SinhVien;
select * from DangKy;