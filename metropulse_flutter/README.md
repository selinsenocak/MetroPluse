# MetroPulse

İBB Metro İstanbul için üç rollü (Vatandaş, Teknik Ekip, İBB Personeli) bir cihaz arıza takibi ve kayıp eşya sistemi — Flutter ile geliştirilmiş prototip mobil uygulama.

## Roller ve Özellikler

**Vatandaş Paneli**
- QR kod ile veya manuel cihaz ID girerek arıza bildirimi
- Kayıp eşya bildirimi (hat/istasyon seçimi, tarih-saat, kategori, fotoğraf)
- Hizmet Durumu: tüm Metro İstanbul hatları, arızalı hat filtresi, istasyon bazlı cihaz envanteri
- Bildirimler (canlı akış) ve Hesabım sekmeleri

**Teknik Ekip Paneli**
- Arıza bildirim geçmişi (tam liste, filtreleme, CSV/Excel dışa aktarma)
- Bakım planı: aktif Başlat/Detaylar/Güncelle/Tamamla akışı ve veri odaklı bakım önceliklendirme önerisi
- Gar ekibi için kayıp eşya kayıt formu

**İBB Personeli Paneli**
- Sistem performans genel bakışı
- Kayıp eşya kayıtlarının yönetimi

## Giriş

Tek bir giriş ekranından, girilen hesaba göre ilgili panel açılır. Demo hesapları:

| Rol | Kullanıcı Adı | Şifre |
|---|---|---|
| Vatandaş | `selin@gmail.com` veya `0555 555 55 55` | `1234` |
| Teknik Ekip | `hasan@ibbteknik.com` | `1234` |
| İBB Personeli | `elifbuyuk@ibbpersonel.com` | `1234` |

## Çalıştırma

```bash
flutter pub get
flutter run
```

Bu bir tasarım prototipidir; veriler uygulama içinde üretilen mock verilerdir, gerçek bir backend'e bağlı değildir.
