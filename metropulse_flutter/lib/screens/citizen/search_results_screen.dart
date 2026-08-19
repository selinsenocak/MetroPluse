import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'MetroPulse', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
        children: [
          const Text('Arama Sonuçları', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: MpColors.textDark)),
          const SizedBox(height: 6),
          const Text('"Mavi Sırt Çantası" için Merkez İstasyon\'da bildirilen olası eşleşmeler gösteriliyor.',
              style: TextStyle(fontSize: 12.5, color: MpColors.textMuted, height: 1.4)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: [
            _tag('Sırt Çantaları'),
            _tag('Merkez İstasyon'),
          ]),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sırala:', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textMuted)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(8)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Text('Eşleşme Oranı', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: MpColors.textDark)),
                  Icon(Icons.keyboard_arrow_down, size: 16, color: MpColors.textFaint),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _resultCard(
            id: 'ITEM-8932',
            match: '↑ %98 EŞLEŞME',
            matchFg: MpColors.greenDark,
            matchBg: MpColors.greenBg,
            title: 'Lacivert Sırt Çantası',
            loc: 'Merkez İst., Platform 4',
            time: 'Bugün, 08:45',
            topBorder: MpColors.navy,
          ),
          const SizedBox(height: 12),
          _resultCard(
            id: 'ITEM-8911',
            match: '%75 EŞLEŞME',
            matchFg: MpColors.orangeDark,
            matchBg: MpColors.orangeBg,
            title: 'Koyu Mavi Sırt Çantası',
            loc: 'Kuzey İst., Bilet Gişesi',
            time: 'Dün, 19:20',
          ),
        ],
      ),
    );
  }

  Widget _tag(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: MpColors.lightBlueBg, borderRadius: BorderRadius.circular(999)),
        child: Text(label, style: const TextStyle(color: MpColors.citizenBlueDark, fontWeight: FontWeight.w600, fontSize: 12)),
      );

  Widget _resultCard({
    required String id,
    required String match,
    required Color matchFg,
    required Color matchBg,
    required String title,
    required String loc,
    required String time,
    Color? topBorder,
  }) {
    return MpCard(
      topBorderColor: topBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ID: $id', style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: MpColors.textFaint)),
              MpBadge(text: match, fg: matchFg, bg: matchBg),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 56, height: 56, decoration: BoxDecoration(color: MpColors.placeholderBox, borderRadius: BorderRadius.circular(8))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5, color: MpColors.textDark)),
                    const SizedBox(height: 4),
                    Text(loc, style: const TextStyle(fontSize: 12, color: MpColors.textMuted)),
                    Text(time, style: const TextStyle(fontSize: 12, color: MpColors.textFaint)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: MpSecondaryButton(label: 'Detayları Gör', onTap: () {})),
              const SizedBox(width: 10),
              Expanded(child: MpPrimaryButton(label: 'Eşleştir', onTap: () {})),
            ],
          ),
        ],
      ),
    );
  }
}
