import 'package:flutter/material.dart';

import '../models/device.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/device_card.dart';

/// Üç panel de aynı token setini ve aynı cihaz listesi bileşenini paylaşır;
/// ayrım yalnızca AppBar rengi ve birincil eylemde yapılır
/// (designn.md § Panel Ayrımı).
class PanelHomeScreen extends StatelessWidget {
  const PanelHomeScreen({super.key, required this.panel});

  final MetroPanel panel;

  List<Device> get _visibleDevices => switch (panel) {
        // Vatandaş Paneli: yalnızca arızalı cihazları görüntüler (intennt.md §4.1)
        MetroPanel.citizen =>
          sampleDevices.where((d) => d.status == DeviceLifecycleStatus.fault).toList(),
        // İBB Personeli ve Teknik Ekip: tüm cihazlar (intennt.md §4.2, §4.3)
        MetroPanel.ibb || MetroPanel.technical => sampleDevices,
      };

  @override
  Widget build(BuildContext context) {
    final devices = _visibleDevices;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: panel.headerColor,
        title: Text(panel.label),
      ),
      body: Column(
        children: [
          if (panel == MetroPanel.ibb) _IbbNotice(),
          Expanded(
            child: devices.isEmpty
                ? const _EmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: devices.length,
                    separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) => DeviceCard(device: devices[index]),
                  ),
          ),
        ],
      ),
      floatingActionButton: switch (panel) {
        MetroPanel.citizen => FloatingActionButton.extended(
            backgroundColor: AppColors.fault,
            foregroundColor: AppColors.surfaceRaised,
            onPressed: () => _showComingSoon(context, 'QR ile arıza bildirimi'),
            icon: const Icon(Icons.qr_code_scanner_rounded),
            label: const Text('Arıza Bildir'),
          ),
        MetroPanel.technical => FloatingActionButton.extended(
            backgroundColor: AppColors.active,
            foregroundColor: AppColors.surfaceRaised,
            onPressed: () => _showComingSoon(context, 'Bakım-onarım önceliklendirme'),
            icon: const Icon(Icons.build_rounded),
            label: const Text('Bakım Planı'),
          ),
        MetroPanel.ibb => null,
      },
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature — bir sonraki iterasyonda eklenecek')),
    );
  }
}

class _IbbNotice extends StatelessWidget {
  const _IbbNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      color: AppColors.brandSurface,
      child: Text(
        'Bu panel salt izleme amaçlıdır; arıza çözümü ve bakım planlaması '
        'Teknik Ekip Panelinin sorumluluğundadır.',
        style: AppTextStyles.bodySm.copyWith(color: AppColors.brandDeep),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline_rounded, size: 40, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Görüntülenecek arızalı cihaz yok',
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
