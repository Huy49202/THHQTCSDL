use QLBanHang
ALTER PROCEDURE sp_bai1lab8
    @manv NVARCHAR(10),
    @tennv NVARCHAR(50),
    @gioitinh NVARCHAR(5),
    @diachi NVARCHAR(100),
    @sodt NVARCHAR(15),
    @email NVARCHAR(50),
    @phong NVARCHAR(20),
    @flag INT
AS
BEGIN
    IF @gioitinh NOT IN ('Nam', 'Nu')
    BEGIN
        SELECT 1 AS [ERRORCODE]
        RETURN
    END
    
    IF @flag = 0
    BEGIN
        INSERT INTO Nhanvien(manv, tennv, gioitinh, diachi, sodt, email, phong)
        VALUES(@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)
    END
    ELSE
    BEGIN
        UPDATE Nhanvien
        SET tennv = @tennv, gioitinh = @gioitinh, diachi = @diachi, sodt = @sodt, email = @email,
            phong = @phong
        WHERE manv = @manv
    END
    
    SELECT 0 AS [ErrorCode]
END
EXEC sp_bai1lab8 'nv12', 'Huy', 'Nam', 'HCM', '0964250252', 'fhskah@gmail.com', 'Ke Toan', '0'


ALTER PROCEDURE sp_bai2lab8
    @masp NVARCHAR(10),
    @tenhang NVARCHAR(50),
    @tensp NVARCHAR(50),
    @soluong INT,
    @mausac NVARCHAR(20),
    @giaban FLOAT,
    @donvitinh NVARCHAR(10),
    @mota NVARCHAR(MAX),
    @flag INT
AS
BEGIN
    DECLARE @mahangsx nvarchar(10)
    SELECT @mahangsx = mahangsx FROM hangsx WHERE tenhang = @tenhang
    IF @mahangsx IS NULL
    BEGIN
        SELECT 1 AS [ErrorCode], 'Ten hang khong ton tai' AS [Message]
        RETURN
    END

    IF @soluong < 0
    BEGIN

        SELECT 2 AS [ErrorCode], 'So luong khong hop le' AS [Message]
        RETURN
    END

    IF @flag = 0 
    BEGIN
        INSERT INTO sanpham(masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES(@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)

        SELECT 0 AS [ErrorCode], 'Them san pham thanh cong' AS [Message]
    END
    ELSE
    BEGIN
        UPDATE sanpham
        SET mahangsx = @mahangsx,
            tensp = @tensp,
            soluong = @soluong,
            mausac = @mausac,
            giaban = @giaban,
            donvitinh = @donvitinh,
            mota = @mota
        WHERE masp = @masp

        SELECT 0 AS [ErrorCode], 'Cap nhat san pham thanh cong' AS [Message]
    END
END
EXEC sp_bai2lab8 'SP63', 'Samsung', 'Galaxy A30S', '2', 'den', '20000', 'chiec', 'khong', '0'

CREATE PROCEDURE sp_bai3lab8
    @manv NVARCHAR(10)
AS
BEGIN

    IF NOT EXISTS (SELECT * FROM nhanvien WHERE manv = @manv)
    BEGIN
	SELECT 1 AS 'ErrorCode'
        RETURN
    END
    
    DELETE FROM Nhap WHERE manv = @manv
    DELETE FROM Xuat WHERE manv = @manv
    
    DELETE FROM nhanvien WHERE manv = @manv
    
    SELECT 0 AS 'ErrorCode'
END

EXEC sp_bai3lab8 'NV12'

CREATE PROCEDURE sp_bai4lsb8(@masp VARCHAR(10))
AS
BEGIN

    IF NOT EXISTS (SELECT * FROM sanpham WHERE masp = @masp)
    BEGIN
        SELECT 1 AS 'ErrorCode'
        RETURN
    END
    
    DELETE FROM Nhap WHERE masp = @masp
    
    DELETE FROM Xuat WHERE masp = @masp
    
    DELETE FROM sanpham WHERE masp = @masp
    
    SELECT 0 AS 'ErrorCode'
END

EXEC sp_bai4lsb8 'SP63'

CREATE PROCEDURE sp_bai5lab8
    @mahangsx varchar(10),
    @tenhang nvarchar(50),
    @diachi nvarchar(100),
    @sodt varchar(20),
    @email varchar(50)
AS
BEGIN
    IF EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        SELECT 1 AS [ErrorCode]
        RETURN
    END
    INSERT INTO Hangsx (mahangsx, tenhang, diachi, sodt, email)
    VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email)
    SELECT 0 AS [ErrorCode]
    RETURN
END

EXEC sp_bai5lab8 'H67', 'Samsung', 'Korea', '4920192', 'korea@gmail.com'

CREATE PROCEDURE sp_bai6lab8
    @sohdn nvarchar(50),
    @masp nvarchar(50),
    @manv nvarchar(50),
    @ngaynhap date,
    @soluongN int,
    @dongiaN float
AS
BEGIN

    IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        SELECT 1 AS ErrorCode, 'Mã sản phẩm không tồn tại' AS ErrorMessage
        RETURN
    END
   
    IF NOT EXISTS (SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        SELECT 2 AS ErrorCode, 'Mã nhân viên không tồn tại' AS ErrorMessage
        RETURN
    END
    
    IF EXISTS (SELECT * FROM Nhap WHERE sohdn = @sohdn)
    BEGIN
        UPDATE Nhap
        SET masp = @masp,
            manv = @manv,
            ngaynhap = @ngaynhap,
            soluongN = @soluongN,
            dongiaN = @dongiaN
        WHERE sohdn = @sohdn
        
        SELECT 0 AS ErrorCode, 'Cập nhật dữ liệu thành công' AS ErrorMessage
        RETURN
    END
    ELSE
    BEGIN

        INSERT INTO Nhap (sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
        VALUES (@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)
    
        SELECT 0 AS ErrorCode, 'Thêm mới dữ liệu thành công' AS ErrorMessage
        RETURN
    END
END

EXEC sp_bai6lab8 'N01', 'SP20', 'NV30', '2020-12-12', '4', '200000'

ALTER PROCEDURE sp_bai7lab8
    @sohdx nvarchar(50),
    @masp nvarchar(50),
    @manv nvarchar(50),
    @ngayxuat DATE,
    @soluongX INT
AS
BEGIN
 IF NOT EXISTS(SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        RETURN 1 
    END

    IF NOT EXISTS(SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        RETURN 2 
    END

    IF @soluongX > (SELECT soluong FROM Sanpham WHERE masp = @masp)
    BEGIN
        RETURN 3 
    END

    IF EXISTS(SELECT * FROM Xuat WHERE sohdx = @sohdx)
    BEGIN
        UPDATE Xuat
        SET masp = @masp,
            manv = @manv,
            ngayxuat = @ngayxuat,
            soluongX = @soluongX
        WHERE sohdx = @sohdx
    END
    ELSE
    BEGIN
        INSERT INTO Xuat(sohdx, masp, manv, ngayxuat, soluongX)
        VALUES(@sohdx, @masp, @manv, @ngayxuat, @soluongX)
    END
    RETURN 0
END
EXEC sp_bai7lab8 'X02', 'SP03', 'NV2', '2020-12-12', '5'

