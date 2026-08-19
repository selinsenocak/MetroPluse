import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import 'qr_scan_screen.dart';
import 'lost_item_entry_screen.dart';

/// The Vatandaş Paneli's "Giriş" tab: asks what the citizen wants to do
/// first — reporting a fault (straight into the QR / manual-entry scan
/// flow) or reporting a lost item.
class CitizenHomeScreen extends StatelessWidget {
  const CitizenHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: AppBar(
        backgroundColor: MpColors.navy,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(children: const [
          MpMark(size: 20),
          SizedBox(width: 8),
          Text('MetroPulse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
        ]),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  const Text('Ne bildirmek istersiniz?',
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: MpColors.textDark)),
                  const SizedBox(height: 6),
                  const Text('Aşağıdan devam etmek istediğiniz işlemi seçin.',
                      style: TextStyle(fontSize: 13, color: MpColors.textMuted)),
                  const SizedBox(height: 30),
                  _optionCard(
                    context,
                    icon: Icons.error_outline,
                    accent: MpColors.red,
                    accentBg: MpColors.redBg,
                    title: 'Arıza Bildir',
                    desc: 'Arızalı bir yürüyen merdiven, asansör veya turnike için QR ile veya manuel olarak bildirim oluşturun.',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const QrScanScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _optionCard(
                    context,
                    icon: Icons.backpack_outlined,
                    accent: MpColors.citizenBlue,
                    accentBg: MpColors.lightBlueBg,
                    title: 'Kayıp Eşya Bildir',
                    desc: 'Kaybettiğiniz eşyaya ait bilgi girip olası eşleşmeleri görün.',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LostItemEntryScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _optionCard(
    BuildContext context, {
    required IconData icon,
    required Color accent,
    required Color accentBg,
    required String title,
    required String desc,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: MpColors.border),
            boxShadow: [
              BoxShadow(color: accent.withValues(alpha: 0.10), blurRadius: 22, offset: const Offset(0, 10)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(color: accentBg, shape: BoxShape.circle),
                    child: Icon(icon, color: accent, size: 27),
                  ),
                  const Spacer(),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(color: accentBg, shape: BoxShape.circle),
                    child: Icon(Icons.arrow_forward, color: accent, size: 17),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19, color: MpColors.textDark)),
              const SizedBox(height: 8),
              Text(desc, style: const TextStyle(fontSize: 13, color: MpColors.textMuted, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}
