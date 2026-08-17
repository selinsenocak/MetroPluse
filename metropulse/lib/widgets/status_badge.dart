import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

/// designn.md'deki durum rozeti bileşenleri (status-badge-*,
/// maintenance-*-badge, resolved-badge, priority-badge).
///
/// Erişilebilirlik kuralı: durum asla yalnız renkle anlatılmaz — her rozette
/// ikon + label-caps metin birlikte bulunur (designn.md § Erişilebilirlik, 3).
enum DeviceStatusBadge {
  fault(
    label: 'ARIZALI',
    icon: Icons.error_rounded,
    background: AppColors.faultStrong,
    foreground: AppColors.surfaceRaised,
  ),
  repair(
    label: 'ONARIMDA',
    icon: Icons.build_rounded,
    background: AppColors.workStrong,
    foreground: AppColors.brandDeep,
  ),
  active(
    label: 'AKTİF',
    icon: Icons.check_circle_rounded,
    background: AppColors.okStrong,
    foreground: AppColors.surfaceRaised,
  ),
  resolved(
    label: 'ÇÖZÜLDÜ',
    icon: Icons.task_alt_rounded,
    background: AppColors.okMuted,
    foreground: AppColors.surfaceRaised,
  ),
  maintenancePulled(
    label: 'BAKIM ÖNE ÇEKİLDİ',
    icon: Icons.priority_high_rounded,
    background: AppColors.workAmber,
    foreground: AppColors.brandDeep,
  ),
  maintenancePlanned(
    label: 'PLANLI BAKIM',
    icon: Icons.event_rounded,
    background: AppColors.workPlan,
    foreground: AppColors.brandDeep,
  ),
  priority(
    label: 'ÖNCELİKLİ',
    icon: Icons.bolt_rounded,
    background: AppColors.faultAccent,
    foreground: AppColors.surfaceRaised,
  );

  const DeviceStatusBadge({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
}

class StatusBadgeChip extends StatelessWidget {
  const StatusBadgeChip({super.key, required this.status});

  final DeviceStatusBadge status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: status.background,
        borderRadius: BorderRadius.circular(AppRadii.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 12, color: status.foreground),
          const SizedBox(width: 4),
          Text(
            status.label,
            style: AppTextStyles.labelCaps.copyWith(color: status.foreground),
          ),
        ],
      ),
    );
  }
}
