BEGIN TRANSACTION;

BEGIN TRY
    -- 1. Kullanýcý ekle
    INSERT INTO Kullanicilar (Ad, Soyad, Email, Sifre, Rol, Kayit_Tarihi)
    VALUES ('Selin', 'Yýlmaz', 'selin.yilmaz@example.com', '54321', 'egitmen', GETDATE());

    -- 2. Eklenen kullanýcýnýn ID'sini al
    DECLARE @YeniEgitmenId INT;
    SELECT @YeniEgitmenId = SCOPE_IDENTITY();

    -- 3. Egitmen tablosuna kayýt oluþtur
    INSERT INTO Egitmenler (Egitmen_Id, Uzmanlik_Alani)
    VALUES (@YeniEgitmenId, 'Veri Bilimi');

    COMMIT;
    PRINT 'Yeni eðitmen baþarýyla eklendi.';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Hata oluþtu: ' + ERROR_MESSAGE();
END CATCH;
