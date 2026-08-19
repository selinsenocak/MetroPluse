import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../state/alerts_store.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'Bildirimler'),
      body: ListenableBuilder(
        listenable: AlertsStore.instance,
        builder: (context, _) {
          final alerts = AlertsStore.instance.items;
          if (alerts.isEmpty) {
            return const Center(
              child: Text('Henüz bildiriminiz yok.', style: TextStyle(color: MpColors.textMuted, fontSize: 13)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(18),
            itemCount: alerts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final a = alerts[i];
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(color: a.bg, shape: BoxShape.circle),
                      child: Icon(a.icon, size: 18, color: a.color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: MpColors.textDark)),
                          const SizedBox(height: 3),
                          Text(a.desc, style: const TextStyle(fontSize: 12, color: MpColors.textMuted, height: 1.4)),
                          const SizedBox(height: 4),
                          Text(a.time, style: const TextStyle(fontSize: 11, color: MpColors.textFaint)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
