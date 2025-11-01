CREATE TRIGGER trg_AutoCreateCertificate
ON Kayitlar
AFTER UPDATE
AS
BEGIN
    DECLARE @OgrenciId INT;
    DECLARE @KursId INT;
    DECLARE @Durum NVARCHAR(20);

    SELECT @OgrenciId = Ogrenci_Id, @KursId = Kurs_Id, @Durum = Durum FROM INSERTED;

    IF @Durum = 'tamamlandi'
    BEGIN
        INSERT INTO Sertifikalar (Ogrenci_Id, Kurs_Id, Verilis_Tarihi, Sertifika_Kodu)
        VALUES (@OgrenciId, @KursId, GETDATE(), 'CERT-' + CAST(NEWID() AS NVARCHAR(50)));
    END
END;
