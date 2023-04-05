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
returns int
as
begin
    declare @soLuongNhap int, @soLuongXuat int, @soLuongThayDoi int;
    select @soLuongNhap = SUM(soluongN) from Nhap n JOIN Sanpham sp ON n.masp = sp.masp where sp.tensp = @tensp and YEAR(n.ngaynhap) = @nam;
    select @soLuongXuat = SUM(soluongX) from Xuat x JOIN Sanpham sp ON x.masp = sp.masp where sp.tensp = @tensp and YEAR(x.ngayxuat) = @nam;
    set @soLuongThayDoi = @soLuongNhap - @soLuongXuat;
    return @soLuongThayDoi;
end
go
select dbo.fn_bai3lab5('F3 lite',2019)
go

create function fn_bai4lab5(@ngay_bat_dau DATE, @ngay_ket_thuc DATE)
returns MONEY
as
begin
    declare @tong_gia_tri_nhap MONEY;
    select @tong_gia_tri_nhap = SUM(nhap.soluongN * sanpham.giaban)
    from Nhap as nhap
    INNER JOIN Sanpham as sanpham ON nhap.masp = sanpham.masp
    where nhap.ngaynhap >= @ngay_bat_dau and nhap.ngaynhap <= @ngay_ket_thuc;
    return @tong_gia_tri_nhap;
end;
go
select dbo.fn_bai4lab5('2018-01-01', '2021-12-31') as TongGiaTriNhap
go

create function fn_bai5lab5(@tenHang nvarchar(20), @nam int)
returns MONEY
as
begin
  declare @tongGiaTriXuat MONEY;
  select @tongGiaTriXuat = SUM(S.giaban * X.soluongX)
  from Xuat X
  JOIN Sanpham S ON X.masp = S.masp
  JOIN Hangsx H ON S.mahangsx = H.mahangsx
  where H.tenhang = @tenHang and YEAR(X.ngayxuat) = @nam;
  return @tongGiaTriXuat;
end;
go
select dbo.fn_bai5lab5(N'Oppo', 2020) as 'TongGiaTriXuat';
go

create function fn_bai6lab5(@tenphong nvarchar(50))
returns int
as
begin
    declare @soluong int;
    select @soluong = COUNT(*) 
    from Nhanvien
    where phong = @tenphong
    return @soluong;
end;
go
select dbo.fn_bai6lab5('Kế toán')
go


alter function fn_bai7lab5 (@tenSanPham nvarchar(50), @ngayNhap DATE)
returns int
as
begin
    declare @soLuongXuat int
    select @soLuongXuat = SUM(soluongX)
    from Xuat
    where masp IN (
        select masp
        from Sanpham
        where tensp = @tenSanPham
    )
    and CONVERT(DATE, ngayxuat) = @ngayNhap
    IF @soLuongXuat IS NULL
        set @soLuongXuat = 0
    return @soLuongXuat
end
select dbo.fn_bai7lab5('OPPO', '2020-06-14')
go

create function fn_bai8lab5 (@sohdx nchar(10))
returns nvarchar(20)
as
begin
  declare @sdt nvarchar(20)
  select @sdt = Nhanvien.sodt
  from Nhanvien
  INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
  where Xuat.sohdx = @sohdx
  return @sdt
end
select dbo.fn_bai8lab5('X01')
go

create function fn_bai9lab5(@tenSP nvarchar(20), @nam int)
returns int
as
begin
  declare @tongNhapXuat int;
  set @tongNhapXuat = (
  select COALESCE(SUM(nhap.soluongN), 0) + COALESCE(SUM(xuat.soluongX), 0) as tongSoLuong
    from Sanpham sp
    left join Nhap nhap ON sp.masp = nhap.masp
    left join Xuat xuat ON sp.masp = xuat.masp
    where sp.tensp = @tenSP and YEAR(nhap.ngaynhap) = @nam and YEAR(xuat.ngayxuat) = @nam
  );
  return @tongNhapXuat;
end;

select dbo.fn_bai9lab5('Galaxy V21', 2020)

create function fn_bai10lab5(@tenhang nvarchar(20))
returns int
as
begin
    declare @soluong int;

    select @soluong = SUM(soluong)
    from Sanpham sp JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
    where hs.tenhang = @tenhang;

    return @soluong;
end;
go
go
select dbo.fn_bai10lab5('Samsung') as Tongsoluongspcuahang
go