import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';

class LostItemDetailScreen extends StatelessWidget {
  const LostItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'MetroPulse', background: MpColors.purple, showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
        children: [
          const Text('Kayıp Eşya Detay', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: MpColors.textDark)),
          const SizedBox(height: 4),
          const Text('Eşya detaylarını inceleyin ve aksiyon alın.', style: TextStyle(fontSize: 12.5, color: MpColors.textMuted)),
          const SizedBox(height: 14),
          Container(
            height: 170,
            decoration: const BoxDecoration(
              color: MpColors.placeholderBox,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Center(child: Icon(Icons.image_outlined, size: 36, color: Color(0xFF8B8B87))),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: MpColors.border),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                MpInfoRow(label: 'Takip No', value: 'LST-8923-B', divider: false),
                const MpInfoRow(label: 'Bulunduğu Yer', value: 'Taksim İstasyonu - Peron 2'),
                const MpInfoRow(label: 'Bulunma Saati', value: '14:35 - 12 Ekim 2023'),
                const MpInfoRow(label: 'Kategori', value: 'Kişisel Eşya / Cüzdan'),
                MpInfoRow(
                  label: 'Açıklama',
                  valueWidget: const Text(
                    'Siyah deri cüzdan, içerisinde kimlik bulunmuyor, bir miktar nakit ve kredi kartları mevcut. Güvenlik personeli tarafından teslim alındı.',
                    style: TextStyle(fontSize: 13, color: Color(0xFF3A4A63), height: 1.5),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: MpPrimaryButton(label: 'Eşleştir')),
              const SizedBox(width: 10),
              Expanded(child: MpSecondaryButton(label: 'Arşive Gönder')),
            ],
          ),
        ],
      ),
    );
  }
}
