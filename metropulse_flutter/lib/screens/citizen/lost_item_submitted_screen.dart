import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../state/alerts_store.dart';

/// Shown after "Sisteme Kaydet" on the lost-item entry form.
class LostItemSubmittedScreen extends StatefulWidget {
  final String? category;
  const LostItemSubmittedScreen({super.key, this.category});

  @override
  State<LostItemSubmittedScreen> createState() => _LostItemSubmittedScreenState();
}

class _LostItemSubmittedScreenState extends State<LostItemSubmittedScreen> {
  late final String trackingNo;

  @override
  void initState() {
    super.initState();
    trackingNo = 'LST-${1000 + (widget.category?.hashCode.abs() ?? 77) % 8999}';
    // Any future match for this lost item will also be pushed to
    // Bildirimler — the submission itself is the first entry in that flow.
    AlertsStore.instance.addLostItemSubmitted(trackingNo);
  }

  @override
  Widget build(BuildContext context) {
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
                decoration: const BoxDecoration(color: MpColors.lightBlueBg, shape: BoxShape.circle),
                child: const Icon(Icons.check_circle, color: MpColors.citizenBlue, size: 44),
              ),
              const SizedBox(height: 24),
              const Text(
                'Talebiniz Oluşturuldu',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: MpColors.textDark),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kayıp eşya kaydınız sisteme alındı. Olası bir eşleşme bulunduğunda Bildirimler sekmesinden haberdar olacaksınız.',
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
                    _row('Takip Numarası', trackingNo),
                    if (widget.category != null) ...[
                      const SizedBox(height: 10),
                      _row('Eşya Kategorisi', widget.category!),
                    ],
                    const SizedBox(height: 10),
                    _row('Durum', null, badge: const MpBadge(text: 'ARANIYOR', fg: MpColors.citizenBlueDark, bg: MpColors.lightBlueBg)),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              MpPrimaryButton(
                label: 'Ana Sayfaya Dön',
                icon: Icons.home_rounded,
                color: MpColors.citizenBlue,
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
