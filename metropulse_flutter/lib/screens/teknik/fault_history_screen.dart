import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../widgets/export_dialog.dart';

class _FaultRow {
  final String no, status, priority;
  final Color statusFg, statusBg, priorityColor;
  const _FaultRow({
    required this.no,
    required this.status,
    required this.statusFg,
    required this.statusBg,
    required this.priority,
    required this.priorityColor,
  });
}

const _statusKinds = [
  ('BEKLEMEDE', MpColors.redDark, MpColors.redBg, 'Kritik', MpColors.red),
  ('İŞLEMDE', MpColors.orangeDark, MpColors.orangeBg, 'Yüksek', MpColors.orange),
  ('İNCELENİYOR', MpColors.citizenBlueDark, MpColors.lightBlueBg, 'Orta', MpColors.citizenBlue),
  ('ÇÖZÜLDÜ', MpColors.greenDark, MpColors.greenBg, 'Düşük', MpColors.textMuted),
];

/// The full 7-day fault log — every row is shown (no fake "1-5 of 142"
/// pagination), generated deterministically so the list is stable across
/// rebuilds within the same install.
List<_FaultRow> _generateRows() {
  final rnd = Random(7);
  return List.generate(142, (i) {
    final k = _statusKinds[rnd.nextInt(_statusKinds.length)];
    return _FaultRow(
      no: 'FR-${8902 - i}',
      status: k.$1,
      statusFg: k.$2,
      statusBg: k.$3,
      priority: k.$4,
      priorityColor: k.$5,
    );
  });
}

class FaultHistoryScreen extends StatelessWidget {
  const FaultHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rows = _generateRows();
    final kritikBekleyen = rows.where((r) => r.priority == 'Kritik' && r.status == 'BEKLEMEDE').length;
    final islemde = rows.where((r) => r.status == 'İŞLEMDE').length;
    final cozuldu = rows.where((r) => r.status == 'ÇÖZÜLDÜ').length;

    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: AppBar(
        backgroundColor: MpColors.teknikBlue,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(children: const [
          MpMark(size: 20),
          SizedBox(width: 8),
          Text('MetroPulse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
        ]),
        actions: [
          const Icon(Icons.search, color: Colors.white, size: 20),
          const SizedBox(width: 14),
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(right: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), shape: BoxShape.circle),
            child: const Text('OP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10.5)),
          ),
        ],
      ),
      // CustomScrollView + a Sliver for the (potentially long) row list —
      // header/stat content scrolls away with it, satisfying "sayfaya
      // sığmıyorsa ekran aşağıya kayabilir" for the full 142-row result set.
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Arıza Bildirim Geçmişi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: MpColors.textDark)),
                  const SizedBox(height: 4),
                  const Text('Altyapı ve araçlar için teknik operasyon kaydı.', style: TextStyle(fontSize: 12.5, color: MpColors.textMuted)),
                  const SizedBox(height: 14),
                  Row(children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showFilterSheet(context),
                        icon: const Icon(Icons.filter_list, size: 16, color: MpColors.textDark),
                        label: const Text('Filtrele', style: TextStyle(color: MpColors.textDark, fontWeight: FontWeight.w600, fontSize: 13)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: MpColors.border),
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => showCsvExportDialog(
                          context,
                          title: 'Arıza Geçmişini Dışa Aktar',
                          headers: const ['Takip No', 'Durum', 'Öncelik'],
                          rows: rows.map((r) => [r.no, r.status, r.priority]).toList(),
                        ),
                        icon: const Icon(Icons.file_download_outlined, size: 16),
                        label: const Text('Dışa Aktar', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MpColors.navy,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.6,
                    children: [
                      _StatBox(label: 'TOPLAM ARIZA (7G)', value: '${rows.length}', color: MpColors.textDark),
                      _StatBox(label: 'KRİTİK BEKLEYEN', value: '$kritikBekleyen', color: MpColors.red),
                      _StatBox(label: 'İŞLEMDE', value: '$islemde', color: MpColors.orange),
                      _StatBox(label: 'ÇÖZÜLDÜ (24S)', value: '$cozuldu', color: MpColors.green),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MpColors.border),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Row(children: const [
                      Expanded(flex: 4, child: Text('TAKİP NO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5))),
                      Expanded(flex: 5, child: Text('DURUM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5))),
                      Expanded(flex: 3, child: Text('ÖNCELİK', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5))),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            sliver: SliverList.builder(
              itemCount: rows.length,
              itemBuilder: (context, i) {
                final r = rows[i];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: const BorderSide(color: MpColors.border),
                      right: const BorderSide(color: MpColors.border),
                      bottom: BorderSide(color: MpColors.border, width: i == rows.length - 1 ? 1 : 0),
                      top: const BorderSide(color: MpColors.border),
                    ),
                    borderRadius: i == rows.length - 1 ? const BorderRadius.vertical(bottom: Radius.circular(12)) : BorderRadius.zero,
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 4, child: Text(r.no, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: MpColors.textDark))),
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MpBadge(text: r.status, fg: r.statusFg, bg: r.statusBg),
                        ),
                      ),
                      Expanded(flex: 3, child: Text(r.priority, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: r.priorityColor))),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
            sliver: SliverToBoxAdapter(
              child: Text('${rows.length} sonucun tamamı listeleniyor', style: const TextStyle(fontSize: 12, color: MpColors.textMuted)),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Duruma Göre Filtrele', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: MpColors.textDark)),
              ),
            ),
            for (final k in _statusKinds)
              ListTile(
                leading: MpBadge(text: k.$1, fg: k.$2, bg: k.$3),
                title: Text('Öncelik: ${k.$4}', style: const TextStyle(fontSize: 13, color: MpColors.textMuted)),
                onTap: () => Navigator.of(context).pop(),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.4)),
          const SizedBox(height: 3),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }
}
