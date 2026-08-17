# MetroPulse — Yeni Bilgisayarda Kurulum Promptu

Bu dosyanın içeriğini, `metropulse` proje klasörünü kopyaladığın yeni Mac'te
Claude Code'a (veya herhangi bir agent'a) prompt olarak ver. Amaç: Flutter
SDK doğrulaması, bağımlılıklar, macOS ağ izni düzeltmesi ve iOS Simulator
kurulumu dahil, uygulamayı hem macOS masaüstünde hem de bir iOS
Simulator'da çalışır hale getirmek.

---

## PROMPT (aşağıdaki bloğu olduğu gibi yapıştır)

```
Bu bir Flutter projesi (metropulse). Aşağıdaki adımları sırayla uygula ve
her adımda çıktıyı doğrula, hata çıkarsa düzeltip devam et. Sonunda
uygulama hem macOS masaüstünde hem de bir iOS Simulator'da çalışıyor
olmalı.

1. Flutter SDK'nın PATH'te olup olmadığını kontrol et (`flutter --version`).
   Yoksa `~/development/flutter/bin`, `~/flutter/bin` gibi olası yerlere
   bak; hiçbiri yoksa https://docs.flutter.dev/get-started/install/macos
   adımlarıyla kur (stable channel). Bulduğun/kurduğun flutter'ın tam
   yolunu sonraki tüm komutlarda kullan.

2. Proje kökünde (`metropulse/`) çalıştır:
   flutter pub get

3. macOS hedefi için ağ izni kontrolü yap — bu proje google_fonts
   kullanıyor ve App Sandbox altında varsayılan entitlements dosyaları
   `com.apple.security.network.client` iznini İÇERMEZ, bu da runtime'da
   "SocketException: Operation not permitted" hatasına yol açar (font
   indirilemez). Şu iki dosyayı kontrol et ve eksikse ekle:
   - macos/Runner/DebugProfile.entitlements
   - macos/Runner/Release.entitlements
   Her ikisine de şu key-value çiftini <dict> içine ekle (yoksa):
     <key>com.apple.security.network.client</key>
     <true/>

4. macOS'ta çalıştığını doğrula:
   flutter run -d macos
   (Font hatası çıkmamalı; çıkarsa adım 3'ü tekrar kontrol et ve tam
   rebuild için önce durdurup tekrar `flutter run -d macos` çalıştır —
   entitlements değişikliği hot reload ile uygulanmaz.)

5. iOS Simulator kurulumu:
   a) Mevcut runtime'ları kontrol et: `xcrun simctl list runtimes`
   b) iOS runtime yoksa indir (birkaç GB, zaman alır):
      xcodebuild -downloadPlatform iOS
      NOT: Eğer bunu bir agent/sandbox içinden çalıştırıyorsan ve ağ
      erişimi engelleniyorsa (DNS çözülmüyorsa), sandbox'ı devre dışı
      bırakman gerekebilir (Claude Code'da Bash aracının
      "dangerouslyDisableSandbox" seçeneği gibi). Bu ağ erişimi
      gerektiren, kullanıcı onayı istenmesi gereken bir adımdır.
   c) İndirme bitince bir simulator cihazı oluştur ve boot et, örn.:
      xcrun simctl list devicetypes | grep -i "iPhone 16"
      xcrun simctl list runtimes
      xcrun simctl create "iPhone 16" com.apple.CoreSimulator.SimDeviceType.iPhone-16 <runtime-id>
      xcrun simctl boot <device-id>
      (Ya da doğrudan `flutter emulators --launch <id>` / Xcode
      Simulator.app üzerinden manuel de açılabilir.)

6. `flutter devices` ile simulator'ın göründüğünü doğrula, sonra:
   flutter run -d <simulator-device-id-veya-adı>
   İlk iOS derlemesinde CocoaPods istenirse (bu projede şu an native
   plugin yok, ios/Podfile de yok, o yüzden muhtemelen gerekmeyecek;
   yine de gerekirse):
   sudo gem install cocoapods   # veya: brew install cocoapods

7. Uygulama simulator'da açılınca ekran görüntüsü al / kısa bir
   etkileşimle (örn. ana ekranda gezinerek) çalıştığını doğrula ve
   özetle.

Ortam notları (referans, bu makinede doğrulandı):
- Flutter 3.47.0 (stable), Dart 3.13.0
- Xcode 26.6, macOS 26.5.2
- Proje native iOS plugin bağımlılığı yok (sadece cupertino_icons,
  google_fonts — ikisi de saf Dart/asset, native kod gerektirmiyor)
```

---

## Ek not
Eğer proje klasörünü olduğu gibi (git ile veya zip/AirDrop ile) kopyalarsan,
`macos/Runner/*.entitlements` düzeltmesi zaten dosyalarda mevcut olacağı için
3. adımı tekrar yapmana gerek kalmaz — sadece doğrulama amaçlı kontrol eder.
