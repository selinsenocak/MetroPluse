import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';
import 'common.dart';

String _csvEscape(String v) {
  if (v.contains(',') || v.contains('"') || v.contains('\n')) {
    return '"${v.replaceAll('"', '""')}"';
  }
  return v;
}

String buildCsv(List<String> headers, List<List<String>> rows) {
  final buffer = StringBuffer();
  buffer.writeln(headers.map(_csvEscape).join(','));
  for (final row in rows) {
    buffer.writeln(row.map(_csvEscape).join(','));
  }
  return buffer.toString();
}

/// Shows the page's data as CSV (Excel-openable) so it can be copied out —
/// this prototype has no backend/file-system plugin to save a real .xlsx
/// to disk, so the export surfaces as a copyable, previewable CSV instead.
Future<void> showCsvExportDialog(
  BuildContext context, {
  required String title,
  required List<String> headers,
  required List<List<String>> rows,
}) async {
  final csv = buildCsv(headers, rows);
  await showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.grid_on, color: MpColors.green, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: MpColors.textDark))),
            ]),
            const SizedBox(height: 6),
            Text('${rows.length} satır Excel/CSV formatında hazırlandı.', style: const TextStyle(fontSize: 12.5, color: MpColors.textMuted)),
            const SizedBox(height: 14),
            Container(
              constraints: const BoxConstraints(maxHeight: 260),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: MpColors.cardBg, borderRadius: BorderRadius.circular(10), border: Border.all(color: MpColors.border)),
              child: SingleChildScrollView(
                child: SelectableText(csv, style: const TextStyle(fontFamily: 'monospace', fontSize: 11.5, color: MpColors.textDark, height: 1.5)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: MpSecondaryButton(
                    label: 'Kapat',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MpPrimaryButton(
                    label: 'Panoya Kopyala',
                    icon: Icons.copy_all_outlined,
                    color: MpColors.green,
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: csv));
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('CSV panoya kopyalandı — Excel\'e yapıştırabilirsiniz.')),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
