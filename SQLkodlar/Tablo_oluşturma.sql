DROP TABLE IF EXISTS Degerlendirmeler;
DROP TABLE IF EXISTS Yoklamalar;
DROP TABLE IF EXISTS Dersler;
DROP TABLE IF EXISTS Sertifikalar;
DROP TABLE IF EXISTS Kayitlar;
DROP TABLE IF EXISTS Kurslar;
DROP TABLE IF EXISTS Egitmenler;
DROP TABLE IF EXISTS Ogrenciler;
DROP TABLE IF EXISTS Kullanicilar;

CREATE TABLE Kullanicilar (
    Kullanici_Id INT PRIMARY KEY IDENTITY(1,1),
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Sifre VARCHAR(255),
    Rol VARCHAR(20) CHECK (Rol IN ('ogrenci', 'egitmen', 'yonetici')),
    Kayit_Tarihi DATE
);

CREATE TABLE Ogrenciler (
    Ogrenci_Id INT PRIMARY KEY,
    Okul_Adi VARCHAR(100),
    Bolum VARCHAR(100),
    Sinif INT,
    FOREIGN KEY (Ogrenci_Id) REFERENCES Kullanicilar(Kullanici_Id)
);

CREATE TABLE Egitmenler (
    Egitmen_Id INT PRIMARY KEY,
    Uzmanlik_Alani VARCHAR(100),
    Deneyim_Yili INT,
    FOREIGN KEY (Egitmen_Id) REFERENCES Kullanicilar(Kullanici_Id)
);

CREATE TABLE Kurslar (
    Kurs_Id INT PRIMARY KEY IDENTITY(1,1),
    Kurs_Adi VARCHAR(100),
    Aciklama VARCHAR(MAX),
    Egitmen_Id INT,
    Baslangic_Tarihi DATE,
    Bitis_Tarihi DATE,
    Fiyat DECIMAL(10,2),
    FOREIGN KEY (Egitmen_Id) REFERENCES Egitmenler(Egitmen_Id)
);

CREATE TABLE Kayitlar (
    Kayit_Id INT PRIMARY KEY IDENTITY(1,1),
    Ogrenci_Id INT,
    Kurs_Id INT,
    Kayit_Tarihi DATE,
    Durum VARCHAR(20) CHECK (Durum IN ('aktif', 'tamamlandi', 'iptal')) DEFAULT 'aktif',
    FOREIGN KEY (Ogrenci_Id) REFERENCES Ogrenciler(Ogrenci_Id),
    FOREIGN KEY (Kurs_Id) REFERENCES Kurslar(Kurs_Id)
);

CREATE TABLE Sertifikalar (
    Sertifika_Id INT PRIMARY KEY IDENTITY(1,1),
    Ogrenci_Id INT,
    Kurs_Id INT,
    Verilis_Tarihi DATE,
    Sertifika_Kodu VARCHAR(50) UNIQUE,
    FOREIGN KEY (Ogrenci_Id) REFERENCES Ogrenciler(Ogrenci_Id),
    FOREIGN KEY (Kurs_Id) REFERENCES Kurslar(Kurs_Id)
);

CREATE TABLE Dersler (
    Ders_Id INT PRIMARY KEY IDENTITY(1,1),
    Kurs_Id INT,
    Ders_Adi VARCHAR(100),
    Sure INT,
    FOREIGN KEY (Kurs_Id) REFERENCES Kurslar(Kurs_Id)
);

CREATE TABLE Yoklamalar (
    Yoklama_Id INT PRIMARY KEY IDENTITY(1,1),
    Kayit_Id INT,
    Tarih DATE,
    Katildi BIT DEFAULT 0,
    FOREIGN KEY (Kayit_Id) REFERENCES Kayitlar(Kayit_Id)
);

CREATE TABLE Degerlendirmeler (
    Degerlendirme_Id INT PRIMARY KEY IDENTITY(1,1),
    Kurs_Id INT,
    Ogrenci_Id INT,
    Puan INT CHECK (Puan BETWEEN 1 AND 5),
    Yorum VARCHAR(MAX),
    Tarih DATE,
    FOREIGN KEY (Kurs_Id) REFERENCES Kurslar(Kurs_Id),
    FOREIGN KEY (Ogrenci_Id) REFERENCES Ogrenciler(Ogrenci_Id)
);
