import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';

/// Mock maintenance / fault history for a single device.
class DeviceHistoryScreen extends StatelessWidget {
  final String deviceId;
  const DeviceHistoryScreen({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    final records = [
      {
        'date': '12 Ekim 2023',
        'title': 'Periyodik Bakım',
        'desc': 'Rutin yağlama ve mekanik kontrol gerçekleştirildi.',
        'team': 'Ekip Alfa',
        'status': 'Tamamlandı',
      },
      {
        'date': '05 Eylül 2023',
        'title': 'Arıza Onarımı — Kapı Sensörü',
        'desc': 'Kapı açma/kapama sensörü değiştirildi, test edildi.',
        'team': 'Ekip Beta',
        'status': 'Tamamlandı',
      },
    ];

    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'Cihaz Geçmişi', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        children: [
          Text('# $deviceId',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textMuted)),
          const SizedBox(height: 4),
          const Text('Bakım ve Arıza Kayıtları',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: MpColors.textDark)),
          const SizedBox(height: 16),
          for (final r in records) ...[
            MpCard(
              topBorderColor: MpColors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(r['date']!, style: const TextStyle(fontSize: 11.5, color: MpColors.textFaint, fontWeight: FontWeight.w600)),
                      MpBadge(text: r['status']!, fg: MpColors.greenDark, bg: MpColors.greenBg),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(r['title']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: MpColors.textDark)),
                  const SizedBox(height: 6),
                  Text(r['desc']!, style: const TextStyle(fontSize: 12.5, color: MpColors.textMuted, height: 1.4)),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.people_alt_outlined, size: 13, color: MpColors.textFaint),
                    const SizedBox(width: 6),
                    Text(r['team']!, style: const TextStyle(fontSize: 12, color: MpColors.textMuted, fontWeight: FontWeight.w500)),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
