import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../data/metro_lines.dart';
import 'lost_item_submitted_screen.dart';

const _itemCategories = [
  'Çanta / Sırt Çantası',
  'Cüzdan / Kişisel Eşya',
  'Elektronik Cihaz',
  'Kıyafet / Aksesuar',
  'Belge / Evrak',
  'Diğer',
];

const _turkishMonths = [
  'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
  'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık',
];

String _formatDateTime(DateTime d) {
  final hh = d.hour.toString().padLeft(2, '0');
  final mm = d.minute.toString().padLeft(2, '0');
  return '${d.day} ${_turkishMonths[d.month - 1]} ${d.year}, $hh:$mm';
}

class LostItemEntryScreen extends StatefulWidget {
  const LostItemEntryScreen({super.key});

  @override
  State<LostItemEntryScreen> createState() => _LostItemEntryScreenState();
}

class _LostItemEntryScreenState extends State<LostItemEntryScreen> {
  String? _lineStation;
  DateTime? _foundAt;
  String? _category;
  bool _hasPhoto = false;

  Future<void> _pickFromList(String title, List<String> options, String? current, ValueChanged<String> onPicked) async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: MpColors.textDark)),
              ),
            ),
            for (final o in options)
              ListTile(
                title: Text(o, style: const TextStyle(fontSize: 14.5, color: MpColors.textDark)),
                trailing: o == current ? const Icon(Icons.check, color: MpColors.citizenBlue, size: 18) : null,
                onTap: () => Navigator.of(context).pop(o),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (choice != null) onPicked(choice);
  }

  /// Two-step picker: choose one of Metro İstanbul's lines, then one of
  /// that line's stations. Kept as two sheets rather than one long list so
  /// every line stays reachable without an unwieldy scroll.
  Future<void> _pickLineStation() async {
    final line = await showModalBottomSheet<MetroLine>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => SafeArea(
        child: DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Hat Seçin', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: MpColors.textDark)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: metroLines.length,
                  itemBuilder: (context, i) {
                    final l = metroLines[i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: MpColors.lightBlueBg,
                        child: Text(l.code, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: MpColors.citizenBlueDark)),
                      ),
                      title: Text(l.routeName, style: const TextStyle(fontSize: 14, color: MpColors.textDark, fontWeight: FontWeight.w600)),
                      onTap: () => Navigator.of(context).pop(l),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (line == null || !mounted) return;

    final station = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => SafeArea(
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${line.code} İstasyonları', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: MpColors.textDark)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: line.stations.length,
                  itemBuilder: (context, i) => ListTile(
                    title: Text(line.stations[i], style: const TextStyle(fontSize: 14, color: MpColors.textDark)),
                    onTap: () => Navigator.of(context).pop(line.stations[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (station != null) {
      setState(() => _lineStation = '${line.code} Hattı - $station İstasyonu');
    }
  }

  Future<void> _pickFoundAt() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _foundAt ?? now,
      firstDate: now.subtract(const Duration(days: 90)),
      lastDate: now,
      helpText: 'Bulunma Tarihi',
      cancelText: 'Vazgeç',
      confirmText: 'Devam',
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: _foundAt != null ? TimeOfDay.fromDateTime(_foundAt!) : TimeOfDay.now(),
      helpText: 'Bulunma Saati',
      cancelText: 'Vazgeç',
      confirmText: 'Tamam',
    );
    if (time == null) return;
    setState(() => _foundAt = DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  void _togglePhoto() => setState(() => _hasPhoto = !_hasPhoto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: AppBar(
        backgroundColor: MpColors.navy,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(children: const [
          MpMark(size: 20),
          SizedBox(width: 8),
          Text('MetroPulse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
        ]),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        children: [
          const Text('Kayıp Eşya Girişi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: MpColors.textDark)),
          const SizedBox(height: 4),
          const Text('Kaybettiğiniz eşyaya ait bilgileri girin, olası eşleşmeleri görün.',
              style: TextStyle(fontSize: 12.5, color: MpColors.textMuted, height: 1.4)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('BULUNMA DETAYLARI', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
                const SizedBox(height: 12),
                const Text('Hat / İstasyon Seçimi', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textDark)),
                const SizedBox(height: 6),
                _selectField(
                  hint: 'Hat ve istasyon seçiniz...',
                  value: _lineStation,
                  onTap: _pickLineStation,
                ),
                const SizedBox(height: 14),
                const Text('Bulunma Zamanı', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textDark)),
                const SizedBox(height: 6),
                InkWell(
                  onTap: _pickFoundAt,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                    decoration: BoxDecoration(
                      color: MpColors.cardBg,
                      border: Border.all(color: _foundAt != null ? MpColors.citizenBlue : MpColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _foundAt != null ? _formatDateTime(_foundAt!) : 'Tarih ve saat seçiniz...',
                          style: TextStyle(
                            color: _foundAt != null ? MpColors.textDark : MpColors.textFaint,
                            fontSize: 13.5,
                            fontWeight: _foundAt != null ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                        const Icon(Icons.calendar_today_outlined, size: 15, color: MpColors.textFaint),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text('EŞYA BİLGİLERİ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
                const SizedBox(height: 12),
                const Text('Eşya Kategorisi', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textDark)),
                const SizedBox(height: 6),
                _selectField(
                  hint: 'Kategori Seçin...',
                  value: _category,
                  onTap: () => _pickFromList('Eşya Kategorisi Seçin', _itemCategories, _category, (v) => setState(() => _category = v)),
                ),
                const SizedBox(height: 14),
                _hasPhoto ? _photoPreview() : _uploadBox(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          MpPrimaryButton(
            label: 'Sisteme Kaydet',
            color: MpColors.citizenBlue,
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => LostItemSubmittedScreen(category: _category)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectField({required String hint, required String? value, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: MpColors.cardBg,
          border: Border.all(color: value != null ? MpColors.citizenBlue : MpColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? hint,
              style: TextStyle(
                color: value != null ? MpColors.textDark : MpColors.textFaint,
                fontSize: 13.5,
                fontWeight: value != null ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: MpColors.textFaint, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _uploadBox() {
    return InkWell(
      onTap: _togglePhoto,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MpColors.borderSoft, width: 1.4),
        ),
        child: const Column(
          children: [
            Icon(Icons.camera_alt_outlined, color: MpColors.textFaint, size: 22),
            SizedBox(height: 6),
            Text('Fotoğraf çekmek veya yüklemek için tıklayın', textAlign: TextAlign.center, style: TextStyle(color: MpColors.textDark, fontWeight: FontWeight.w600, fontSize: 12.5)),
          ],
        ),
      ),
    );
  }

  Widget _photoPreview() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: MpColors.cardBg, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: MpColors.placeholderBox, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.image, color: Color(0xFF8B8B87), size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('esya_fotografi.jpg', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: MpColors.textDark)),
                SizedBox(height: 2),
                Text('Eklendi', style: TextStyle(fontSize: 11.5, color: MpColors.green, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          InkWell(
            onTap: _togglePhoto,
            borderRadius: BorderRadius.circular(999),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.close, size: 18, color: MpColors.textFaint),
            ),
          ),
        ],
      ),
    );
  }
}
