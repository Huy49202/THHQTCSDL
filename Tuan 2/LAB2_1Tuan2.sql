use QLBanHang
-- cau 1
--select * from Sanpham
--select * from Hangsx
--select * from Nhanvien
--select * from Xuat
--select * from Nhap
-- cau 2
--select masp, tensp, tenhang, soluong, mausac, giaban, donvitinh, mota from Hangsx, Sanpham order by giaban desc
-- cau 3
--select masp, tensp, tenhang,soluong, mausac, giaban, donvitinh, mota 
--from Sanpham inner join Hangsx on Sanpham.mahangsx = Hangsx.mahangsx where Hangsx.tenhang = 'Samsung'
-- cau 4
--select manv, tennv, gioitinh, diachi, sodt, email, phong from Nhanvien where gioitinh = 'Nữ' and phong = 'Kế toán'
-- cau 5
--select nhap.sohdn, sp.masp, sp.tensp, hsx.tenhang, nhap.soluongN, nhap.dongiaN, tiennhap = nhap.soluongN * nhap.dongiaN, 
--sp.mausac, sp.donvitinh, nhap.ngaynhap, nv.tennv, nv.phong from Nhap nhap 
--inner join Sanpham sp on sp.masp = nhap.masp 
--inner join Nhanvien nv on nv.manv = nhap.manv
--inner join Hangsx hsx on hsx.mahangsx = sp.mahangsx
--order by tiennhap asc
-- cau 6
--select x.sohdx, sp.masp, sp.tensp, hsx.tenhang, x.soluongX, sp.giaban, x.tienxuat = soluongX * giaban, sp.mausac, sp.donvitinh, x.ngayxuat, nv.tennv, nv.phong
 --from Sanpham sp inner join Xuat x on sp.masp = x.masp
 --inner join Hangsx hsx on hsx.mahangsx = sp.mahangsx
 --inner join Nhanvien nv on nv.manv = x.manv where year(x.ngayxuat) = "2018" order by sohdx asc
 -- cau 7
 --select N.sohdn, N.masp, S.tensp, N.soluongN, N.dongiaN, N.ngaynhap, NV.tennv, NV.phong from Nhap N
--inner join Sanpham S on N.masp = S.masp
--inner join Nhanvien NV on N.manv = NV.manv
--inner join Hangsx H on S.mahangsx = H.mahangsx
--where YEAR(N.ngaynhap) = 2017 AND H.tenhang = 'Samsung';
 -- cau 8
 --select top 10 Xuat.sohdx, SanPham.tensp, Xuat.soluongX from Xuat
--INNER JOIN SanPham on Xuat.masp = SanPham.masp
--where YEAR(Xuat.ngayxuat) = 2020
--order by Xuat.soluongX desc;
 -- cau 9
 --select top 10 * from Sanpham order by giaban desc
 -- cau 10
 --select * from Sanpham where mahangsx = 'H01' and  giaban between 100000 and 500000
 -- cau 11
 select sum(dongiaN*soluongN) as Tongtiennhap from Nhap nhap 
 inner join Sanpham sp on sp.masp = nhap.masp 
 inner join Hangsx hsx on hsx.mahangsx = sp.mahangsx where hsx.mahangsx = 'H01' and year(nhap.ngaynhap) = 2018
 --Câu 12
select SUM(Xuat.soluongX * SanPham.giaban) AS TongTienXuat
from Xuat
JOIN SanPham on Xuat.masp = SanPham.masp
where Xuat.ngayxuat = '2018-09-02'

--Câu 13
select top 1 sohdn, ngaynhap
from Nhap
where YEAR(ngaynhap) = 2018
order by soluongN * dongiaN DESC

--Câu 14
select top 10 SanPham.tensp, SUM(Nhap.soluongN) AS TongSoLuongNhap
from Nhap
JOIN SanPham on Nhap.masp = SanPham.masp
where YEAR(Nhap.ngaynhap) = 2019
group by SanPham.tensp
order by SUM(Nhap.soluongN) DESC

--Câu 15
select SanPham.masp, SanPham.tensp
from Nhap
JOIN SanPham on Nhap.masp = SanPham.masp
JOIN Hangsx on SanPham.mahangsx = Hangsx.mahangsx
JOIN NhanVien on Nhap.manv = NhanVien.manv
where Hangsx.tenhang = 'Samsung' AND NhanVien.manv = 'NV01'

--Câu 16
select Nhap.sohdn, Nhap.masp, Nhap.soluongN, Nhap.ngaynhap
from Nhap
JOIN Xuat on Nhap.masp = Xuat.masp AND Nhap.sohdn = Xuat.sohdx
where Nhap.masp = 'SP02' AND Xuat.manv = 'NV02';

--Câu 17
select Nhanvien.manv, Nhanvien.tennv
from Nhanvien
JOIN Xuat on Nhanvien.manv = Xuat.manv
where Xuat.masp = 'SP02' AND Xuat.ngayxuat = '2020-03-02';