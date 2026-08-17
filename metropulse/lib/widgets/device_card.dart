import 'package:flutter/material.dart';

import '../models/device.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import 'status_badge.dart';

/// designn.md card-fault / card-repair / card-active bileşenleri, tek bir
/// cihaz durumu için birleştirilmiş kart. Açık hatlarda (M6, M7, M9, M12, T2)
/// rozet metni brand-deep, diğerlerinde surface-raised (designn.md § Hat
/// Rozetleri).
class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.device});

  final Device device;

  static const _lightLines = {'M6', 'M7', 'M9', 'M12', 'T2'};

  (Color bg, Color text) get _surfaceColors => switch (device.status) {
        DeviceLifecycleStatus.fault => (AppColors.faultSurface, AppColors.faultDeep),
        DeviceLifecycleStatus.repair => (AppColors.workSurface, AppColors.workDeep),
        DeviceLifecycleStatus.active => (AppColors.okSurface, AppColors.okDeep),
      };

  @override
  Widget build(BuildContext context) {
    final (bg, textColor) = _surfaceColors;
    final lineBadgeTextColor =
        _lightLines.contains(device.line) ? AppColors.brandDeep : AppColors.surfaceRaised;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: device.lineColor,
                  borderRadius: BorderRadius.circular(AppRadii.xs),
                ),
                child: Text(
                  device.line,
                  style: AppTextStyles.lineBadge.copyWith(color: lineBadgeTextColor),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  '${device.type.label} · ${device.station}',
                  style: AppTextStyles.labelStrong.copyWith(color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              StatusBadgeChip(status: device.status.badge),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.brandSurface,
              borderRadius: BorderRadius.circular(AppRadii.xs),
            ),
            child: Text(device.id, style: AppTextStyles.deviceId),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            device.lastFaultReason != null
                ? 'Son arıza: ${device.lastFaultReason} · Son bakım: ${device.lastMaintenance}'
                : 'Son bakım: ${device.lastMaintenance}',
            style: AppTextStyles.bodySm,
          ),
        ],
      ),
    );
  }
}
