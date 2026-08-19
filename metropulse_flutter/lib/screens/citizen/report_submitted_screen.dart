import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../state/alerts_store.dart';

/// Shown after "Bildirimi Gönder" — confirms the fault report was
/// received and gives the citizen a way back to the main panel.
class ReportSubmittedScreen extends StatefulWidget {
  final String? deviceId;
  const ReportSubmittedScreen({super.key, this.deviceId});

  @override
  State<ReportSubmittedScreen> createState() => _ReportSubmittedScreenState();
}

class _ReportSubmittedScreenState extends State<ReportSubmittedScreen> {
  late final String trackingNo;

  @override
  void initState() {
    super.initState();
    // Mock tracking number for the demo — a real backend would return this.
    trackingNo = 'FR-${1000 + (widget.deviceId?.hashCode.abs() ?? 42) % 8999}';
    // Reporting a fault is a change in the citizen's request flow, so it
    // immediately lands in the Bildirimler (Alerts) feed.
    AlertsStore.instance.addFaultSubmitted(trackingNo);
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
                decoration: const BoxDecoration(color: MpColors.greenBg, shape: BoxShape.circle),
                child: const Icon(Icons.check_circle, color: MpColors.green, size: 44),
              ),
              const SizedBox(height: 24),
              const Text(
                'Bildiriminiz Alındı',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: MpColors.textDark),
              ),
              const SizedBox(height: 10),
              const Text(
                'Arıza bildiriminiz teknik ekibimize iletildi. En kısa sürede müdahale edilecektir.',
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
                    if (widget.deviceId != null) ...[
                      const SizedBox(height: 10),
                      _row('Cihaz ID', '# ${widget.deviceId}'),
                    ],
                    const SizedBox(height: 10),
                    _row('Durum', null, badge: const MpBadge(text: 'BEKLEMEDE', fg: MpColors.redDark, bg: MpColors.redBg)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.notifications_active_outlined, size: 14, color: MpColors.textFaint),
                  SizedBox(width: 6),
                  Text('Durum değişikliği Bildirimler sekmesine düşecek', style: TextStyle(fontSize: 11.5, color: MpColors.textFaint)),
                ],
              ),
              const SizedBox(height: 22),
              MpPrimaryButton(
                label: 'Ana Sayfaya Dön',
                icon: Icons.home_rounded,
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
