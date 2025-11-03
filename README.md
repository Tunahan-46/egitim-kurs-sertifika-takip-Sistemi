```mermaid
erDiagram
    Kullanicilar {
        int Kullanici_Id PK
        string Ad
        string Soyad
        string Email "UNIQUE"
        string Sifre
        string Rol "CHECK ('ogrenci', 'egitmen', 'yonetici')"
        date Kayit_Tarihi
    }

    Ogrenciler {
        int Ogrenci_Id PK
        string Okul_Adi
        string Bolum
        int Sinif
        %% Ogrenci_Id -> Kullanicilar.Kullanici_Id (FK)
    }

    Egitmenler {
        int Egitmen_Id PK
        string Uzmanlik_Alani
        int Deneyim_Yili
        %% Egitmen_Id -> Kullanicilar.Kullanici_Id (FK)
    }

    Kurslar {
        int Kurs_Id PK
        string Kurs_Adi
        string Aciklama "MAX"
        date Baslangic_Tarihi
        date Bitis_Tarihi
        decimal Fiyat
        int Egitmen_Id FK
    }

    Kayitlar {
        int Kayit_Id PK
        date Kayit_Tarihi
        string Durum "CHECK (...), DEFAULT 'aktif'"
        int Ogrenci_Id FK
        int Kurs_Id FK
    }

    Sertifikalar {
        int Sertifika_Id PK
        date Verilis_Tarihi
        string Sertifika_Kodu "UNIQUE"
        int Ogrenci_Id FK
        int Kurs_Id FK
    }

    Dersler {
        int Ders_Id PK
        string Ders_Adi
        int Sure
        int Kurs_Id FK
    }

    Yoklamalar {
        int Yoklama_Id PK
        date Tarih
        bool Katildi "DEFAULT 0"
        int Kayit_Id FK
    }

    Degerlendirmeler {
        int Degerlendirme_Id PK
        int Puan "CHECK (BETWEEN 1 AND 5)"
        string Yorum "MAX"
        date Tarih
        int Kurs_Id FK
        int Ogrenci_Id FK
    }

    %% --- SQL'den Gelen İlişkiler (FOREIGN KEYs) ---
    Kullanicilar ||--|| Ogrenciler : "FK: Ogrenci_Id (1-1)"
    Kullanicilar ||--|| Egitmenler : "FK: Egitmen_Id (1-1)"
    Egitmenler ||--|{ Kurslar : "FK: Egitmen_Id (1-n)"
    Kurslar ||--|{ Dersler : "FK: Kurs_Id (1-n)"
    Kayitlar ||--|{ Yoklamalar : "FK: Kayit_Id (1-n)"
    
    %% Çoka-çok (Many-to-Many) veya dolaylı ilişkiler
    Ogrenciler |o--|{ Kayitlar : "FK: Ogrenci_Id (1-n)"
    Kurslar |o--|{ Kayitlar : "FK: Kurs_Id (1-n)"
    
    Ogrenciler |o--|{ Sertifikalar : "FK: Ogrenci_Id (1-n)"
    Kurslar |o--|{ Sertifikalar : "FK: Kurs_Id (1-n)"

    Ogrenciler |o--|{ Degerlendirmeler : "FK: Ogrenci_Id (1-n)"
    Kurslar |o--|{ Degerlendirmeler : "FK: Kurs_Id (1-n)"
```

![WhatsApp Image 2025-11-03 at 10 52 55 (1)](https://github.com/user-attachments/assets/fee78009-c085-4226-ac94-ee4a4f774b85)


Eğitim Kurs ve Sertifika Takip Sistemi
Fırat Üniversitesi BMU329 Veri Tabanı Sistemleri dersi   5. Grup "Eğitim Kurs ve Sertifika Takip Sistemi" projesidir.

Berçem Papatya-235260071

Tunahan Özdil-235260089

Taha Can Şenel-235260045


Varlıklar ve Nitelikler
1. Kullanıcılar (Kullanicilar)

Sistemdeki tüm kullanıcıları (öğrenci, eğitmen, yönetici) temsil eder.
Nitelikler:
Kullanici_Id, Ad, Soyad, Email, Sifre, Rol, Kayit_Tarihi

2. Öğrenciler (Ogrenciler)

Kullanıcı tablosundaki öğrenci kayıtlarını detaylandırır.
Nitelikler:
Ogrenci_Id, Okul_Adi, Bolum, Sinif

3. Eğitmenler (Egitmenler)

Sistemde ders veren eğitmenleri temsil eder.
Nitelikler:
Egitmen_Id, Uzmanlik_Alani, Deneyim_Yili

4. Kurslar (Kurslar)

Sistemde açılan tüm kursları içerir.
Nitelikler:
Kurs_Id, Kurs_Adi, Aciklama, Egitmen_Id, Baslangic_Tarihi, Bitis_Tarihi, Fiyat

5. Kayıtlar (Kayitlar)

Öğrencilerin kurslara katılım bilgilerini tutar.
Nitelikler:
Kayit_Id, Ogrenci_Id, Kurs_Id, Kayit_Tarihi, Durum

6. Sertifikalar (Sertifikalar)

Tamamlanan kurslar sonrası verilen sertifikaları gösterir.
Nitelikler:
Sertifika_Id, Ogrenci_Id, Kurs_Id, Verilis_Tarihi, Sertifika_Kodu

7. Dersler (Dersler)

Her kursa ait ders içeriklerini tutar.
Nitelikler:
Ders_Id, Kurs_Id, Ders_Adi, Sure

8. Yoklamalar (Yoklamalar)

Öğrencilerin ders katılım durumlarını gösterir.
Nitelikler:
Yoklama_Id, Kayit_Id, Tarih, Katildi

9. Değerlendirmeler (Degerlendirmeler)

Öğrencilerin kurslara verdikleri puan ve yorumları içerir.
Nitelikler:
Degerlendirme_Id, Kurs_Id, Ogrenci_Id, Puan, Yorum, Tarih

  Varlıklar Arasındaki İlişkiler
Kullanıcı – Öğrenci (1–1): Her öğrenci bir kullanıcıya karşılık gelir.

Kullanıcı – Eğitmen (1–1): Her eğitmen bir kullanıcıya karşılık gelir.

Eğitmen – Kurs (1–n): Bir eğitmen birden fazla kurs verebilir.

Kurs – Ders (1–n): Bir kurs birden fazla dersten oluşabilir.

Kurs – Kayıt (1–n): Bir kursa birden fazla öğrenci kayıt olabilir.

Öğrenci – Kayıt (1–n): Bir öğrenci birden fazla kursa kayıt olabilir.

Kayıt – Yoklama (1–n): Her kayıt için birden fazla yoklama tutulabilir.

Kurs – Sertifika (1–n): Kurs tamamlandığında birden fazla sertifika oluşabilir.

Öğrenci – Sertifika (1–n): Bir öğrenci birden fazla sertifika alabilir.

Kurs – Değerlendirme (1–n): Bir kursa birçok değerlendirme yapılabilir.

Öğrenci – Değerlendirme (1–n): Her öğrenci birden fazla kursu değerlendirebilir
