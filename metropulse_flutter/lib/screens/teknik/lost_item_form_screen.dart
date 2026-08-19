import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../data/metro_lines.dart';
import 'lost_item_form_submitted_screen.dart';

/// Filled out by the Gar Ekibi (yard team) while doing the interior check
/// of vehicles arriving at the depot, for anything left behind on board.
class LostItemFormScreen extends StatefulWidget {
  const LostItemFormScreen({super.key});

  @override
  State<LostItemFormScreen> createState() => _LostItemFormScreenState();
}

class _LostItemFormScreenState extends State<LostItemFormScreen> {
  final _metroIdController = TextEditingController();
  final _descController = TextEditingController();
  MetroLine? _line;
  TimeOfDay? _foundAt;
  bool _hasPhoto = false;

  @override
  void dispose() {
    _metroIdController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickLine() async {
    final line = await showModalBottomSheet<MetroLine>(
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
    if (line != null) setState(() => _line = line);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _foundAt ?? TimeOfDay.now(),
      helpText: 'Bulunma Saati',
      cancelText: 'Vazgeç',
      confirmText: 'Tamam',
    );
    if (time != null) setState(() => _foundAt = time);
  }

  void _togglePhoto() => setState(() => _hasPhoto = !_hasPhoto);

  void _submit() {
    if (_line == null || _foundAt == null || _descController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen zorunlu alanları (*) doldurun.')),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LostItemFormSubmittedScreen(lineCode: _line!.code, itemDesc: _descController.text.trim()),
      ),
    );
  }

  String _formatTime(TimeOfDay t) {
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'MetroPulse', background: MpColors.teknikBlue),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        children: [
          const Text('Kayıp Eşya Kayıt Formu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: MpColors.textDark)),
          const SizedBox(height: 6),
          const Text('Gar dönüşü araç iç kontrolünde bulunan eşyaları buradan kayıt altına alın.',
              style: TextStyle(fontSize: 12.5, color: MpColors.textMuted, height: 1.4)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [
                  Text('Hat Seçimi', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textDark)),
                  Text(' *', style: TextStyle(color: MpColors.red, fontWeight: FontWeight.w700)),
                ]),
                const SizedBox(height: 6),
                _selectField(hint: 'Hattı seçiniz...', value: _line?.label, onTap: _pickLine),
                const SizedBox(height: 14),
                Row(children: const [
                  Text('Bulunma Saati', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textDark)),
                  Text(' *', style: TextStyle(color: MpColors.red, fontWeight: FontWeight.w700)),
                ]),
                const SizedBox(height: 6),
                InkWell(
                  onTap: _pickTime,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                    decoration: BoxDecoration(
                      color: MpColors.cardBg,
                      border: Border.all(color: _foundAt != null ? MpColors.teknikBlue : MpColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        _foundAt != null ? _formatTime(_foundAt!) : '--:-- --',
                        style: TextStyle(color: _foundAt != null ? MpColors.textDark : MpColors.textFaint, fontSize: 13.5, fontWeight: _foundAt != null ? FontWeight.w600 : FontWeight.w400),
                      ),
                      const Icon(Icons.access_time, size: 15, color: MpColors.textFaint),
                    ]),
                  ),
                ),
                const SizedBox(height: 14),
                MpFieldText(label: 'Metro ID / Araç Numarası', hint: 'Örn: 4022', controller: _metroIdController),
                const SizedBox(height: 14),
                MpFieldText(
                  label: 'Eşya Tanımı',
                  hint: 'Bulunan eşyanın kısa tanımını giriniz (Örn: Siyah deri cüzdan, içerisinde kimlik var)...',
                  required: true,
                  lines: 3,
                  controller: _descController,
                ),
                const SizedBox(height: 16),
                const Text('Fotoğraf Ekle', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textDark)),
                const SizedBox(height: 8),
                _hasPhoto ? _photoPreview() : _uploadBox(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          MpPrimaryButton(label: 'KAYDET', icon: Icons.check, color: MpColors.teknikBlue, onTap: _submit),
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
          border: Border.all(color: value != null ? MpColors.teknikBlue : MpColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                value ?? hint,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: value != null ? MpColors.textDark : MpColors.textFaint, fontSize: 13.5, fontWeight: value != null ? FontWeight.w600 : FontWeight.w400),
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: MpColors.borderSoft, width: 1.4)),
        child: const Column(
          children: [
            Icon(Icons.camera_alt_outlined, color: MpColors.textFaint, size: 22),
            SizedBox(height: 6),
            Text('Fotoğraf yüklemek için tıklayın', style: TextStyle(color: MpColors.textDark, fontWeight: FontWeight.w600, fontSize: 12.5)),
            SizedBox(height: 3),
            Text('PNG, JPG, GIF (Maks 10MB)', style: TextStyle(color: MpColors.textFaint, fontSize: 11.5)),
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
            child: const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.close, size: 18, color: MpColors.textFaint)),
          ),
        ],
      ),
    );
  }
}
