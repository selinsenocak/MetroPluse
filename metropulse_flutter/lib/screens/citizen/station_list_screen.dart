import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../data/metro_lines.dart';
import '../../data/station_mock_data.dart';
import 'station_detail_screen.dart';

class _StationRef {
  final String name;
  final String lineCode;
  final int faultCount;
  const _StationRef({required this.name, required this.lineCode, required this.faultCount});
}

/// Flattens Metro İstanbul lines into a browsable station list — either
/// every line (the bottom-nav "Hizmet Durumu" root), or just one line's
/// stations when reached from the line list.
List<_StationRef> _buildStations({String? onlyLine}) {
  final refs = <_StationRef>[];
  for (final line in metroLines) {
    if (onlyLine != null && line.code != onlyLine) continue;
    for (final station in line.stations) {
      refs.add(_StationRef(name: station, lineCode: line.code, faultCount: stationFaultCount(line.code, station)));
    }
  }
  return refs;
}

class StationListScreen extends StatelessWidget {
  /// True when this screen is reached by being pushed on top of another
  /// route rather than shown as a bottom-nav tab root — a pushed instance
  /// needs a working back button since there's no bottom nav around it.
  final bool showBackButton;

  /// Restrict the list to one line (e.g. "M2"). Null shows every station
  /// across every line.
  final String? lineCode;
  final String? lineRouteName;

  const StationListScreen({super.key, this.showBackButton = false, this.lineCode, this.lineRouteName});

  @override
  Widget build(BuildContext context) {
    final stations = _buildStations(onlyLine: lineCode);
    final title = lineCode != null ? '$lineCode İstasyonları' : 'İstasyonlar (${stations.length})';
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: MpHeader(title: title, showBack: showBackButton),
      body: Column(
        children: [
          if (lineRouteName != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(lineRouteName!, style: const TextStyle(fontSize: 12.5, color: MpColors.textMuted, fontWeight: FontWeight.w600)),
              ),
            ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(18),
              itemCount: stations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final s = stations[i];
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => StationDetailScreen(stationName: '${s.name} İstasyonu', lineCode: s.lineCode)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(color: MpColors.lightBlueBg, borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(s.lineCode, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: MpColors.citizenBlueDark)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${s.name} İstasyonu', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5, color: MpColors.textDark)),
                              const SizedBox(height: 2),
                              Text('${s.lineCode} Hattı', style: const TextStyle(fontSize: 12, color: MpColors.textMuted)),
                            ],
                          ),
                        ),
                        if (s.faultCount > 0)
                          MpBadge(text: '${s.faultCount} arıza', fg: MpColors.redDark, bg: MpColors.redBg)
                        else
                          const MpBadge(text: 'Sorunsuz', fg: MpColors.greenDark, bg: MpColors.greenBg),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right, color: MpColors.textFaint, size: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
