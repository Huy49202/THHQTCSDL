create function fn_bai1lab5(@masp nvarchar(10))
returns nvarchar(20)
as
begin
  declare @ten nvarchar(20)
  set @ten = (select tenhang from hangsx inner join sanpham on hangsx.mahangsx = sanpham.mahangsx where masp = @masp)
  return @ten
end

select dbo.fn_bai1lab5('SP02')

create function fn_bai2lab5(@x int, @y int)
returns int
as
begin
  declare @tongtien int
  select @tongtien = sum(soluongN*dongiaN)
  from Nhap where year(ngaynhap) between @x and @y
  return @tongtien
end

select dbo.fn_bai2lab5(2017, 2020)

alter function fn_bai3lab5(@tensp nvarchar(100), @nam int)
RETURNS int
AS
BEGIN
    DECLARE @soLuongNhap int, @soLuongXuat int, @soLuongThayDoi int;
    SELECT @soLuongNhap = SUM(soluongN) FROM Nhap n JOIN Sanpham sp ON n.masp = sp.masp WHERE sp.tensp = @tensp AND YEAR(n.ngaynhap) = @nam;
    SELECT @soLuongXuat = SUM(soluongX) FROM Xuat x JOIN Sanpham sp ON x.masp = sp.masp WHERE sp.tensp = @tensp AND YEAR(x.ngayxuat) = @nam;
    SET @soLuongThayDoi = @soLuongNhap - @soLuongXuat;
    RETURN @soLuongThayDoi;
END
go
SELECT dbo.fn_bai3lab5('F3 lite',2019)
go

CREATE FUNCTION fn_bai4lab5(@ngay_bat_dau DATE, @ngay_ket_thuc DATE)
RETURNS MONEY
AS
BEGIN
    DECLARE @tong_gia_tri_nhap MONEY;
    SELECT @tong_gia_tri_nhap = SUM(nhap.soluongN * sanpham.giaban)
    FROM Nhap AS nhap
    INNER JOIN Sanpham AS sanpham ON nhap.masp = sanpham.masp
    WHERE nhap.ngaynhap >= @ngay_bat_dau AND nhap.ngaynhap <= @ngay_ket_thuc;
    RETURN @tong_gia_tri_nhap;
END;
go
SELECT dbo.fn_bai4lab5('2018-01-01', '2021-12-31') AS TongGiaTriNhap
go

CREATE FUNCTION fn_bai5lab5(@tenHang NVARCHAR(20), @nam INT)
RETURNS MONEY
AS
BEGIN
  DECLARE @tongGiaTriXuat MONEY;
  SELECT @tongGiaTriXuat = SUM(S.giaban * X.soluongX)
  FROM Xuat X
  JOIN Sanpham S ON X.masp = S.masp
  JOIN Hangsx H ON S.mahangsx = H.mahangsx
  WHERE H.tenhang = @tenHang AND YEAR(X.ngayxuat) = @nam;
  RETURN @tongGiaTriXuat;
END;
go
SELECT dbo.fn_bai5lab5(N'Oppo', 2020) AS 'TongGiaTriXuat';
go

create FUNCTION fn_bai6lab5(@tenphong NVARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @soluong INT;
    SELECT @soluong = COUNT(*) 
    FROM Nhanvien
    WHERE phong = @tenphong
    RETURN @soluong;
END;
go
select dbo.fn_bai6lab5('Kế toán')
go


alter FUNCTION fn_bai7lab5 (@tenSanPham NVARCHAR(50), @ngayNhap DATE)
RETURNS INT
AS
BEGIN
    DECLARE @soLuongXuat INT
    SELECT @soLuongXuat = SUM(soluongX)
    FROM Xuat
    WHERE masp IN (
        SELECT masp
        FROM Sanpham
        WHERE tensp = @tenSanPham
    )
    AND CONVERT(DATE, ngayxuat) = @ngayNhap
    IF @soLuongXuat IS NULL
        SET @soLuongXuat = 0
    RETURN @soLuongXuat
END
SELECT dbo.fn_bai7lab5('OPPO', '2020-06-14')
go

CREATE FUNCTION fn_bai8lab5 (@sohdx NCHAR(10))
RETURNS NVARCHAR(20)
AS
BEGIN
  DECLARE @sdt NVARCHAR(20)
  SELECT @sdt = Nhanvien.sodt
  FROM Nhanvien
  INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
  WHERE Xuat.sohdx = @sohdx
  RETURN @sdt
END
select dbo.fn_bai8lab5('X01')
go

CREATE FUNCTION fn_bai9lab5(@tenSP NVARCHAR(20), @nam INT)
RETURNS INT
AS
BEGIN
  DECLARE @tongNhapXuat INT;
  SET @tongNhapXuat = (
  SELECT COALESCE(SUM(nhap.soluongN), 0) + COALESCE(SUM(xuat.soluongX), 0) AS tongSoLuong
    FROM Sanpham sp
    LEFT JOIN Nhap nhap ON sp.masp = nhap.masp
    LEFT JOIN Xuat xuat ON sp.masp = xuat.masp
    WHERE sp.tensp = @tenSP AND YEAR(nhap.ngaynhap) = @nam AND YEAR(xuat.ngayxuat) = @nam
  );
  RETURN @tongNhapXuat;
END;

select dbo.fn_bai9lab5('Galaxy V21', 2020)

CREATE FUNCTION fn_bai10lab5(@tenhang NVARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @soluong INT;

    SELECT @soluong = SUM(soluong)
    FROM Sanpham sp JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
    WHERE hs.tenhang = @tenhang;

    RETURN @soluong;
END;
go
go
SELECT dbo.fn_bai10lab5('Samsung') AS Tongsoluongspcuahang
go