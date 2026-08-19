import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import 'lost_item_detail_screen.dart';

class LostItemListScreen extends StatelessWidget {
  const LostItemListScreen({super.key});

  static const _items = [
    {'id': 'LST-8923-B', 'title': 'Siyah Deri Cüzdan', 'loc': 'Taksim İstasyonu - Peron 2', 'time': '14:35 - 12 Eki'},
    {'id': 'LST-8918-A', 'title': 'Gri Şemsiye', 'loc': 'Kadıköy İstasyonu - Ana Giriş', 'time': '09:10 - 11 Eki'},
    {'id': 'LST-8901-C', 'title': 'Siyah Kablosuz Kulaklık', 'loc': 'Levent İstasyonu - Peron 1', 'time': '18:52 - 09 Eki'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'Kayıp Eşya', background: MpColors.purple),
      body: ListView.separated(
        padding: const EdgeInsets.all(18),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final it = _items[i];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LostItemDetailScreen())),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(width: 46, height: 46, decoration: BoxDecoration(color: MpColors.placeholderBox, borderRadius: BorderRadius.circular(8))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(it['title']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: MpColors.textDark)),
                        const SizedBox(height: 2),
                        Text(it['loc']!, style: const TextStyle(fontSize: 11.5, color: MpColors.textMuted)),
                        Text(it['time']!, style: const TextStyle(fontSize: 11, color: MpColors.textFaint)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: MpColors.textFaint),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
