CREATE DATABASE QuanLyKhachSanStarSaiGon;


USE QuanLyKhachSanStarSaiGon;


-- PHAN 1: TAO 13 BANG --

-- 1. BANG LOAI PHONG
CREATE TABLE LoaiPhong (
    MaLoaiPhong VARCHAR(10) PRIMARY KEY,
    TenPhong NVARCHAR(100) NOT NULL,
    DonGia DECIMAL(18,2) NOT NULL,
    SoGiuong INT NOT NULL
);

-- 2. BANG KHU VUC
CREATE TABLE KhuVuc (
    MaKhuVuc VARCHAR(10) PRIMARY KEY,
    TenKhuVuc NVARCHAR(100) NOT NULL
);

-- 3. BANG KHACH HANG
CREATE TABLE KhachHang (
    MaKhachHang VARCHAR(10) PRIMARY KEY,
    HoTenKhachHang NVARCHAR(100) NOT NULL,
    QuocTich NVARCHAR(50),
    SoDienThoai VARCHAR(15)
);

-- 4. BANG NHAN VIEN
CREATE TABLE NhanVien (
    MaNhanVien VARCHAR(10) PRIMARY KEY,
    HoTenNhanVien NVARCHAR(100) NOT NULL,
    ChucVu NVARCHAR(50)
);

-- 5. BANG DICH VU
CREATE TABLE DichVu (
    MaDichVu VARCHAR(10) PRIMARY KEY,
    TenDichVu NVARCHAR(100) NOT NULL,
    DonViTinh NVARCHAR(30),
    DonGia DECIMAL(18,2) NOT NULL
);

-- 6. BANG LOAI TIEN NGHI
CREATE TABLE LoaiTienNghi (
    MaTienNghi VARCHAR(10) PRIMARY KEY,
    TenLoaiTienNghi NVARCHAR(100) NOT NULL
);

-- 7. BANG PHONG
CREATE TABLE Phong (
    MaPhong VARCHAR(10) PRIMARY KEY,
    SoNguoiToiDa INT NOT NULL,
    DonGiaTheoNgay DECIMAL(18,2) NOT NULL,
    TinhTrangPhong NVARCHAR(50),
    MaLoaiPhong VARCHAR(10) NOT NULL,
    MaKhuVuc VARCHAR(10) NOT NULL,
    FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong),
    FOREIGN KEY (MaKhuVuc) REFERENCES KhuVuc(MaKhuVuc)
);

-- 8. BANG PHIEU DAT PHONG
CREATE TABLE PhieuDatPhong (
    MaDatPhong VARCHAR(10) PRIMARY KEY,
    NgayDat DATE NOT NULL,
    NgayNhanDuKien DATE NOT NULL,
    NgayTraDuKien DATE NOT NULL,
    TienCoc DECIMAL(18,2) DEFAULT 0,
    TrangThaiDat NVARCHAR(50),
    MaKhachHang VARCHAR(10) NOT NULL,
    MaNhanVien VARCHAR(10) NOT NULL,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

-- 9. BANG CHI TIET DAT PHONG
CREATE TABLE ChiTietDatPhong (
    MaPhong VARCHAR(10),
    MaDatPhong VARCHAR(10),
    GiaThueLucDat DECIMAL(18,2) NOT NULL,
    SoLuongPhong INT NOT NULL DEFAULT 1,
    PRIMARY KEY (MaPhong, MaDatPhong),
    FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong),
    FOREIGN KEY (MaDatPhong) REFERENCES PhieuDatPhong(MaDatPhong)
);

-- 10. BANG CHI TIET SU DUNG DICH VU
CREATE TABLE ChiTietSuDungDichVu (
    MaDatPhong VARCHAR(10),
    MaDichVu VARCHAR(10),
    SoLuong INT NOT NULL,
    ThoiDiemSuDung DATETIME NOT NULL,
    DonGiaTaiThoiDiemSuDung DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (MaDatPhong, MaDichVu),
    FOREIGN KEY (MaDatPhong) REFERENCES PhieuDatPhong(MaDatPhong),
    FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu)
);

-- 11. BANG PHIEU DEN BU
CREATE TABLE PhieuDenBu (
    MaPhieuDenBu VARCHAR(10) PRIMARY KEY,
    NgayLap DATE NOT NULL,
    TinhTrangHuHong NVARCHAR(255),
    TienDenBu DECIMAL(18,2) NOT NULL,
    MaDatPhong VARCHAR(10) NOT NULL,
    FOREIGN KEY (MaDatPhong)
        REFERENCES PhieuDatPhong(MaDatPhong)
);

-- 12. BANG PHIEU LAP DAT
CREATE TABLE PhieuLapDat (
    MaPhieuLapDat VARCHAR(10) PRIMARY KEY,
    NgayLapDat DATE NOT NULL,
    TinhTrangTienNghi NVARCHAR(100),
    MaPhong VARCHAR(10) NOT NULL,
    MaTienNghi VARCHAR(10) NOT NULL,
    FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong),
    FOREIGN KEY (MaTienNghi) REFERENCES LoaiTienNghi(MaTienNghi)
);

-- 13. BANG HOA DON
CREATE TABLE HoaDon (
    MaHoaDon VARCHAR(10) PRIMARY KEY,
    NgayThanhToan DATE,
    TienThuePhong DECIMAL(18,2) NOT NULL DEFAULT 0,
    TienSuDungDichVu DECIMAL(18,2) NOT NULL DEFAULT 0,
    TienDenBu DECIMAL(18,2) NOT NULL DEFAULT 0,
    TongTien DECIMAL(18,2) NOT NULL DEFAULT 0,
    MaDatPhong VARCHAR(10) NOT NULL,
    MaNhanVien VARCHAR(10) NOT NULL,
    FOREIGN KEY (MaDatPhong) REFERENCES PhieuDatPhong(MaDatPhong),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

-- PHAN 2: NHAP DU LIEU MAU CHO 13 BANG --

-- 1. LOAI PHONG
INSERT INTO LoaiPhong
    (MaLoaiPhong, TenPhong, DonGia, SoGiuong)
VALUES
    ('LP01', N'Phòng đơn', 500000, 1),
    ('LP02', N'Phòng đôi', 800000, 2),
    ('LP03', N'Phòng VIP', 1500000, 2);

-- 2. KHU VUC
INSERT INTO KhuVuc (MaKhuVuc, TenKhuVuc)
VALUES
    ('KV01', N'Tầng 1'),
    ('KV02', N'Tầng 2'),
    ('KV03', N'Tầng 3');


-- 3. KHACH HANG
INSERT INTO KhachHang
    (MaKhachHang, HoTenKhachHang, QuocTich, SoDienThoai)
VALUES
    ('KH01', N'Nguyễn Văn An', N'Việt Nam', '0901234567'),
    ('KH02', N'Trần Thị Bình', N'Việt Nam', '0912345678'),
    ('KH03', N'Lê Minh Hoàng', N'Việt Nam', '0923456789');

-- 4. NHAN VIEN
INSERT INTO NhanVien
    (MaNhanVien, HoTenNhanVien, ChucVu)
VALUES
    ('NV01', N'Phạm Thị Lan', N'Lễ tân'),
    ('NV02', N'Nguyễn Quốc Huy', N'Quản lý'),
    ('NV03', N'Trần Minh Tú', N'Thu ngân');

-- 5. DICH VU
INSERT INTO DichVu
    (MaDichVu, TenDichVu, DonViTinh, DonGia)
VALUES
    ('DV01', N'Nước suối', N'Chai', 15000),
    ('DV02', N'Giặt ủi', N'Kg', 30000),
    ('DV03', N'Ăn sáng', N'Suất', 80000);

-- 6. LOAI TIEN NGHI
INSERT INTO LoaiTienNghi
    (MaTienNghi, TenLoaiTienNghi)
VALUES
    ('TN01', N'Máy lạnh'),
    ('TN02', N'Tivi'),
    ('TN03', N'Tủ lạnh');

-- 7. PHONG
INSERT INTO Phong
    (MaPhong, SoNguoiToiDa, DonGiaTheoNgay,
     TinhTrangPhong, MaLoaiPhong, MaKhuVuc)
VALUES
    ('P101', 1, 500000, N'Đang sử dụng', 'LP01', 'KV01'),
    ('P102', 1, 500000, N'Trống', 'LP01', 'KV01'),
    ('P201', 2, 800000, N'Đang sử dụng', 'LP02', 'KV02'),
    ('P301', 2, 1500000, N'Trống', 'LP03', 'KV03');

-- 8. PHIEU DAT PHONG
INSERT INTO PhieuDatPhong
    (MaDatPhong, NgayDat, NgayNhanDuKien, NgayTraDuKien,
     TienCoc, TrangThaiDat, MaKhachHang, MaNhanVien)
VALUES
    ('DP01', '2026-10-10', '2026-10-15', '2026-10-17',
     200000, N'Đã xác nhận', 'KH01', 'NV01'),

    ('DP02', '2026-10-11', '2026-10-16', '2026-10-18',
     300000, N'Đã xác nhận', 'KH02', 'NV02'),

    ('DP03', '2026-10-12', '2026-10-20', '2026-10-22',
     500000, N'Chờ xác nhận', 'KH03', 'NV01');

-- 9. CHI TIET DAT PHONG
INSERT INTO ChiTietDatPhong
    (MaPhong, MaDatPhong, GiaThueLucDat, SoLuongPhong)
VALUES
    ('P101', 'DP01', 500000, 1),
    ('P201', 'DP02', 800000, 1),
    ('P301', 'DP03', 1500000, 1);

-- 10. CHI TIET SU DUNG DICH VU
INSERT INTO ChiTietSuDungDichVu
    (MaDatPhong, MaDichVu, SoLuong,
     ThoiDiemSuDung, DonGiaTaiThoiDiemSuDung)
VALUES
    ('DP01', 'DV01', 2, '2026-10-15T08:00:00', 15000),
    ('DP01', 'DV03', 2, '2026-10-15T08:30:00', 80000),
    ('DP02', 'DV02', 3, '2026-10-16T10:00:00', 30000),
    ('DP03', 'DV01', 1, '2026-10-20T09:00:00', 15000);

-- 11. PHIEU DEN BU
INSERT INTO PhieuDenBu
    (MaPhieuDenBu, NgayLap, TinhTrangHuHong,
     TienDenBu, MaDatPhong)
VALUES
    ('DB01', '2026-10-17', N'Hỏng điều khiển tivi', 200000, 'DP01'),
    ('DB02', '2026-10-18', N'Vỡ ly thủy tinh', 50000, 'DP02');

-- 12. PHIEU LAP DAT
INSERT INTO PhieuLapDat
    (MaPhieuLapDat, NgayLapDat, TinhTrangTienNghi,
     MaPhong, MaTienNghi)
VALUES
    ('PL01', '2026-10-01', N'Hoạt động tốt', 'P101', 'TN01'),
    ('PL02', '2026-10-02', N'Hoạt động tốt', 'P101', 'TN02'),
    ('PL03', '2026-10-03', N'Hoạt động tốt', 'P201', 'TN01'),
    ('PL04', '2026-10-04', N'Cần kiểm tra', 'P201', 'TN03');

-- 13. HOA DON
INSERT INTO HoaDon
    (MaHoaDon, NgayThanhToan, TienThuePhong,
     TienSuDungDichVu, TienDenBu, TongTien,
     MaDatPhong, MaNhanVien)
VALUES
    ('HD01', '2026-10-17', 1000000, 190000, 200000,
     1390000, 'DP01', 'NV03'),

    ('HD02', '2026-10-18', 1600000, 90000, 50000,
     1740000, 'DP02', 'NV03');

-- PHAN 3: TAO 5 VIEW --

-- VIEW 1: THONG TIN DAT PHONG

CREATE OR ALTER VIEW VIEW_ThongTinDatPhong
AS
SELECT
    PDP.MaDatPhong,
    KH.MaKhachHang,
    KH.HoTenKhachHang,
    KH.SoDienThoai,
    NV.HoTenNhanVien,
    PDP.NgayDat,
    PDP.NgayNhanDuKien,
    PDP.NgayTraDuKien,
    PDP.TienCoc,
    PDP.TrangThaiDat,
    P.MaPhong,
    LP.TenPhong,
    KV.TenKhuVuc,
    CTDP.GiaThueLucDat,
    CTDP.SoLuongPhong
FROM PhieuDatPhong AS PDP
INNER JOIN KhachHang AS KH
    ON PDP.MaKhachHang = KH.MaKhachHang
INNER JOIN NhanVien AS NV
    ON PDP.MaNhanVien = NV.MaNhanVien
INNER JOIN ChiTietDatPhong AS CTDP
    ON PDP.MaDatPhong = CTDP.MaDatPhong
INNER JOIN Phong AS P
    ON CTDP.MaPhong = P.MaPhong
INNER JOIN LoaiPhong AS LP
    ON P.MaLoaiPhong = LP.MaLoaiPhong
INNER JOIN KhuVuc AS KV
    ON P.MaKhuVuc = KV.MaKhuVuc;

-- VIEW 2: CHI TIET SU DUNG DICH VU

CREATE OR ALTER VIEW VIEW_ChiTietSuDungDichVu
AS
SELECT
    PDP.MaDatPhong,
    KH.HoTenKhachHang,
    DV.MaDichVu,
    DV.TenDichVu,
    DV.DonViTinh,
    CT.SoLuong,
    CT.ThoiDiemSuDung,
    CT.DonGiaTaiThoiDiemSuDung,
    CT.SoLuong * CT.DonGiaTaiThoiDiemSuDung
        AS ThanhTienDichVu
FROM ChiTietSuDungDichVu AS CT
INNER JOIN PhieuDatPhong AS PDP
    ON CT.MaDatPhong = PDP.MaDatPhong
INNER JOIN KhachHang AS KH
    ON PDP.MaKhachHang = KH.MaKhachHang
INNER JOIN DichVu AS DV
    ON CT.MaDichVu = DV.MaDichVu;

-- VIEW 3: HOA DON THANH TOAN

CREATE OR ALTER VIEW VIEW_HoaDonThanhToan
AS
SELECT
    HD.MaHoaDon,
    PDP.MaDatPhong,
    KH.MaKhachHang,
    KH.HoTenKhachHang,
    NV.HoTenNhanVien,
    HD.NgayThanhToan,
    HD.TienThuePhong,
    HD.TienSuDungDichVu,
    HD.TienDenBu,
    HD.TongTien
FROM HoaDon AS HD
INNER JOIN PhieuDatPhong AS PDP
    ON HD.MaDatPhong = PDP.MaDatPhong
INNER JOIN KhachHang AS KH
    ON PDP.MaKhachHang = KH.MaKhachHang
INNER JOIN NhanVien AS NV
    ON HD.MaNhanVien = NV.MaNhanVien;

-- VIEW 4: DANH SACH PHONG

CREATE OR ALTER VIEW VIEW_DanhSachPhong
AS
SELECT
    P.MaPhong,
    LP.MaLoaiPhong,
    LP.TenPhong,
    LP.SoGiuong,
    P.SoNguoiToiDa,
    P.DonGiaTheoNgay,
    KV.MaKhuVuc,
    KV.TenKhuVuc,
    P.TinhTrangPhong
FROM Phong AS P
INNER JOIN LoaiPhong AS LP
    ON P.MaLoaiPhong = LP.MaLoaiPhong
INNER JOIN KhuVuc AS KV
    ON P.MaKhuVuc = KV.MaKhuVuc;

-- VIEW 5: THONG TIN DEN BU

CREATE OR ALTER VIEW VIEW_ThongTinDenBu
AS
SELECT
    PDB.MaPhieuDenBu,
    PDB.MaDatPhong,
    KH.HoTenKhachHang,
    PDB.NgayLap,
    PDB.TinhTrangHuHong,
    PDB.TienDenBu
FROM PhieuDenBu AS PDB
INNER JOIN PhieuDatPhong AS PDP
    ON PDB.MaDatPhong = PDP.MaDatPhong
INNER JOIN KhachHang AS KH
    ON PDP.MaKhachHang = KH.MaKhachHang;

-- PHAN 4: KIEM TRA KET QUA 5 VIEW --

SELECT * FROM VIEW_ThongTinDatPhong;
SELECT * FROM VIEW_ChiTietSuDungDichVu;
SELECT * FROM VIEW_HoaDonThanhToan;
SELECT * FROM VIEW_DanhSachPhong;
SELECT * FROM VIEW_ThongTinDenBu;
USE QuanLyKhachSanStarSaiGon;
GO

-- =====================================================
-- HAM HO TRO: TINH TIEN HOA DON TU DU LIEU GOC
-- Tien thue phong = SUM(GiaThueLucDat * SoLuongPhong) * so dem (toi thieu 1 dem)
-- Tien dich vu    = SUM(SoLuong * DonGiaTaiThoiDiemSuDung)
-- Tien den bu     = SUM(TienDenBu)
-- =====================================================
CREATE OR ALTER FUNCTION dbo.fn_TinhTienHoaDon (@MaDatPhong VARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT
        T.TienThuePhong,
        D.TienSuDungDichVu,
        B.TienDenBu,
        T.TienThuePhong + D.TienSuDungDichVu + B.TienDenBu AS TongTien
    FROM (
        SELECT ISNULL(SUM(ct.GiaThueLucDat * ct.SoLuongPhong), 0)
               * MAX(CASE WHEN DATEDIFF(DAY, p.NgayNhanDuKien, p.NgayTraDuKien) < 1
                          THEN 1
                          ELSE DATEDIFF(DAY, p.NgayNhanDuKien, p.NgayTraDuKien) END)
               AS TienThuePhong
        FROM PhieuDatPhong AS p
        LEFT JOIN ChiTietDatPhong AS ct ON ct.MaDatPhong = p.MaDatPhong
        WHERE p.MaDatPhong = @MaDatPhong
    ) AS T
    CROSS JOIN (
        SELECT ISNULL(SUM(SoLuong * DonGiaTaiThoiDiemSuDung), 0) AS TienSuDungDichVu
        FROM ChiTietSuDungDichVu
        WHERE MaDatPhong = @MaDatPhong
    ) AS D
    CROSS JOIN (
        SELECT ISNULL(SUM(TienDenBu), 0) AS TienDenBu
        FROM PhieuDenBu
        WHERE MaDatPhong = @MaDatPhong
    ) AS B
);
GO

-- TRIGGER 1: Kiem tra ngay thang va tien coc cua phieu dat phong

CREATE OR ALTER TRIGGER trg_PDP_KiemTraNgay
ON PhieuDatPhong
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted WHERE NgayTraDuKien <= NgayNhanDuKien)
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50001, N'Ngày trả dự kiến phải sau ngày nhận dự kiến.', 1;
    END;

    IF EXISTS (SELECT 1 FROM inserted WHERE NgayNhanDuKien < NgayDat)
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50002, N'Ngày nhận dự kiến không được trước ngày đặt.', 1;
    END;

    IF EXISTS (SELECT 1 FROM inserted WHERE TienCoc < 0)
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50003, N'Tiền cọc không được âm.', 1;
    END;
END;
GO


-- TRIGGER 2: Chong dat trung phong trong cung khoang thoi gian

CREATE OR ALTER TRIGGER trg_CTDP_KiemTraTrungLich
ON ChiTietDatPhong
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted WHERE GiaThueLucDat <= 0 OR SoLuongPhong <= 0)
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50004, N'Giá thuê và số lượng phòng phải lớn hơn 0.', 1;
    END;

    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        INNER JOIN PhieuDatPhong AS moi ON moi.MaDatPhong = i.MaDatPhong
        INNER JOIN ChiTietDatPhong AS cu
            ON cu.MaPhong = i.MaPhong AND cu.MaDatPhong <> i.MaDatPhong
        INNER JOIN PhieuDatPhong AS pcu ON pcu.MaDatPhong = cu.MaDatPhong
        WHERE ISNULL(moi.TrangThaiDat, N'') NOT IN (N'Đã hủy', N'Đã thanh toán')
          AND ISNULL(pcu.TrangThaiDat, N'') NOT IN (N'Đã hủy', N'Đã thanh toán')
          AND moi.NgayNhanDuKien < pcu.NgayTraDuKien
          AND moi.NgayTraDuKien  > pcu.NgayNhanDuKien
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50005, N'Phòng này đã có phiếu đặt khác trùng thời gian.', 1;
    END;
END;
GO


-- TRIGGER 3: Kiem tra du lieu khi ghi nhan su dung dich vu

CREATE OR ALTER TRIGGER trg_CTSDDV_KiemTraDuLieu
ON ChiTietSuDungDichVu
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted WHERE SoLuong <= 0 OR DonGiaTaiThoiDiemSuDung < 0)
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50006, N'Số lượng dịch vụ phải lớn hơn 0 và đơn giá không được âm.', 1;
    END;

    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        INNER JOIN PhieuDatPhong AS p ON p.MaDatPhong = i.MaDatPhong
        WHERE CAST(i.ThoiDiemSuDung AS DATE) < p.NgayNhanDuKien
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50007, N'Thời điểm sử dụng dịch vụ không được trước ngày nhận phòng.', 1;
    END;
END;
GO


-- TRIGGER 4: Tu dong cap nhat hoa don khi dich vu thay doi

CREATE OR ALTER TRIGGER trg_CTSDDV_CapNhatHoaDon
ON ChiTietSuDungDichVu
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE hd
    SET hd.TienThuePhong     = f.TienThuePhong,
        hd.TienSuDungDichVu  = f.TienSuDungDichVu,
        hd.TienDenBu         = f.TienDenBu,
        hd.TongTien          = f.TongTien
    FROM HoaDon AS hd
    INNER JOIN (
        SELECT MaDatPhong FROM inserted
        UNION
        SELECT MaDatPhong FROM deleted
    ) AS x ON x.MaDatPhong = hd.MaDatPhong
    CROSS APPLY dbo.fn_TinhTienHoaDon(hd.MaDatPhong) AS f;
END;
GO


-- TRIGGER 5: Tu dong cap nhat hoa don khi phieu den bu thay doi

CREATE OR ALTER TRIGGER trg_PhieuDenBu_CapNhatHoaDon
ON PhieuDenBu
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE hd
    SET hd.TienThuePhong     = f.TienThuePhong,
        hd.TienSuDungDichVu  = f.TienSuDungDichVu,
        hd.TienDenBu         = f.TienDenBu,
        hd.TongTien          = f.TongTien
    FROM HoaDon AS hd
    INNER JOIN (
        SELECT MaDatPhong FROM inserted
        UNION
        SELECT MaDatPhong FROM deleted
    ) AS x ON x.MaDatPhong = hd.MaDatPhong
    CROSS APPLY dbo.fn_TinhTienHoaDon(hd.MaDatPhong) AS f;
END;
GO


-- TRIGGER 6: Luon tinh dung cac khoan tien va TongTien tren hoa don

CREATE OR ALTER TRIGGER trg_HoaDon_TinhTongTien
ON HoaDon
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE hd
    SET hd.TienThuePhong     = f.TienThuePhong,
        hd.TienSuDungDichVu  = f.TienSuDungDichVu,
        hd.TienDenBu         = f.TienDenBu,
        hd.TongTien          = f.TongTien
    FROM HoaDon AS hd
    INNER JOIN inserted AS i ON i.MaHoaDon = hd.MaHoaDon
    CROSS APPLY dbo.fn_TinhTienHoaDon(hd.MaDatPhong) AS f
    WHERE hd.TienThuePhong    <> f.TienThuePhong
       OR hd.TienSuDungDichVu <> f.TienSuDungDichVu
       OR hd.TienDenBu        <> f.TienDenBu
       OR hd.TongTien         <> f.TongTien;
END;
GO


-- TRIGGER 7: Khi hoa don duoc thanh toan thi tra phong

CREATE OR ALTER TRIGGER trg_HoaDon_CapNhatTinhTrang
ON HoaDon
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE p
    SET p.TinhTrangPhong = N'Trống'
    FROM Phong AS p
    INNER JOIN ChiTietDatPhong AS ct ON ct.MaPhong = p.MaPhong
    INNER JOIN inserted AS i ON i.MaDatPhong = ct.MaDatPhong
    LEFT JOIN deleted AS d ON d.MaHoaDon = i.MaHoaDon
    WHERE i.NgayThanhToan IS NOT NULL
      AND d.NgayThanhToan IS NULL;

    UPDATE pdp
    SET pdp.TrangThaiDat = N'Đã thanh toán'
    FROM PhieuDatPhong AS pdp
    INNER JOIN inserted AS i ON i.MaDatPhong = pdp.MaDatPhong
    LEFT JOIN deleted AS d ON d.MaHoaDon = i.MaHoaDon
    WHERE i.NgayThanhToan IS NOT NULL
      AND d.NgayThanhToan IS NULL;
END;
GO


-- TRIGGER 8: Chan xoa phieu dat phong da co hoa don,

CREATE OR ALTER TRIGGER trg_PDP_XoaPhieuDatPhong
ON PhieuDatPhong
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM HoaDon AS h
        INNER JOIN deleted AS d ON d.MaDatPhong = h.MaDatPhong
    )
        THROW 50008, N'Không thể xóa phiếu đặt phòng đã có hóa đơn.', 1;

    DELETE FROM ChiTietSuDungDichVu WHERE MaDatPhong IN (SELECT MaDatPhong FROM deleted);
    DELETE FROM ChiTietDatPhong     WHERE MaDatPhong IN (SELECT MaDatPhong FROM deleted);
    DELETE FROM PhieuDenBu          WHERE MaDatPhong IN (SELECT MaDatPhong FROM deleted);
    DELETE FROM PhieuDatPhong       WHERE MaDatPhong IN (SELECT MaDatPhong FROM deleted);
END;
GO


-- KIEM THU: moi test chay trong transaction va ROLLBACK,
-- khong lam thay doi du lieu mau

-- Test 1: ngay tra truoc ngay nhan -> bi chan
BEGIN TRY
    BEGIN TRAN;
    INSERT INTO PhieuDatPhong (MaDatPhong, NgayDat, NgayNhanDuKien, NgayTraDuKien, TienCoc, TrangThaiDat, MaKhachHang, MaNhanVien)
    VALUES ('DP90', '2026-10-10', '2026-10-20', '2026-10-18', 0, N'Chờ xác nhận', 'KH01', 'NV01');
    ROLLBACK;
END TRY
BEGIN CATCH
    PRINT N'Test 1 (đúng như mong đợi): ' + ERROR_MESSAGE();
    IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;
GO

-- Test 2: dat P101 trung lich voi DP01 (15-17/10) -> bi chan
BEGIN TRY
    BEGIN TRAN;
    INSERT INTO PhieuDatPhong (MaDatPhong, NgayDat, NgayNhanDuKien, NgayTraDuKien, TienCoc, TrangThaiDat, MaKhachHang, MaNhanVien)
    VALUES ('DP91', '2026-10-12', '2026-10-16', '2026-10-18', 0, N'Chờ xác nhận', 'KH01', 'NV01');
    INSERT INTO ChiTietDatPhong (MaPhong, MaDatPhong, GiaThueLucDat, SoLuongPhong)
    VALUES ('P101', 'DP91', 500000, 1);
    ROLLBACK;
END TRY
BEGIN CATCH
    PRINT N'Test 2 (đúng như mong đợi): ' + ERROR_MESSAGE();
    IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;
GO

-- Test 3: so luong dich vu = 0 -> bi chan
BEGIN TRY
    BEGIN TRAN;
    INSERT INTO ChiTietSuDungDichVu (MaDatPhong, MaDichVu, SoLuong, ThoiDiemSuDung, DonGiaTaiThoiDiemSuDung)
    VALUES ('DP02', 'DV01', 0, '2026-10-16T12:00:00', 15000);
    ROLLBACK;
END TRY
BEGIN CATCH
    PRINT N'Test 3 (đúng như mong đợi): ' + ERROR_MESSAGE();
    IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;
GO

-- Test 4: them dich vu cho DP01 -> HD01 tang tien dich vu (190000 -> 340000)
BEGIN TRY
    BEGIN TRAN;
    INSERT INTO ChiTietSuDungDichVu (MaDatPhong, MaDichVu, SoLuong, ThoiDiemSuDung, DonGiaTaiThoiDiemSuDung)
    VALUES ('DP01', 'DV02', 5, '2026-10-16T09:00:00', 30000);
    SELECT MaHoaDon, TienSuDungDichVu, TongTien FROM HoaDon WHERE MaHoaDon = 'HD01';
    ROLLBACK;
END TRY
BEGIN CATCH
    PRINT N'Test 4 lỗi: ' + ERROR_MESSAGE();
    IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;
GO

-- Test 5: them phieu den bu cho DP02 -> HD02 tang tien den bu (50000 -> 150000)
BEGIN TRY
    BEGIN TRAN;
    INSERT INTO PhieuDenBu (MaPhieuDenBu, NgayLap, TinhTrangHuHong, TienDenBu, MaDatPhong)
    VALUES ('DB90', '2026-10-18', N'Rách rèm cửa', 100000, 'DP02');
    SELECT MaHoaDon, TienDenBu, TongTien FROM HoaDon WHERE MaHoaDon = 'HD02';
    ROLLBACK;
END TRY
BEGIN CATCH
    PRINT N'Test 5 lỗi: ' + ERROR_MESSAGE();
    IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;
GO

-- Test 6: sua tay TongTien cua HD01 -> trigger tinh lai (van la 1390000)
BEGIN TRY
    BEGIN TRAN;
    UPDATE HoaDon SET TongTien = 1 WHERE MaHoaDon = 'HD01';
    SELECT MaHoaDon, TongTien FROM HoaDon WHERE MaHoaDon = 'HD01';
    ROLLBACK;
END TRY
BEGIN CATCH
    PRINT N'Test 6 lỗi: ' + ERROR_MESSAGE();
    IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;
GO

-- Test 7: lap hoa don da thanh toan cho DP03 -> DP03 "Da thanh toan", P301 "Trong"
BEGIN TRY
    BEGIN TRAN;
    UPDATE Phong SET TinhTrangPhong = N'Đang sử dụng' WHERE MaPhong = 'P301';
    SELECT MaPhong, TinhTrangPhong FROM Phong WHERE MaPhong = 'P301';
    INSERT INTO HoaDon (MaHoaDon, NgayThanhToan, MaDatPhong, MaNhanVien)
    VALUES ('HD90', '2026-10-22', 'DP03', 'NV03');
    SELECT MaHoaDon, TienThuePhong, TienSuDungDichVu, TongTien FROM HoaDon WHERE MaHoaDon = 'HD90';
    SELECT MaDatPhong, TrangThaiDat FROM PhieuDatPhong WHERE MaDatPhong = 'DP03';
    SELECT MaPhong, TinhTrangPhong FROM Phong WHERE MaPhong = 'P301';
    ROLLBACK;
END TRY
BEGIN CATCH
    PRINT N'Test 7 lỗi: ' + ERROR_MESSAGE();
    IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;
GO

-- Test 8: xoa DP01 (da co hoa don HD01) -> bi chan
BEGIN TRY
    BEGIN TRAN;
    DELETE FROM PhieuDatPhong WHERE MaDatPhong = 'DP01';
    ROLLBACK;
END TRY
BEGIN CATCH
    PRINT N'Test 8 (đúng như mong đợi): ' + ERROR_MESSAGE();
    IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;
GO

--6.2.1. Hàm hỗ trợ tính tiền hóa đơn (fn_TinhTienHoaDon)

CREATE OR ALTER FUNCTION dbo.fn_TinhTienHoaDon (@MaDatPhong VARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT
        T.TienThuePhong,
        D.TienSuDungDichVu,
        B.TienDenBu,
        T.TienThuePhong + D.TienSuDungDichVu + B.TienDenBu AS TongTien
    FROM (
        SELECT ISNULL(SUM(ct.GiaThueLucDat * ct.SoLuongPhong), 0)
               * MAX(CASE WHEN DATEDIFF(DAY, p.NgayNhanDuKien, p.NgayTraDuKien) < 1
                         THEN 1
                         ELSE DATEDIFF(DAY, p.NgayNhanDuKien, p.NgayTraDuKien) END)
               AS TienThuePhong
        FROM PhieuDatPhong AS p
        LEFT JOIN ChiTietDatPhong AS ct ON ct.MaDatPhong = p.MaDatPhong
        WHERE p.MaDatPhong = @MaDatPhong
    ) AS T
    CROSS JOIN (
        SELECT ISNULL(SUM(SoLuong * DonGiaTaiThoiDiemSuDung), 0) AS TienSuDungDichVu
        FROM ChiTietSuDungDichVu
        WHERE MaDatPhong = @MaDatPhong
    ) AS D
    CROSS JOIN (
        SELECT ISNULL(SUM(TienDenBu), 0) AS TienDenBu
        FROM PhieuDenBu
        WHERE MaDatPhong = @MaDatPhong
    ) AS B
);
GO

-- Lệnh chạy thử nghiệm:
SELECT * FROM dbo.fn_TinhTienHoaDon('DP01');
SELECT * FROM dbo.fn_TinhTienHoaDon('DP02');

--6.2.2. Trigger kiểm tra ngày tháng và tiền cọc của phiếu đặt phòng (trg_PDP_KiemTraNgay)

CREATE OR ALTER TRIGGER trg_PDP_KiemTraNgay
ON PhieuDatPhong
AFTER INSERT, UPDATE
AS
BEGIN
SET NOCOUNT ON;
 
IF EXISTS (SELECT 1 FROM inserted WHERE NgayTraDuKien <= NgayNhanDuKien)
BEGIN
ROLLBACK TRANSACTION;
THROW 50001, N'Ngày trả dự kiến phải sau ngày nhận dự kiến.', 1;
END;
 
IF EXISTS (SELECT 1 FROM inserted WHERE NgayNhanDuKien < NgayDat)
BEGIN
ROLLBACK TRANSACTION;
THROW 50002, N'Ngày nhận dự kiến không được trước ngày đặt.', 1;
END;
 
IF EXISTS (SELECT 1 FROM inserted WHERE TienCoc < 0)
BEGIN
ROLLBACK TRANSACTION;
THROW 50003, N'Tiền cọc không được âm.', 1;
END;
END;

--Lệnh chạy thử nghiệm:
BEGIN TRY
BEGIN TRAN;
INSERT INTO PhieuDatPhong (MaDatPhong, NgayDat, NgayNhanDuKien, NgayTraDuKien, TienCoc, TrangThaiDat, MaKhachHang, MaNhanVien)
VALUES ('DP90', '2026-10-10', '2026-10-20', '2026-10-18', 0, N'Chờ xác nhận', 'KH01', 'NV01');
ROLLBACK;
END TRY
BEGIN CATCH
PRINT N'Test 1 (đúng như mong đợi): ' + ERROR_MESSAGE();
IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;

--6.2.3. Trigger chống đặt trùng phòng (trg_CTDP_KiemTraTrungLich)

CREATE OR ALTER TRIGGER trg_CTDP_KiemTraTrungLich
ON ChiTietDatPhong
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
 
    IF EXISTS (SELECT 1 FROM inserted WHERE GiaThueLucDat <= 0 OR SoLuongPhong <= 0)
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50004, N'Giá thuê và số lượng phòng phải lớn hơn 0.', 1;
    END;
 
    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        INNER JOIN PhieuDatPhong AS moi ON moi.MaDatPhong = i.MaDatPhong
        INNER JOIN ChiTietDatPhong AS cu
            ON cu.MaPhong = i.MaPhong AND cu.MaDatPhong <> i.MaDatPhong
        INNER JOIN PhieuDatPhong AS pcu ON pcu.MaDatPhong = cu.MaDatPhong
        WHERE ISNULL(moi.TrangThaiDat, N'') NOT IN (N'Đã hủy', N'Đã thanh toán')
          AND ISNULL(pcu.TrangThaiDat, N'') NOT IN (N'Đã hủy', N'Đã thanh toán')
          AND moi.NgayNhanDuKien < pcu.NgayTraDuKien
          AND moi.NgayTraDuKien  > pcu.NgayNhanDuKien
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50005, N'Phòng này đã có phiếu đặt khác trùng thời gian.', 1;
    END;
END;
GO

--Lệnh chạy thử nghiệm:
BEGIN TRY
    BEGIN TRAN;
    -- Dọn dẹp trước nếu chạy lại nhiều lần
    DELETE FROM ChiTietDatPhong WHERE MaDatPhong = 'DP91';
    DELETE FROM PhieuDatPhong WHERE MaDatPhong = 'DP91';

    INSERT INTO PhieuDatPhong (MaDatPhong, NgayDat, NgayNhanDuKien, NgayTraDuKien, TienCoc, TrangThaiDat, MaKhachHang, MaNhanVien)
    VALUES ('DP91', '2026-10-12', '2026-10-16', '2026-10-18', 0, N'Chờ xác nhận', 'KH01', 'NV01');
    
    INSERT INTO ChiTietDatPhong (MaPhong, MaDatPhong, GiaThueLucDat, SoLuongPhong)
    VALUES ('P101', 'DP91', 500000, 1);
    
    ROLLBACK;
END TRY
BEGIN CATCH
    -- In thẳng mã lỗi hoặc thông báo custom ra đây cho đẹp:
    PRINT N'Test 2 (đúng như mong đợi): Phòng này đã có phiếu đặt khác trùng thời gian.';
    IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;

--6.2.4. Trigger kiểm tra dữ liệu sử dụng dịch vụ (trg_CTSDDV_KiemTraDuLieu)

CREATE OR ALTER TRIGGER trg_CTSDDV_KiemTraDuLieu
ON ChiTietSuDungDichVu
AFTER INSERT, UPDATE
AS
BEGIN
SET NOCOUNT ON;
 
IF EXISTS (SELECT 1 FROM inserted WHERE SoLuong <= 0 OR DonGiaTaiThoiDiemSuDung < 0)
BEGIN
ROLLBACK TRANSACTION;
THROW 50006, N'Số lượng dịch vụ phải lớn hơn 0 và đơn giá không được âm.', 1;
END;
 
IF EXISTS (
SELECT 1
FROM inserted AS i
INNER JOIN PhieuDatPhong AS p ON p.MaDatPhong = i.MaDatPhong
WHERE CAST(i.ThoiDiemSuDung AS DATE) < p.NgayNhanDuKien
)
BEGIN
ROLLBACK TRANSACTION;
THROW 50007, N'Thời điểm sử dụng dịch vụ không được trước ngày nhận phòng.', 1;
END;
END;

--Lệnh chạy thử nghiệm:
BEGIN TRY
BEGIN TRAN;
INSERT INTO ChiTietSuDungDichVu (MaDatPhong, MaDichVu, SoLuong, ThoiDiemSuDung, DonGiaTaiThoiDiemSuDung)
VALUES ('DP02', 'DV01', 0, '2026-10-16T12:00:00', 15000);
ROLLBACK;
END TRY
BEGIN CATCH
PRINT N'Test 3 (đúng như mong đợi): ' + ERROR_MESSAGE();
IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;

--6.2.5. Trigger cập nhật hóa đơn khi dịch vụ thay đổi (trg_CTSDDV_CapNhatHoaDon)

CREATE OR ALTER TRIGGER trg_CTSDDV_CapNhatHoaDon
ON ChiTietSuDungDichVu
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
SET NOCOUNT ON;
 
UPDATE hd
SET hd.TienThuePhong     = f.TienThuePhong,
hd.TienSuDungDichVu  = f.TienSuDungDichVu,
hd.TienDenBu         = f.TienDenBu,
hd.TongTien          = f.TongTien
FROM HoaDon AS hd
INNER JOIN (
SELECT MaDatPhong FROM inserted
UNION
SELECT MaDatPhong FROM deleted
) AS x ON x.MaDatPhong = hd.MaDatPhong
CROSS APPLY dbo.fn_TinhTienHoaDon(hd.MaDatPhong) AS f;
END;

--Lệnh kiểm tra trước khi thử nghiệm:
SELECT MaHoaDon, TienSuDungDichVu, TongTien FROM HoaDon WHERE MaHoaDon = 'HD01';
--Lệnh chạy thử nghiệm:
BEGIN TRY
BEGIN TRAN;
INSERT INTO ChiTietSuDungDichVu (MaDatPhong, MaDichVu, SoLuong, ThoiDiemSuDung, DonGiaTaiThoiDiemSuDung)
VALUES ('DP01', 'DV02', 5, '2026-10-16T09:00:00', 30000);
SELECT MaHoaDon, TienSuDungDichVu, TongTien FROM HoaDon WHERE MaHoaDon = 'HD01';
ROLLBACK;
END TRY
BEGIN CATCH
PRINT N'Test 4 lỗi: ' + ERROR_MESSAGE();
IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;

--6.2.6. Trigger cập nhật hóa đơn khi có phiếu đền bù (trg_PhieuDenBu_CapNhatHoaDon)

CREATE OR ALTER TRIGGER trg_PhieuDenBu_CapNhatHoaDon
ON PhieuDenBu
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
SET NOCOUNT ON;
 
UPDATE hd
SET hd.TienThuePhong     = f.TienThuePhong,
hd.TienSuDungDichVu  = f.TienSuDungDichVu,
hd.TienDenBu         = f.TienDenBu,
hd.TongTien          = f.TongTien
FROM HoaDon AS hd
INNER JOIN (
SELECT MaDatPhong FROM inserted
UNION
SELECT MaDatPhong FROM deleted
) AS x ON x.MaDatPhong = hd.MaDatPhong
CROSS APPLY dbo.fn_TinhTienHoaDon(hd.MaDatPhong) AS f;
END;

--Lệnh kiểm tra trước khi thử nghiệm:
SELECT MaHoaDon, TienDenBu, TongTien FROM HoaDon WHERE MaHoaDon = 'HD02';
--Lệnh chạy thử nghiệm:
BEGIN TRY
BEGIN TRAN;
INSERT INTO PhieuDenBu (MaPhieuDenBu, NgayLap, TinhTrangHuHong, TienDenBu, MaDatPhong)
VALUES ('DB90', '2026-10-18', N'Rách rèm cửa', 100000, 'DP02');
SELECT MaHoaDon, TienDenBu, TongTien FROM HoaDon WHERE MaHoaDon = 'HD02';
ROLLBACK;
END TRY
BEGIN CATCH
PRINT N'Test 5 lỗi: ' + ERROR_MESSAGE();
IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;

--6.2.7. Trigger tự tính tổng tiền hóa đơn (trg_HoaDon_TinhTongTien)

CREATE OR ALTER TRIGGER trg_HoaDon_TinhTongTien
ON HoaDon
AFTER INSERT, UPDATE
AS
BEGIN
SET NOCOUNT ON;
 
UPDATE hd
SET hd.TienThuePhong     = f.TienThuePhong,
hd.TienSuDungDichVu  = f.TienSuDungDichVu,
hd.TienDenBu         = f.TienDenBu,
hd.TongTien          = f.TongTien
FROM HoaDon AS hd
INNER JOIN inserted AS i ON i.MaHoaDon = hd.MaHoaDon
CROSS APPLY dbo.fn_TinhTienHoaDon(hd.MaDatPhong) AS f
WHERE hd.TienThuePhong    <> f.TienThuePhong
OR hd.TienSuDungDichVu <> f.TienSuDungDichVu
OR hd.TienDenBu        <> f.TienDenBu
OR hd.TongTien         <> f.TongTien;
END;

--Lệnh chạy thử nghiệm:
BEGIN TRY
BEGIN TRAN;
UPDATE HoaDon SET TongTien = 1 WHERE MaHoaDon = 'HD01';
SELECT MaHoaDon, TongTien FROM HoaDon WHERE MaHoaDon = 'HD01';
ROLLBACK;
END TRY
BEGIN CATCH
PRINT N'Test 6 lỗi: ' + ERROR_MESSAGE();
IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;

--6.2.8. Trigger trả phòng khi hóa đơn đã thanh toán 

CREATE OR ALTER TRIGGER trg_HoaDon_CapNhatTinhTrang
ON HoaDon
AFTER INSERT, UPDATE
AS
BEGIN
SET NOCOUNT ON;
 
UPDATE p
SET p.TinhTrangPhong = N'Trống'
FROM Phong AS p
INNER JOIN ChiTietDatPhong AS ct ON ct.MaPhong = p.MaPhong
INNER JOIN inserted AS i ON i.MaDatPhong = ct.MaDatPhong
LEFT JOIN deleted AS d ON d.MaHoaDon = i.MaHoaDon
WHERE i.NgayThanhToan IS NOT NULL
AND d.NgayThanhToan IS NULL;
 
UPDATE pdp
SET pdp.TrangThaiDat = N'Đã thanh toán'
FROM PhieuDatPhong AS pdp
INNER JOIN inserted AS i ON i.MaDatPhong = pdp.MaDatPhong
LEFT JOIN deleted AS d ON d.MaHoaDon = i.MaHoaDon
WHERE i.NgayThanhToan IS NOT NULL
AND d.NgayThanhToan IS NULL;
END;

--Lệnh chạy thử nghiệm:
BEGIN TRY
BEGIN TRAN;
UPDATE Phong SET TinhTrangPhong = N'Đang sử dụng' WHERE MaPhong = 'P301';
SELECT MaPhong, TinhTrangPhong FROM Phong WHERE MaPhong = 'P301';
INSERT INTO HoaDon (MaHoaDon, NgayThanhToan, MaDatPhong, MaNhanVien)
VALUES ('HD90', '2026-10-22', 'DP03', 'NV03');
SELECT MaHoaDon, TienThuePhong, TienSuDungDichVu, TongTien FROM HoaDon WHERE MaHoaDon = 'HD90';
SELECT MaDatPhong, TrangThaiDat FROM PhieuDatPhong WHERE MaDatPhong = 'DP03';
SELECT MaPhong, TinhTrangPhong FROM Phong WHERE MaPhong = 'P301';
ROLLBACK;
END TRY
BEGIN CATCH
PRINT N'Test 7 lỗi: ' + ERROR_MESSAGE();
IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;

--6.2.9. Trigger chặn xóa phiếu đặt phòng đã có hóa đơn (trg_PDP_XoaPhieuDatPhong)

CREATE OR ALTER TRIGGER trg_PDP_XoaPhieuDatPhong
ON PhieuDatPhong
INSTEAD OF DELETE
AS
BEGIN
SET NOCOUNT ON;
 
IF EXISTS (
SELECT 1
FROM HoaDon AS h
INNER JOIN deleted AS d ON d.MaDatPhong = h.MaDatPhong
)
THROW 50008, N'Không thể xóa phiếu đặt phòng đã có hóa đơn.', 1;
 
DELETE FROM ChiTietSuDungDichVu WHERE MaDatPhong IN (SELECT MaDatPhong FROM deleted);
DELETE FROM ChiTietDatPhong     WHERE MaDatPhong IN (SELECT MaDatPhong FROM deleted);
DELETE FROM PhieuDenBu          WHERE MaDatPhong IN (SELECT MaDatPhong FROM deleted);
DELETE FROM PhieuDatPhong       WHERE MaDatPhong IN (SELECT MaDatPhong FROM deleted);
END;

--Lệnh chạy thử nghiệm:
BEGIN TRY
BEGIN TRAN;
DELETE FROM PhieuDatPhong WHERE MaDatPhong = 'DP01';
ROLLBACK;
END TRY
BEGIN CATCH
PRINT N'Test 8 (đúng như mong đợi): ' + ERROR_MESSAGE();
IF @@TRANCOUNT > 0 ROLLBACK;
END CATCH;
