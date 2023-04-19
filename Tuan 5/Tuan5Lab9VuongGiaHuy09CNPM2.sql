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

insert into Xuat values 
