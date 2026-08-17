import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import 'panel_home_screen.dart';

/// Giriş ekranı: intennt.md §2'deki üç panelden birini seçtirir.
/// (Gerçek sürümde bu ekranın yerini panel bazlı kimlik doğrulama alacaktır
/// — intennt.md §10.5.)
class PanelSelectScreen extends StatelessWidget {
  const PanelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text('MetroPulse', style: AppTextStyles.h1),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'İBB Metro İstanbul arıza takip, kayıp eşya ve '
                'bakım-onarım sistemi',
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.xl),
              for (final panel in MetroPanel.values) ...[
                _PanelCard(panel: panel),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PanelCard extends StatelessWidget {
  const _PanelCard({required this.panel});

  final MetroPanel panel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: panel.headerColor,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.md),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => PanelHomeScreen(panel: panel)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  panel.label,
                  style: AppTextStyles.h2.copyWith(color: AppColors.station),
                ),
              ),
              const Icon(Icons.arrow_forward_rounded, color: AppColors.station),
            ],
          ),
        ),
      ),
    );
  }
}
