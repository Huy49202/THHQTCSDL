INSERT INTO NhanVien (manv, tennv,  gioitinh, diachi, sodt, email, phong)
VALUES ('NV08', 'Vuong Gia Huy ', 'Nam', 'HCm', '098767671', 'nva@email.com', N'Kế toán')

BACKUP DATABASE [QLBanHang] TO DISK = 'C:\VuongGiaHuy09CNPM2_THHQTCSDL\Tuan 5\VuongGiaHuy.bak' WITH INIT
go

INSERT INTO Nhanvien values ('NV100', 'Vuong Gia Huy', 'Nam', 'HCM', '090401294', 'ahah@gmail.com', 'Ke toan')
backup database [QLBanHang] to disk = 'C:\VuongGiaHuy09CNPM2_THHQTCSDL\Tuan 5\VuongGiaHuydifferent.bak' with differential

INSERT INTO Nhanvien values ('NV101', 'Vuong Gia Huy', 'Nam', 'HCM', '094102902', 'hihi@gmail.com', 'Ke toan')
backup log [QLBanHang] to disk = 'C:\VuongGiaHuy09CNPM2_THHQTCSDL\Tuan 5\VuongGiaHuylog.bak' WITH FORMAT

DROP DATABASE [QLBanHang]
RESTORE DATABASE QLBanHang
FROM DISK = 'C:\VuongGiaHuy09CNPM2_THHQTCSDL\Tuan 5\VuongGiaHuy.bak'
WITH STANDBY = 'C:\LyHuynhThanhHau.undo'