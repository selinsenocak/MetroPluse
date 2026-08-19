import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(
        title: 'MetroPulse',
        background: MpColors.purple,
        trailingIcon: Icons.person_outline,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
        children: [
          const Text('Sistem Performans Genel Bakışı',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: MpColors.textDark, height: 1.25)),
          const SizedBox(height: 6),
          const Text('Aktif altyapı için gerçek zamanlı durum ve bakım metrikleri.',
              style: TextStyle(fontSize: 12.5, color: MpColors.textMuted)),
          const SizedBox(height: 16),
          const MpStatTile(
            label: 'Sistem Çalışma Süresi',
            value: '%99.98',
            icon: Icons.check,
            iconBg: MpColors.greenBg,
            iconColor: MpColors.green,
          ),
          const SizedBox(height: 10),
          const MpStatTile(
            label: 'Toplam Aktif Arıza',
            value: '24',
            valueColor: MpColors.textDark,
            icon: Icons.error_outline,
            iconBg: MpColors.redBg,
            iconColor: MpColors.red,
          ),
          const SizedBox(height: 10),
          MpCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('BAKIM TAMAMLANMA', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
                        SizedBox(height: 4),
                        Text('%87', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: MpColors.textDark)),
                      ],
                    ),
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(color: MpColors.orangeBg, shape: BoxShape.circle),
                      child: const Icon(Icons.build_outlined, size: 14, color: MpColors.orange),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: 0.87,
                    minHeight: 8,
                    backgroundColor: MpColors.bg,
                    valueColor: const AlwaysStoppedAnimation(MpColors.orange),
                  ),
                ),
                const SizedBox(height: 6),
                const Text('Hedef: 24 saat içinde %95', style: TextStyle(fontSize: 11, color: MpColors.textFaint)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          MpCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Haftalık Arıza Trendi', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: MpColors.textDark)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(color: MpColors.cardBg, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(6)),
                      child: const Text('Veri Aktar', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: MpColors.textDark)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 90,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [0.45, 0.62, 0.35, 0.75, 0.55, 0.22, 0.12]
                        .map((h) => Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                height: 90 * h,
                                decoration: const BoxDecoration(color: MpColors.teknikBlue, borderRadius: BorderRadius.vertical(top: Radius.circular(3))),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz']
                      .map((d) => Text(d, style: const TextStyle(fontSize: 10.5, color: MpColors.textFaint)))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          MpCard(
            topBorderColor: MpColors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [
                  Icon(Icons.warning_amber_rounded, size: 18, color: MpColors.red),
                  SizedBox(width: 8),
                  Text('Öncelikli Lokasyonlar', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: MpColors.textDark)),
                ]),
                const SizedBox(height: 12),
                _priorityRow('1', 'Merkez Hub', 'Sinyal Arızası (Kod 4A)', 'Kritik', MpColors.red, MpColors.redBg, Colors.white),
                const SizedBox(height: 10),
                _priorityRow('2', 'Kuzey Hattı', 'Ray Aşınması', 'Yüksek', MpColors.orangeDark, MpColors.orangeBg, MpColors.orangeDark),
                const SizedBox(height: 10),
                _priorityRow('3', 'Doğu Depo', 'Sensör Kalibrasyonu', 'Düşük', MpColors.citizenBlueDark, MpColors.lightBlueBg, MpColors.citizenBlueDark),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const MpPrimaryButton(label: 'Tüm Olay Raporlarını Görüntüle'),
        ],
      ),
    );
  }

  Widget _priorityRow(String num, String title, String desc, String tag, Color tagFg, Color badgeBg, Color numFg) {
    final numBg = badgeBg;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: numBg, borderRadius: BorderRadius.circular(6)),
          child: Text(num, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: tagFg)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: MpColors.textDark)),
              Text(desc, style: const TextStyle(fontSize: 11.5, color: MpColors.textMuted)),
            ],
          ),
        ),
        MpBadge(text: tag, fg: tag == 'Kritik' ? Colors.white : tagFg, bg: tag == 'Kritik' ? MpColors.red : badgeBg),
      ],
    );
  }
}
