import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import 'report_fault_screen.dart';
import 'device_history_screen.dart';

class DeviceInfoScreen extends StatelessWidget {
  /// The device ID that was scanned / typed to reach this screen.
  /// Falls back to a mock ID when the screen is reached without one
  /// (e.g. tapping the camera-scan frame directly).
  final String? deviceId;
  const DeviceInfoScreen({super.key, this.deviceId});

  String get _resolvedId => deviceId ?? 'ELV-M2-KZY-04';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'Cihaz Bilgi Ekranı', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: MpColors.greenBg, borderRadius: BorderRadius.circular(12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: MpColors.greenDark, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(deviceId != null ? 'Cihaz ID Onaylandı' : 'QR Kod Başarıyla Okundu',
                          style: const TextStyle(color: MpColors.greenDark, fontWeight: FontWeight.w700, fontSize: 14)),
                      const SizedBox(height: 2),
                      const Text('Cihaz bilgileri sistemden çekildi.',
                          style: TextStyle(color: Color(0xFF3B6B45), fontSize: 12.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: MpColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(height: 3, decoration: const BoxDecoration(color: MpColors.teknikBlue, borderRadius: BorderRadius.vertical(top: Radius.circular(11)))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Column(
                    children: [
                      MpInfoRow(
                        label: 'Cihaz Kimliği',
                        divider: false,
                        valueWidget: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(color: MpColors.bg, borderRadius: BorderRadius.circular(6)),
                          child: Text('# $_resolvedId',
                              style: const TextStyle(fontFamily: 'monospace', color: MpColors.textDark, fontWeight: FontWeight.w600, fontSize: 14)),
                        ),
                      ),
                      const MpInfoRow(label: 'Cihaz Tipi', value: 'Asansör (Yolcu)'),
                      const MpInfoRow(label: 'Konum', value: 'M2 Hattı / Kuzey İstasyonu / Peron İniş'),
                      MpInfoRow(
                        label: 'Güncel Durum',
                        valueWidget: const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: MpBadge(text: 'AKTİF ÇALIŞIYOR', fg: Colors.white, bg: MpColors.green, dot: true),
                        ),
                      ),
                      const MpInfoRow(label: 'Son Bakım Tarihi', value: '12 Ekim 2023'),
                      const MpInfoRow(label: 'Marka / Model', value: 'Schindler 3300'),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          MpPrimaryButton(
            label: 'Geçmişi Görüntüle',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => DeviceHistoryScreen(deviceId: _resolvedId)),
            ),
          ),
          const SizedBox(height: 12),
          MpSecondaryButton(
            label: 'Arıza Bildir',
            color: MpColors.red,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ReportFaultScreen(deviceId: _resolvedId)),
            ),
          ),
        ],
      ),
    );
  }
}
