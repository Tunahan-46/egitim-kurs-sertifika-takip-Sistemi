CREATE TRIGGER trg_AutoInsertStudent
ON Kullanicilar
AFTER INSERT
AS
BEGIN
    DECLARE @KullaniciId INT;
    DECLARE @Rol NVARCHAR(20);

    SELECT @KullaniciId = Kullanici_Id, @Rol = Rol FROM INSERTED;

    IF @Rol = 'ogrenci'
    BEGIN
        INSERT INTO Ogrenciler (Ogrenci_Id, Okul_Adi, Bolum, Sinif)
        VALUES (@KullaniciId, 'Henüz Belirtilmedi', 'Henüz Belirtilmedi', 1);
    END
END;
