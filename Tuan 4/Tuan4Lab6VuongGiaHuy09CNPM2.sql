--VuongGiaHuy 09CNPM2
--cau 1
create function	fn_bai1lab6(@tensp nvarchar(50))
returns @tbthongtinsp table (masp nchar(10), mahangsx nchar(10), tensp nvarchar(20), soluong int, mausac nvarchar(20)
, giaban money, donvitinh nchar(10), mota nvarchar(MAX))
as
begin
	insert into @tbthongtinsp select masp, Sanpham.mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota from Sanpham inner join Hangsx
	on Sanpham.mahangsx = Hangsx.mahangsx where Sanpham.tensp = @tensp
	return
end

select * from dbo.fn_bai1lab6('F1 Plus')
--cau 2
alter FUNCTION fn_bai2lab6(@tuNgay DATE, @denNgay DATE)
RETURNS @sanpham TABLE (masp nchar(10), mahangsx nchar(10), tensp NVARCHAR(50), soluong INT, mausac NVARCHAR(50), giaban MONEY, donvitinh NVARCHAR(50), mota NVARCHAR(MAX), tenhang NVARCHAR(50))
AS
BEGIN
    INSERT INTO @sanpham(masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota, tenhang)
    SELECT sp.masp, sp.mahangsx, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota, hsx.tenhang
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    INNER JOIN Nhap n ON sp.masp = n.masp
    WHERE n.ngaynhap BETWEEN @tuNgay AND @denNgay;
    RETURN;
END;
select * from dbo.fn_bai2lab6('2019-5-2','2020-7-4')
-- cau 3
CREATE FUNCTION dbo.bai3lab6(@MaHangSX NVARCHAR(50), @SoLuong INT)
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.giaban
    FROM Sanpham
    INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    WHERE Hangsx.mahangsx = @MaHangSX AND 
    ((@SoLuong = 1 AND Sanpham.soluong > 0) OR (@SoLuong = 0 AND Sanpham.soluong = 0))
)
select * from dbo.bai3lab6('H01', 1)
--cau 4
CREATE FUNCTION dbo.fn_bai4lab6(@tenphong nvarchar(50))
returns table
as
	return (select * from Nhanvien where phong = @tenphong)
select * from dbo.fn_bai4lab6('Kế toán')
--cau 5
alter function dbo.fn_bai5lab6(@diachi nvarchar(50))
returns table
as return (select * from Hangsx where diachi like @diachi)
select * from dbo.fn_bai5lab6('Korea')
--cau 6
create FUNCTION fn_bai6lab6(@tunam int, @dennam int)
RETURNS @sanpham TABLE (masp nchar(10), mahangsx nchar(10), tensp NVARCHAR(50), soluong INT, mausac NVARCHAR(50), giaban MONEY, donvitinh NVARCHAR(50), mota NVARCHAR(MAX), tenhang NVARCHAR(50))
AS
BEGIN
    INSERT INTO @sanpham(masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota, tenhang)
    SELECT sp.masp, sp.mahangsx, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota, hsx.tenhang
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    INNER JOIN Nhap n ON sp.masp = n.masp
    WHERE YEAR(n.ngaynhap) BETWEEN @tunam AND @dennam;
    RETURN;
END;
select * from dbo.fn_bai6lab6(2017,2020)
--cau 7
CREATE FUNCTION fn_cau7lab6 (@hangsx NVARCHAR(50),@thamso INT)
RETURNS TABLE
AS
RETURN
(
    SELECT sp.Masp, sp.Tensp, sp.Mausac, sp.Giaban, sp.Donvitinh, sp.Mota
    FROM Sanpham sp
    INNER JOIN Hangsx hs ON sp.Mahangsx = hs.Mahangsx
    LEFT JOIN Nhap n ON sp.Masp = n.Masp
    LEFT JOIN Xuat x ON sp.Masp = x.Masp
    WHERE hs.Tenhang = @hangsx AND
    ((@thamso = 0 AND n.Sohdn IS NOT NULL) OR
    (@thamso = 1 AND x.Sohdx IS NOT NULL)))
select * from dbo.fn_cau7lab6('Samsung',0)
--cau 8
CREATE FUNCTION fn_cau8lab6(@ngayNhap DATE)
RETURNS TABLE
AS
RETURN (select nv.manv, nv.tennv, nv.gioitinh, nv.diachi, nv.sodt, nv.email, nv.phong from Nhanvien nv 
inner join Nhap n ON nv.manv = n.manv where n.ngaynhap = @ngayNhap)

select * from dbo.fn_cau8lab6('2020-07-04')
--cau 9
CREATE FUNCTION fn_bai9lab6(@minPrice FLOAT,@maxPrice FLOAT,@mahangsx VARCHAR(50))
RETURNS @tb_products TABLE
(masp VARCHAR(10),mahangsx VARCHAR(10),tensp NVARCHAR(50),soluong INT,mausac NVARCHAR(50),
giaban FLOAT,donvitinh NVARCHAR(20),mota NVARCHAR(MAX))
AS
BEGIN
    INSERT INTO @tb_products
    SELECT s.masp, s.mahangsx, s.tensp, s.soluong, s.mausac, s.giaban, s.donvitinh, s.mota
    FROM Sanpham s INNER JOIN Hangsx h ON s.mahangsx = h.mahangsx
    WHERE s.giaban >= @minPrice AND s.giaban <= @maxPrice AND h.tenhang = @mahangsx
    RETURN
END
select * from dbo.fn_bai9lab6(1,20000000,'Samsung')

--cau10--
CREATE FUNCTION fn_cau10lab6 ()
RETURNS TABLE
AS
RETURN
(SELECT sp.Masp, sp.Tensp, sp.Mausac, sp.Giaban, sp.Donvitinh, sp.Mota, hs.Tenhang
FROM Sanpham sp INNER JOIN Hangsx hs ON sp.Mahangsx = hs.Mahangsx)

select * from dbo.fn_cau10lab6()



