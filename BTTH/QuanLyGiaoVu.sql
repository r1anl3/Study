CREATE DATABASE QLGV

USE QLGV
--Q1
CREATE TABLE GIAOVIEN(
    MAGV CHAR(4),
    HOTEN VARCHAR(40),
    HOCVI  VARCHAR(10),
    HOCHAM  VARCHAR(10),
    GIOITINH VARCHAR(3),
    NGSINH SMALLDATETIME,
    NGVL SMALLDATETIME,
    HESO NUMERIC(4,2),
    MUCLUONG MONEY,
    MAKHOA VARCHAR(4),
    CONSTRAINT PK_GV PRIMARY KEY (MAGV)
)

CREATE TABLE KHOA(
    MAKHOA VARCHAR(4),
    TENKHOA VARCHAR(40),
    NGTLAP SMALLDATETIME,
    TRGKHOA CHAR(4)
    CONSTRAINT PK_KHOA PRIMARY KEY (MAKHOA)
    CONSTRAINT FK_KHOA FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN (MAGV)
)

CREATE TABLE MONHOC(
    MAMH VARCHAR(10),
    TENMH VARCHAR(40),
    TCLT TINYINT,
    TCTH TINYINT,
    MAKHOA VARCHAR(4)
    CONSTRAINT PK_MH PRIMARY KEY (MAMH)
)

CREATE TABLE DIEUKIEN(
    MAMH VARCHAR(10),
    MAMH_TRUOC VARCHAR(10),
    CONSTRAINT PK_DK PRIMARY KEY (MAMH, MAMH_TRUOC)
)

CREATE TABLE HOCVIEN(
    MAHV CHAR(5),
    HO VARCHAR(40),
    TEN VARCHAR(10),
    NGSINH SMALLDATETIME,
    GIOITINH VARCHAR(3),
    NOISINH VARCHAR(40),
    MALOP CHAR(3),
    CONSTRAINT PK_HV PRIMARY KEY (MAHV)
)

CREATE TABLE LOP(
    MALOP CHAR(3),
    TENLOP VARCHAR(40),
    TRGLOP CHAR(5),
    SISO TINYINT,
    MAGVCN CHAR(4),
    CONSTRAINT PK_LOP PRIMARY KEY (MALOP),
    CONSTRAINT FK_LOP FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN (MAHV)
)

CREATE TABLE GIANGDAY(
    MALOP CHAR(3),
    MAMH VARCHAR(10),
    MAGV CHAR(4),
    HOCKY TINYINT,
    NAM SMALLINT,
    TUNGAY SMALLDATETIME,
    DENNGAY SMALLDATETIME,
    CONSTRAINT PK_GD PRIMARY KEY (MALOP, MAMH)
)

CREATE TABLE KETQUATHI(
    MAHV CHAR(5),
    MAMH VARCHAR(10),
    LANTHI TINYINT,
    NGTHI SMALLDATETIME,
    DIEM NUMERIC(4,2),
    KQUA VARCHAR(10),
    CONSTRAINT PK_KQ PRIMARY KEY (MAHV, MAMH, LANTHI)
)

ALTER TABLE HOCVIEN
ADD GHICHU VARCHAR(255)

ALTER TABLE HOCVIEN
ADD DIEMTB FLOAT

ALTER TABLE HOCVIEN
ADD XEPLOAI VARCHAR(10)

--Q2
ALTER TABLE HOCVIEN 
ADD STT CHAR(2)

ALTER TABLE HOCVIEN ADD CONSTRAINT
CK_MAHV CHECK(SUBSTRING(MAHV, 1, 3) = MALOP AND SUBSTRING(MAHV, 4, 5) = STT)

--Q3
ALTER TABLE HOCVIEN ADD CONSTRAINT
CK_GT CHECK(GIOITINH IN ('Nam', 'Nu'))

--Q4
ALTER TABLE KETQUATHI ADD CONSTRAINT
CK_DIEM CHECK(DIEM >= 0 AND DIEM < 10)

--Q5
ALTER TABLE KETQUATHI ADD CONSTRAINT
CK_KQ_PASS CHECK(DIEM IN (5,10) AND KETQUATHI = 'Dat')

ALTER TABLE KETQUATHI ADD CONSTRAINT
CK_KQ_FAIL CHECK(DIEM < 5 AND KETQUATHI = 'Khong dat')

--Q6 
ALTER TABLE KETQUATHI ADD CONSTRAINT
CK_LANTHI CHECK(LANTHI <= 3)

--Q7
ALTER TABLE GIANGDAY ADD CONSTRAINT
CK_HK CHECK(HOCKY IN (1,3))

--Q8 
ALTER TABLE GIAOVIEN ADD CONSTRAINT
CK_HV CHECK(HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS'))