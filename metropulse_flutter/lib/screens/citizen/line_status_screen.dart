import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../data/metro_lines.dart';
import '../../data/station_mock_data.dart';
import 'station_list_screen.dart';

/// The bottom nav's "Hizmet Durumu" tab: every Metro İstanbul line, with a
/// filter for the ones currently reporting a fault. Tapping a line drills
/// into its stations (station_list_screen.dart, filtered to that line).
class LineStatusScreen extends StatefulWidget {
  const LineStatusScreen({super.key});

  @override
  State<LineStatusScreen> createState() => _LineStatusScreenState();
}

class _LineStatusScreenState extends State<LineStatusScreen> {
  bool _onlyFaulty = false;

  @override
  Widget build(BuildContext context) {
    final rows = metroLines
        .map((l) => (line: l, faults: lineAffectedStationCount(l.code, l.stations)))
        .where((r) => !_onlyFaulty || r.faults > 0)
        .toList();

    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'Hizmet Durumu'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Metro İstanbul\'daki tüm hatların anlık durumu.',
                    style: const TextStyle(fontSize: 12.5, color: MpColors.textMuted),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
            child: Row(
              children: [
                _filterChip('Tümü', active: !_onlyFaulty, onTap: () => setState(() => _onlyFaulty = false)),
                const SizedBox(width: 8),
                _filterChip('Arızalı Hatlar', active: _onlyFaulty, onTap: () => setState(() => _onlyFaulty = true)),
              ],
            ),
          ),
          Expanded(
            child: rows.isEmpty
                ? const Center(
                    child: Text('Şu anda arızalı hat bulunmuyor.', style: TextStyle(color: MpColors.textMuted, fontSize: 13)),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                    itemCount: rows.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final r = rows[i];
                      final hasFault = r.faults > 0;
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => StationListScreen(
                              showBackButton: true,
                              lineCode: r.line.code,
                              lineRouteName: r.line.routeName,
                            ),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: hasFault ? const Color(0xFFF2AFB6) : MpColors.border),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: hasFault ? MpColors.redBg : MpColors.greenBg,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(r.line.code, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: hasFault ? MpColors.redDark : MpColors.greenDark)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(r.line.routeName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: MpColors.textDark)),
                                    const SizedBox(height: 2),
                                    Text('${r.line.stations.length} istasyon', style: const TextStyle(fontSize: 11.5, color: MpColors.textMuted)),
                                  ],
                                ),
                              ),
                              if (hasFault)
                                MpBadge(text: '${r.faults} istasyonda arıza', fg: MpColors.redDark, bg: MpColors.redBg)
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

  Widget _filterChip(String label, {required bool active, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: active ? MpColors.navy : Colors.white,
          border: active ? null : Border.all(color: MpColors.border),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: active ? Colors.white : MpColors.textDark)),
      ),
    );
  }
}
