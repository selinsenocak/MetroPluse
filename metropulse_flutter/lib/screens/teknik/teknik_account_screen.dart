import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../state/auth_store.dart';
import '../login_screen.dart';

/// The Teknik Ekip panel's "Hesabım" tab — mirrors the citizen panel's
/// account screen, styled with the teknik accent color.
class TeknikAccountScreen extends StatelessWidget {
  const TeknikAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthStore.instance.currentUser;
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'Hesabım', background: MpColors.teknikBlue),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(color: MpColors.lightBlueBg, shape: BoxShape.circle),
                  child: const Icon(Icons.engineering_outlined, color: MpColors.teknikBlue, size: 32),
                ),
                const SizedBox(height: 14),
                Text(user?.name ?? 'Teknik Personel', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: MpColors.textDark)),
                const SizedBox(height: 4),
                if (user != null) ...[
                  Text(user.identifiers.first, style: const TextStyle(fontSize: 12.5, color: MpColors.textMuted)),
                  const SizedBox(height: 8),
                  MpBadge(text: user.roleLabel.toUpperCase(), fg: MpColors.teknikBlue, bg: MpColors.lightBlueBg),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          _menuItem(icon: Icons.assignment_turned_in_outlined, label: 'Görev Geçmişim'),
          const SizedBox(height: 10),
          _menuItem(icon: Icons.groups_outlined, label: 'Ekibim'),
          const SizedBox(height: 10),
          _menuItem(icon: Icons.notifications_outlined, label: 'Bildirim Tercihleri'),
          const SizedBox(height: 10),
          _menuItem(icon: Icons.help_outline, label: 'Yardım ve Destek'),
          const SizedBox(height: 24),
          MpSecondaryButton(
            label: 'Çıkış Yap',
            color: MpColors.red,
            onTap: () {
              AuthStore.instance.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _menuItem({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 19, color: MpColors.textMuted),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: MpColors.textDark))),
          const Icon(Icons.chevron_right, size: 19, color: MpColors.textFaint),
        ],
      ),
    );
  }
}
