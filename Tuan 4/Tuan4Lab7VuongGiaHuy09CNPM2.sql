
-- cau 1--
create proc sp_cau1lab7 @mahangsx INT, @tenhang varchar(50), @diachi varchar(50), @sodt varchar(15), @email varchar(50)
as
begin
    if exists (select * from Hangsx where tenhang = @tenhang) print N'Đã tồn tại tên hàng.'
    else
        INSERT INTO Hangsx(mahangsx, tenhang, diachi, sodt, email) values (@mahangsx, @tenhang, @diachi, @sodt, @email)
end
go
exec sp_cau1lab7 @mahangsx = 123, @tenhang = N'Oppo1', @diachi = N'Trung Quốc', @sodt = N'0123456789', @email = N'contact@oppo.com'
go

-- cau 2--
create proc sp_cau2lab7  @masp Nvarchar(10), @mahangsx Nvarchar(10), @tensp Nvarchar(50), @soluong INT, @mausac Nvarchar(20),
 @giaban float, @donvitinh Nvarchar(20), @mota Nvarchar(200)
as
begin
    if exists (select * from sanpham where masp = @masp)
    begin
        update sanpham SET  mahangsx = @mahangsx, tensp = @tensp, soluong = @soluong, mausac = @mausac,
		 giaban = @giaban, donvitinh = @donvitinh, mota = @mota
        where masp = @masp
    end
    else
    begin
        INSERT INTO sanpham (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        values (@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
    end
end
exec sp_cau2lab7 123, 213, 123, 123, den, 1000, chiec, khong

--Cau 3--
create proc sp_bai3lab7 @tenhang Nvarchar(50)
as
begin
    if NOT EXISTS (select * from Hangsx where tenhang = @tenhang)
    begin
        print N'Hãng sản xuất không tồn tại '
        return
    end
    begin transaction
    delete from Sanpham where mahangsx = (select mahangsx from Hangsx where tenhang = @tenhang)
	delete from Hangsx where tenhang = @tenhang
    COMMIT transaction
end
exec sp_bai3lab7 'Samsung'
--Cau 4--
create proc sp_bai4lab7 @manv varchar(10), @tennv Nvarchar(50), @gioitinh Nvarchar(3), @diachi Nvarchar(100), 
@sodt varchar(20), @email Nvarchar(50),  @phong Nvarchar(50), @flag BIT
as
begin
    if @flag = 0
    begin
        update Nhanvien
        SET tennv = @tennv, gioitinh = @gioitinh, diachi = @diachi, sodt = @sodt, email = @email,phong = @phong
        where manv = @manv;
    end
    else
    begin
        if exists (select * from Nhanvien where manv = @manv)
        begin
            RAISERROR('Mã nhân viên đã tồn tại!', 16, 1);
            return;
        end
        INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
        values (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong);
    end
end
exec sp_bai4lab7 NV10, Huy, Nam, Vietnam, 0950840, 'haha@gmail.com', 'Ke toan', 1
--Cau 5--
alter PROCEDURE sp_bai5lab7(@sohdn varchar(20), @masp varchar(20), @manv varchar(20), @ngaynhap date, @soluongN int, @dongiaN float)
AS
BEGIN
    IF NOT EXISTS(SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        PRINT N'Mã sản phẩm không tồn tại'
        RETURN
    END
END

IF NOT EXISTS(SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        PRINT N'Mã nhân viên không tồn tại'
        RETURN
    END

    IF EXISTS(SELECT * FROM Nhap WHERE sohdn = @sohdn)
    BEGIN
        UPDATE Nhap SET masp = @masp, manv = @manv, ngaynhap = @ngaynhap, soluongN = @soluongN, dongiaN = @dongiaN
        WHERE sohdn = @sohdn
    END
    ELSE 
    BEGIN
        INSERT INTO Nhap(sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
        VALUES(@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)
    END

    IF EXISTS(SELECT * FROM Xuat WHERE sohdx = @sohdn)
    BEGIN
        UPDATE Xuat SET masp = @masp, manv = @manv, ngayxuat = @ngaynhap, soluongX = @soluongN
        WHERE sohdx = @sohdn
    END
    ELSE
    BEGIN
        DECLARE @sohdx varchar(20)
        SET @sohdx = 'X' + @sohdn
        INSERT INTO Xuat(sohdx, masp, manv, ngayxuat, soluongX)
        VALUES(@sohdx, @masp, @manv, @ngaynhap, @soluongN)
    END

exec sp_bai5lab7 hd1, sp2, nv3, '2020-5-5', 2, 20000
--Cau 6--
alter PROCEDURE sp_bai6lab7(@sohdx nvarchar(50), @masp nvarchar(50), @manv nvarchar(50), @ngayxuat DATE, @soluongX INT)
AS
begin
    IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    begin
        PRINT N'Không tồn tại mã sản phẩm.'
        RETURN
    end
    
    IF NOT EXISTS (SELECT * FROM Nhanvien WHERE manv = @manv)
    begin
        PRINT N'Không tồn tại mã nhân viên.'
        RETURN
    end
    
    IF @soluongX > (SELECT soluong FROM Sanpham WHERE masp = @masp)
    begin
        PRINT N'Số lượng xuất vượt quá số lượng tồn kho.'
        RETURN
    end
    
    IF EXISTS (SELECT * FROM Xuat WHERE sohdx = @sohdx)
    begin
        UPDATE Xuat 
        SET masp = @masp, manv = @manv, ngayxuat = @ngayxuat, soluongX = @soluongX 
        WHERE sohdx = @sohdx
        PRINT N'Cập nhật dữ liệu thành công.'
    end
    ELSE
    begin
        INSERT INTO Xuat(sohdx, masp, manv, ngayxuat, soluongX)
        VALUES (@sohdx, @masp, @manv, @ngayxuat, @soluongX)
        PRINT N'Thêm dữ liệu thành công.'
    end
end
exec sp_bai6lab7 hd1, sp1, nv5, '2020-05-07', 2

--Cau 7--
alter PROCEDURE sp_bai7lab7 @manv nvarchar(50)
AS
begin
    IF NOT EXISTS(SELECT * FROM Nhanvien WHERE manv = @manv)
    begin
        PRINT N'Không tìm thấy nhân viên với mã ' + CAST(@manv AS NVARCHAR)
        RETURN
    end

    DELETE FROM Nhap WHERE manv = @manv
    DELETE FROM Xuat WHERE manv = @manv

    DELETE FROM Nhanvien WHERE manv = @manv

    PRINT N'Đã xóa nhân viên ' + CAST(@manv AS NVARCHAR)
end
go
exec sp_bai7lab7 NV3
--Cau 8--
CREATE PROCEDURE sp_bai8lab7 @masp VARCHAR(10)
AS
begin
  SET NOCOUNT ON;

  IF NOT EXISTS (SELECT 1 FROM Sanpham WHERE masp = @masp)
  begin
    PRINT N'Sản phẩm không tồn tại!'
    RETURN;
  end
  begin TRY
    begin TRANSACTION
    DELETE FROM Nhap WHERE masp = @masp;
    DELETE FROM Xuat WHERE masp = @masp;
    DELETE FROM Sanpham WHERE masp = @masp;
    COMMIT TRANSACTION
    PRINT N'Đã xóa sản phẩm thành công ' + @masp
  end TRY
  begin catch
    ROLLBACK TRANSACTION
  end catch
end
exec sp_bai8lab7 SP01