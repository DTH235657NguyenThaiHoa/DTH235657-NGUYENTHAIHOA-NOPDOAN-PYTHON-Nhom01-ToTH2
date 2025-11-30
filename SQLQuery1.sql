-- =================================================================
-- PHẦN 1: CÁC BẢNG DANH MỤC VÀ ĐỐI TƯỢNG CƠ BẢN
-- =================================================================

-- 1. BẢNG NHÂN VIÊN (NHANVIEN)
CREATE TABLE NHANVIEN (
    MaNV CHAR(10) PRIMARY KEY,
    HoLot NVARCHAR(50) NOT NULL,
    TenNV NVARCHAR(50) NOT NULL,
    GioiTinh NVARCHAR(10),
    NgaySinh DATE,
    ChucVu NVARCHAR(50)
);

-- 2. BẢNG KHÁCH HÀNG (KHACHHANG)
CREATE TABLE KHACHHANG (
    MaKH CHAR(10) PRIMARY KEY,
    HoLot NVARCHAR(50) NOT NULL,
    TenKH NVARCHAR(50) NOT NULL,
    GioiTinh NVARCHAR(10),
    NgaySinh DATE,
    SDT VARCHAR(15) UNIQUE,
);

-- 3. BẢNG NHÀ CUNG CẤP (NHACUNGCAP - NCC)
CREATE TABLE NHACUNGCAP (
    MaNCC CHAR(10) PRIMARY KEY,
    TenNCC NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255),
    SDT VARCHAR(15)
);

-- 4. BẢNG SẢN PHẨM (SANPHAM)
CREATE TABLE SANPHAM (
    MaSP CHAR(10) PRIMARY KEY,
    TenSP NVARCHAR(100) NOT NULL,
    LoaiSP NVARCHAR(50),
    DonViTinh NVARCHAR(20),
    DonGiaBan DECIMAL(18, 2) CHECK (DonGiaBan >= 0),
    TonKho INT DEFAULT 0 CHECK (TonKho >= 0)
);

-- 5. BẢNG KHUYẾN MÃI (KHUYENMAI) - Điều chỉnh
CREATE TABLE KHUYENMAI (
    MaKM CHAR(10) PRIMARY KEY,
    TenKM NVARCHAR(150) NOT NULL,
    GiaTri NVARCHAR(50) NOT NULL,
    NgayBatDau DATE,
    NgayKetThuc DATE
);

-- =================================================================
-- PHẦN 2: CÁC BẢNG QUẢN LÝ GIAO DỊCH (HÓA ĐƠN)
-- =================================================================

-- 6. BẢNG HÓA ĐƠN (HOADON)
CREATE TABLE HOADON (
    MaHD CHAR(10) PRIMARY KEY,
    MaKH CHAR(10),
    MaNV CHAR(10) NOT NULL,
    NgayLap DATE NOT NULL,
    TongTien DECIMAL(18, 2) DEFAULT 0 CHECK (TongTien >= 0),
    MaKM CHAR(10), -- Mã khuyến mãi áp dụng (NULL nếu không áp dụng)
    
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
    FOREIGN KEY (MaKM) REFERENCES KHUYENMAI(MaKM)
);

-- 7. BẢNG CHI TIẾT HÓA ĐƠN (CHITIETHOADON)
CREATE TABLE CHITIETHOADON (
    MaHD CHAR(10) NOT NULL,
    MaSP CHAR(10) NOT NULL,
    SoLuong INT NOT NULL CHECK (SoLuong > 0),
    DonGia DECIMAL(18, 2) NOT NULL CHECK (DonGia >= 0),
    ThanhTien AS (SoLuong * DonGia),
    
    PRIMARY KEY (MaHD, MaSP),
    FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);


-- =================================================================
-- PHẦN 3: CÁC BẢNG QUẢN LÝ KHO HÀNG (PHIẾU NHẬP)
-- =================================================================

-- 8. BẢNG PHIẾU NHẬP (PHIEUNHAP)
CREATE TABLE PHIEUNHAP (
    MaPN CHAR(10) PRIMARY KEY,
    MaNCC CHAR(10),
    MaNV CHAR(10) NOT NULL,
    NgayNhap DATE NOT NULL,
    TongGiaTriNhap DECIMAL(18, 2) DEFAULT 0 CHECK (TongGiaTriNhap >= 0),
    
    FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC),
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

-- 9. BẢNG CHI TIẾT PHIẾU NHẬP (CHITIETPHIEUNHAP)
CREATE TABLE CHITIETPHIEUNHAP (
    MaPN CHAR(10) NOT NULL,
    MaSP CHAR(10) NOT NULL,
    SoLuongNhap INT NOT NULL CHECK (SoLuongNhap > 0),
    DonGiaNhap DECIMAL(18, 2) NOT NULL CHECK (DonGiaNhap >= 0),
    ThanhTienNhap AS (SoLuongNhap * DonGiaNhap),
    
    PRIMARY KEY (MaPN, MaSP),
    FOREIGN KEY (MaPN) REFERENCES PHIEUNHAP(MaPN),
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);

-- 10. BẢNG TÀI KHOẢN (TAIKHOAN)
CREATE TABLE TAIKHOAN (
    MaTK CHAR(10) PRIMARY KEY,
    TaiKhoan VARCHAR(50) UNIQUE NOT NULL,
    MatKhau VARCHAR(255) NOT NULL,
    MaNV CHAR(10) NOT NULL,
    QuyenHan NVARCHAR(50) NOT NULL, 
    
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

INSERT INTO NHANVIEN (MaNV, HoLot, TenNV, GioiTinh, NgaySinh, ChucVu) VALUES
('NV001', N'Nguyễn Văn', N'A', N'Nam', '1990-05-15', N'Quản lý'),
('NV002', N'Trần Thị', N'Bình', N'Nữ', '1995-10-20', N'Nhân viên bán hàng'),
('NV003', N'Lê Minh', N'Cường', N'Nam', '1988-01-01', N'Thủ kho');
INSERT INTO KHACHHANG (MaKH, HoLot, TenKH, GioiTinh, NgaySinh, SDT) VALUES
('KH001', N'Phạm Thị', N'Thu', N'Nữ', '1998-03-10', '0901112222'),
('KH002', N'Đỗ Văn', N'Tài', N'Nam', '1992-12-05', '0903334444'),
('KH003', N'Hoàng', N'Mai', N'Nữ', '2000-07-25', '0905556666');
INSERT INTO NHACUNGCAP (MaNCC, TenNCC, DiaChi, SDT) VALUES
('NCC01', N'Công ty CP Thực phẩm Xanh', N'123 Đường A, Quận 1, TP.HCM', '0281234567'),
('NCC02', N'Doanh nghiệp Tư nhân Điện tử Hùng', N'456 Đường B, Quận 5, TP.HCM', '0287654321');
INSERT INTO SANPHAM (MaSP, TenSP, LoaiSP, DonViTinh, DonGiaBan, TonKho) VALUES
('SP001', N'Sữa tươi Vinamilk 1L', N'Thực phẩm', N'Hộp', 35000.00, 150),
('SP002', N'Bánh quy bơ', N'Thực phẩm', N'Gói', 20000.00, 200),
('SP003', N'Tivi LED 43 inch', N'Điện tử', N'Cái', 8500000.00, 50),
('SP004', N'Bút bi Thiên Long', N'Văn phòng phẩm', N'Cây', 3000.00, 500);
INSERT INTO KHUYENMAI (MaKM, TenKM, GiaTri, NgayBatDau, NgayKetThuc) VALUES
('KM001', N'Giảm 10% tổng hóa đơn', N'10%', '2025-11-01', '2025-11-30'),
('KM002', N'Miễn phí vận chuyển', N'Miễn phí', '2025-10-01', '2025-12-31'),
('KM003', N'Giảm 50k cho hóa đơn từ 500k', N'50000', '2025-12-01', '2025-12-15');
INSERT INTO HOADON (MaHD, MaKH, MaNV, NgayLap, TongTien, MaKM) VALUES
-- Hóa đơn 1: Có khuyến mãi (KM001)
('HD001', 'KH001', 'NV002', '2025-11-10', 0.00, 'KM001'), 
-- Hóa đơn 2: Không khuyến mãi (NULL)
('HD002', 'KH002', 'NV002', '2025-11-15', 0.00, NULL),
-- Hóa đơn 3: Khách vãng lai (NULL cho MaKH)
('HD003', NULL, 'NV002', '2025-11-20', 0.00, NULL);
INSERT INTO CHITIETHOADON (MaHD, MaSP, SoLuong, DonGia) VALUES
-- Chi tiết cho HD001
('HD001', 'SP001', 2, 35000.00), -- 2 * 35000 = 70000
('HD001', 'SP002', 5, 20000.00), -- 5 * 20000 = 100000
-- Chi tiết cho HD002
('HD002', 'SP003', 1, 8500000.00), -- 1 * 8500000 = 8500000
-- Chi tiết cho HD003
('HD003', 'SP004', 10, 3000.00); -- 10 * 3000 = 30000
INSERT INTO PHIEUNHAP (MaPN, MaNCC, MaNV, NgayNhap, TongGiaTriNhap) VALUES
('PN001', 'NCC01', 'NV003', '2025-10-25', 0.00), -- Nhập hàng từ NCC01
('PN002', 'NCC02', 'NV003', '2025-11-05', 0.00); -- Nhập hàng từ NCC02
INSERT INTO CHITIETPHIEUNHAP (MaPN, MaSP, SoLuongNhap, DonGiaNhap) VALUES
-- Chi tiết cho PN001 (Thực phẩm)
('PN001', 'SP001', 100, 30000.00), -- Nhập 100 hộp Sữa (Giá nhập 30k)
('PN001', 'SP002', 150, 18000.00), -- Nhập 150 gói Bánh (Giá nhập 18k)
-- Chi tiết cho PN002 (Điện tử)
('PN002', 'SP003', 20, 8000000.00); -- Nhập 20 cái Tivi (Giá nhập 8tr)
INSERT INTO TAIKHOAN (MaTK, TaiKhoan, MatKhau, MaNV, QuyenHan) VALUES
('TK001', 'quanlya', 'matkhau_mahoa_1', 'NV001', N'Quản trị viên'), -- Tài khoản cho Quản lý NV001
('TK002', 'banhangb', 'matkhau_mahoa_2', 'NV002', N'Bán hàng'), -- Tài khoản cho NV Bán hàng NV002
('TK003', 'thukho', 'matkhau_mahoa_3', 'NV003', N'Quản lý kho'); -- Tài khoản cho Thủ kho NV003

DROP TABLE CHITIETHOADON; 
DROP TABLE CHITIETPHIEUNHAP; 
DROP TABLE HOADON;
DROP TABLE PHIEUNHAP;
DROP TABLE TAIKHOAN; 
DROP TABLE KHUYENMAI;
DROP TABLE SANPHAM;
DROP TABLE NHACUNGCAP;
DROP TABLE KHACHHANG;
DROP TABLE NHANVIEN;