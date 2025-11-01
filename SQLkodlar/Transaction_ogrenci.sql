BEGIN TRANSACTION;

BEGIN TRY
    -- 1. Kullanýcý ekle
    INSERT INTO Kullanicilar (Ad, Soyad, Email, Sifre, Rol, Kayit_Tarihi)
    VALUES ('Mert', 'Kaya', 'mert.kaya@example.com', '12345', 'ogrenci', GETDATE());

    -- 2. Eklenen kullanýcýnýn ID'sini al
    DECLARE @YeniKullaniciId INT;
    SELECT @YeniKullaniciId = SCOPE_IDENTITY();

    -- 3. Ogrenciler tablosuna kayýt oluþtur
    INSERT INTO Ogrenciler (Ogrenci_Id, Okul_Adi, Bolum, Sinif)
    VALUES (@YeniKullaniciId, 'Ýstanbul Üniversitesi', 'Bilgisayar Mühendisliði', 2);

    COMMIT;
    PRINT 'Yeni öðrenci baþarýyla eklendi.';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Hata oluþtu: ' + ERROR_MESSAGE();
END CATCH;
