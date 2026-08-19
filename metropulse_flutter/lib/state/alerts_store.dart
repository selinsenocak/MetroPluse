import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AlertItem {
  final String title;
  final String desc;
  final String time;
  final IconData icon;
  final Color color;
  final Color bg;
  const AlertItem({
    required this.title,
    required this.desc,
    required this.time,
    required this.icon,
    required this.color,
    required this.bg,
  });
}

/// App-wide notification feed. A simple in-memory singleton is enough for
/// this prototype: submitting a report or a lost-item request pushes a
/// new entry here immediately, and the "Alerts" tab renders whatever is
/// in [items] live via [ChangeNotifier].
class AlertsStore extends ChangeNotifier {
  AlertsStore._internal() {
    items.addAll([
      const AlertItem(
        title: 'Kayıp eşya eşleşmesi bulundu',
        desc: '"Mavi Sırt Çantası" bildiriminize %98 eşleşme geldi. Detayları inceleyin.',
        time: '3 gün önce',
        icon: Icons.backpack_outlined,
        color: MpColors.citizenBlue,
        bg: MpColors.lightBlueBg,
      ),
      const AlertItem(
        title: 'LIF-02 arızası bildirildi',
        desc: 'Yenikapı İstasyonu güney çıkışı asansörü hizmet dışı.',
        time: 'Dün, 19:20',
        icon: Icons.error_outline,
        color: MpColors.red,
        bg: MpColors.redBg,
      ),
      const AlertItem(
        title: 'ESC-01 bakım tamamlandı',
        desc: 'Yenikapı İstasyonu yürüyen merdiveni tekrar hizmete girdi.',
        time: '2 saat önce',
        icon: Icons.check_circle_outline,
        color: MpColors.green,
        bg: MpColors.greenBg,
      ),
    ]);
  }

  static final AlertsStore instance = AlertsStore._internal();

  final List<AlertItem> items = [];

  void addFaultSubmitted(String trackingNo) {
    items.insert(
      0,
      AlertItem(
        title: 'Arıza bildiriminiz alındı',
        desc: 'Takip No: $trackingNo — teknik ekip en kısa sürede müdahale edecek. Durum değiştikçe burada bilgilendirileceksiniz.',
        time: 'Az önce',
        icon: Icons.error_outline,
        color: MpColors.red,
        bg: MpColors.redBg,
      ),
    );
    notifyListeners();
  }

  void addLostItemSubmitted(String trackingNo) {
    items.insert(
      0,
      AlertItem(
        title: 'Kayıp eşya kaydınız oluşturuldu',
        desc: 'Takip No: $trackingNo — olası bir eşleşme bulunduğunda çözüm burada görünecek.',
        time: 'Az önce',
        icon: Icons.backpack_outlined,
        color: MpColors.citizenBlue,
        bg: MpColors.lightBlueBg,
      ),
    );
    notifyListeners();
  }
}
