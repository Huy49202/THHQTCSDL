create view view1 as
select * from Sanpham
go

create view view2 as
select top 100 percent Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Sanpham.soluong, Sanpham.donvitinh, Sanpham.mota, Sanpham.giaban, Sanpham.mausac
from Sanpham inner join Hangsx on Sanpham.mahangsx = Hangsx.mahangsx
go
select * from view2 order by giaban desc
go
create view view3 as
select Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
from Sanpham inner join Hangsx on Sanpham.mahangsx = Hangsx.mahangsx
where Hangsx.tenhang = 'Samsung'
go
select * from view3
go
create view view4 as
select * from Nhanvien where gioitinh = 'Nữ' and phong = 'Kế toán'
go
select * from view4
go
create view view5 as
select top 100 percent Nhap.sohdn, Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Nhap.soluongN, Nhap.dongiaN,
Nhap.soluongN*Nhap.dongiaN as tiennhap, Sanpham.mausac, Sanpham.donvitinh, Nhap.ngaynhap, Nhanvien.tennv, Nhanvien.phong
from Nhap join Sanpham on Nhap.masp = Sanpham.masp join Hangsx on Hangsx.mahangsx = Sanpham.mahangsx inner join Nhanvien on
Nhanvien.manv = Nhap.manv
go
select * from view5
go
create view view6 as
select x.sohdx, x.masp, sp.tensp, hsx.tenhang, x.soluongX, sp.giaban, x.soluongX * sp.giaban AS tienxuat, sp.mausac, sp.donvitinh, x.ngayxuat, nv.tennv, nv.phong
from Xuat x
INNER join Sanpham sp on x.masp = sp.masp
INNER join Hangsx hsx on sp.mahangsx = hsx.mahangsx
INNER join Nhanvien nv on x.manv = nv.manv
where MonTH(x.ngayxuat) = 10 AND YEAR(x.ngayxuat) = 2018
go
select * from view6 order by sohdx asc
go

create view view7 as
select sohdn, Sanpham.masp, tensp, soluongN, dongiaN, ngaynhap, Nhanvien.tennv, phong
from Nhap inner join Sanpham on Nhap.masp = Sanpham.masp
inner join Nhanvien on Nhap.manv = Nhanvien.manv
where tensp LIKE 'Samsung'
AND YEAR(ngaynhap) = 2017
go
select * from view7
go
create view view8 as
select TOP 10 sohdx, masp, manv, ngayxuat, soluongX
from Xuat
where YEAR(ngayxuat) = 2018
go
select * from view8 ORDER BY soluongX DESC
go

create view view9 as
select top 10 masp, tensp, giaban
from Sanpham
go
select * from view9 order by giaban desc
go

create view view10 as
select * from Sanpham where giaban between 100000 and 500000
go
select * from view10
go

create view view11 as
select sum(dongiaN*soluongN) as Tongtiennhap from Nhap where YEAR(ngaynhap) = 2018
go
select * from view11
go

create view view12 as
select sum(soluongX) as Tongtienxuat from Xuat where ngayxuat = '9/2/2018'
go
select * from view12
go

alter view view13 as
select top 1 sohdn, ngaynhap,(soluongN*dongiaN) as TienNhap from Nhap where YEAR(ngaynhap) = 2018 
go
select * from view13 order by TienNhap desc
go

create view view14 as
select top 10 * from Nhap
go
select * from view14 order by soluongN desc	
go

create view view15 as
select sp.masp, sp.tensp
from Sanpham sp
join Nhap n on sp.masp = n.masp
join Nhanvien nv on n.manv = nv.manv
join Hangsx hsx on sp.mahangsx = hsx.mahangsx
where hsx.tenhang = 'Samsung' AND nv.manv = 'NV01'
go
select * from view15
go

create view view16 as
select Nhap.sohdn, Nhap.masp, Nhap.soluongN, Nhap.ngaynhap
from Nhap
join Xuat on Nhap.masp = Xuat.masp and Nhap.sohdn = Xuat.sohdx
where Nhap.masp = 'SP02' and Xuat.manv = 'NV02';
go
select * from view16
go

create view view17 as
select Nhanvien.manv, Nhanvien.tennv
from Nhanvien
join Xuat on Nhanvien.manv = Xuat.manv
where Xuat.masp = 'SP02' AND Xuat.ngayxuat = '2020-03-02'
go
select * from view17
go





