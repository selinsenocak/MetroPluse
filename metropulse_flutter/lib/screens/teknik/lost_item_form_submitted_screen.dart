import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';

/// Confirmation shown after the Gar Ekibi saves a found-item record.
class LostItemFormSubmittedScreen extends StatelessWidget {
  final String lineCode;
  final String itemDesc;
  const LostItemFormSubmittedScreen({super.key, required this.lineCode, required this.itemDesc});

  @override
  Widget build(BuildContext context) {
    final trackingNo = 'LST-${1000 + ('$lineCode$itemDesc'.hashCode.abs() % 8999)}';
    return Scaffold(
      backgroundColor: MpColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: const BoxDecoration(color: MpColors.greenBg, shape: BoxShape.circle),
                child: const Icon(Icons.check_circle, color: MpColors.green, size: 44),
              ),
              const SizedBox(height: 24),
              const Text('Kayıt Oluşturuldu', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: MpColors.textDark)),
              const SizedBox(height: 10),
              const Text(
                'Kayıp eşya kaydı sisteme eklendi ve İBB Personeli Paneli\'ndeki kayıp eşya listesine düştü.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.5, color: MpColors.textMuted, height: 1.5),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    _row('Takip No', trackingNo),
                    const SizedBox(height: 10),
                    _row('Hat', lineCode),
                    const SizedBox(height: 10),
                    _row('Durum', null, badge: const MpBadge(text: 'YENİ', fg: MpColors.citizenBlueDark, bg: MpColors.lightBlueBg)),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              MpPrimaryButton(
                label: 'Bakım Planına Dön',
                icon: Icons.arrow_back,
                color: MpColors.teknikBlue,
                onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String? value, {Widget? badge}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12.5, color: MpColors.textMuted, fontWeight: FontWeight.w600)),
        badge ?? Text(value ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: MpColors.textDark)),
      ],
    );
  }
}
