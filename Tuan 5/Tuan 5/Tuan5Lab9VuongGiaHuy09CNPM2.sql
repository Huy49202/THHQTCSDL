CREATE TRIGGER trig_bai1lab9 ON Nhap
FOR INSERT
AS
BEGIN
	declare @masp nvarchar(10), @manv nvarchar(10)
	declare @sln int, @dgn float
	select @masp = masp, @manv = manv, @sln = soluongN, @dgn = dongiaN from inserted
	if (not exists (select * from Sanpham where masp = @masp))
		begin
			raiserror ('K ton tai san pham trong danh muc san pham',16, 1)
			rollback transaction
		end
	else if (not exists (select * from Nhanvien where manv = @manv))
		begin
			raiserror ('K ton tai nhan vien co ma nay', 16,1)
			rollback transaction
		end
	else if (@sln <= 0 or @dgn <= 0)
		begin
			raiserror('Nhap sai so luong hoac don gia', 16,1)
			rollback transaction
		end
	else update Sanpham set soluong = soluong + @sln from Sanpham where masp = @masp
END

select * from Sanpham
select * from Nhanvien
select * from Nhap

insert into Nhap values ('nh01', 'SP02', 'nv01', '2020-12-12', 0, 150000)

CREATE TRIGGER trig_bai2lab9
ON Xuat
AFTER INSERT
AS
BEGIN

    IF NOT EXISTS (SELECT masp FROM Sanpham WHERE masp = (SELECT masp FROM inserted))
    BEGIN
        RAISERROR('Mã sản phẩm không tồn tại trong bảng Sanpham', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    IF NOT EXISTS (SELECT manv FROM Nhanvien WHERE manv = (SELECT manv FROM inserted))
    BEGIN
        RAISERROR('Mã nhân viên không tồn tại trong bảng Nhanvien', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    DECLARE @soluongX INT
    SELECT @soluongX = soluongX FROM inserted
    
    DECLARE @soluong INT
    SELECT @soluong = soluong FROM Sanpham WHERE masp = (SELECT masp FROM inserted)
    
    IF (@soluongX > @soluong)
    BEGIN
        RAISERROR('Số lượng xuất vượt quá số lượng trong kho', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    UPDATE Sanpham
    SET soluong = soluong - @soluongX
    WHERE masp = (SELECT masp FROM inserted)
END

insert into Xuat values ('X06', 'SP05', 'NV01', '2020-12-12', '2')


CREATE TRIGGER trig_bai4lab9
ON Xuat
AFTER UPDATE
AS
BEGIN

    IF (SELECT COUNT(*) FROM inserted) < 2
    BEGIN
        DECLARE @old_soluong INT, @new_soluong INT, @masp NVARCHAR(10)
		SELECT @masp = i.masp, @old_soluong = d.soluongX, @new_soluong = i.soluongX
        FROM deleted d INNER JOIN inserted i ON d.sohdx = i.sohdx AND d.masp = i.masp
        IF (@new_soluong <= (SELECT soluong FROM sanpham WHERE masp = @masp))
        BEGIN
            UPDATE xuat SET soluongX = @new_soluong WHERE sohdx IN (SELECT sohdx FROM inserted)
            UPDATE sanpham SET soluong = soluong + @old_soluong - @new_soluong WHERE masp = @masp
        END
    END
END

UPDATE Xuat set ngayxuat = '2020-12-11'

CREATE TRIGGER trig_bai5lab9
ON Nhap
AFTER UPDATE
AS
BEGIN

    IF (SELECT COUNT(*) FROM inserted) > 1
    BEGIN
        RAISERROR('Chỉ được phép cập nhật 1 bản ghi tại một thời điểm', 16, 1)
        ROLLBACK
    END
    
    DECLARE @masp INT
    DECLARE @soluongN INT
    DECLARE @soluong INT
    
    SELECT @masp = i.masp, @soluongN = i.soluongN, @soluong = s.soluong
    FROM inserted i
    INNER JOIN Sanpham s ON i.masp = s.masp
    
    UPDATE Sanpham
    SET soluong = soluong + (@soluongN - (SELECT soluongN FROM deleted WHERE masp = @masp))
    WHERE masp = @masp
END
UPDATE Xuat set ngayxuat = '2022-12-12'

ALTER TRIGGER trig_bai6lab9
ON Nhap
AFTER DELETE
AS

BEGIN
    UPDATE Sanpham
    SET Soluong = Sanpham.Soluong - deleted.soluongN
    FROM Sanpham
    JOIN deleted ON Sanpham.Masp = deleted.Masp
	SELECT count(soluong) as 'So luong cap nhat' from Sanpham
END

Delete from Nhap where soluongN = 10
