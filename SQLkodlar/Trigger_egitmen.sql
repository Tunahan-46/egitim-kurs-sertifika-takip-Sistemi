CREATE TRIGGER trg_AutoInsertInstructor
ON Kullanicilar
AFTER INSERT
AS
BEGIN
    DECLARE @KullaniciId INT;
    DECLARE @Rol NVARCHAR(20);

    SELECT @KullaniciId = Kullanici_Id, @Rol = Rol FROM INSERTED;

    IF @Rol = 'egitmen'
    BEGIN
        INSERT INTO Egitmenler (Egitmen_Id, Uzmanlik_Alani)
        VALUES (@KullaniciId, 'Henüz Belirtilmedi');
    END
END;
