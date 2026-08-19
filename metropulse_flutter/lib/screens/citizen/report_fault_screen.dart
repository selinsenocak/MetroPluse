import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import 'report_submitted_screen.dart';

const _faultTypes = [
  'Yürüyen Merdiven Arızası',
  'Asansör Arızası',
  'Turnike / Geçiş Arızası',
  'Aydınlatma Arızası',
  'Diğer',
];

class ReportFaultScreen extends StatefulWidget {
  /// Device ID carried over from the scan / manual-entry flow, if any.
  final String? deviceId;
  const ReportFaultScreen({super.key, this.deviceId});

  @override
  State<ReportFaultScreen> createState() => _ReportFaultScreenState();
}

class _ReportFaultScreenState extends State<ReportFaultScreen> {
  final _idController = TextEditingController();
  final _locationController = TextEditingController();
  final _descController = TextEditingController();
  String? _faultType;
  bool _hasPhoto = false;

  @override
  void initState() {
    super.initState();
    if (widget.deviceId != null) _idController.text = widget.deviceId!;
  }

  @override
  void dispose() {
    _idController.dispose();
    _locationController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickFaultType() async {
    final choice = await showModalBottomSheet<String>(
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
                child: Text('Arıza Tipi Seçin', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: MpColors.textDark)),
              ),
            ),
            for (final t in _faultTypes)
              ListTile(
                title: Text(t, style: const TextStyle(fontSize: 14.5, color: MpColors.textDark)),
                trailing: t == _faultType ? const Icon(Icons.check, color: MpColors.citizenBlue, size: 18) : null,
                onTap: () => Navigator.of(context).pop(t),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (choice != null) setState(() => _faultType = choice);
  }

  void _togglePhoto() => setState(() => _hasPhoto = !_hasPhoto);

  @override
  Widget build(BuildContext context) {
    final hasDeviceId = widget.deviceId != null;
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'Arıza Bildir', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
        children: [
          const _SectionTitle('Cihaz Bilgileri'),
          const SizedBox(height: 12),
          const Text('CİHAZ ID', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          if (hasDeviceId)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              decoration: BoxDecoration(color: MpColors.greenBg, border: Border.all(color: const Color(0xFFBFE0C8)), borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                const Icon(Icons.check_circle, size: 16, color: MpColors.greenDark),
                const SizedBox(width: 8),
                Text('# ${widget.deviceId}',
                    style: const TextStyle(fontFamily: 'monospace', color: MpColors.greenDark, fontWeight: FontWeight.w700, fontSize: 13.5)),
                const Spacer(),
                const Text('Otomatik alındı', style: TextStyle(fontSize: 11, color: MpColors.greenDark)),
              ]),
            )
          else
            TextField(
              controller: _idController,
              style: const TextStyle(fontSize: 13.5, color: MpColors.textDark),
              decoration: InputDecoration(
                hintText: 'ID Giriniz veya Okutunuz',
                hintStyle: const TextStyle(color: MpColors.textMuted, fontSize: 13.5),
                prefixIcon: const Icon(Icons.qr_code, size: 18, color: MpColors.textMuted),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 11),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.border)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.citizenBlue)),
              ),
            ),
          const SizedBox(height: 22),
          const _SectionTitle('Arıza Detayları'),
          const SizedBox(height: 12),
          const Text('ARIZA TİPİ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          InkWell(
            onTap: _pickFaultType,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _faultType != null ? MpColors.citizenBlue : MpColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _faultType ?? 'Lütfen seçiniz...',
                    style: TextStyle(color: _faultType != null ? MpColors.textDark : MpColors.textFaint, fontSize: 13.5, fontWeight: _faultType != null ? FontWeight.w600 : FontWeight.w400),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: MpColors.textFaint, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text('KONUM DETAYI (İSTASYON / KAT / ÇIKIŞ)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          MpFieldText(label: '', hint: 'Örn: Levent İstasyonu, -2. Kat, Plaza...', controller: _locationController),
          const SizedBox(height: 14),
          const Text('AÇIKLAMA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          MpFieldText(label: '', hint: 'Arıza durumunu kısaca açıklayınız...', lines: 3, controller: _descController),
          const SizedBox(height: 22),
          const _SectionTitle('Görsel Ek (Opsiyonel)'),
          const SizedBox(height: 12),
          _hasPhoto ? _photoPreview() : _uploadBox(),
          const SizedBox(height: 24),
          MpPrimaryButton(
            label: 'Bildirimi Gönder',
            icon: Icons.error_outline,
            color: MpColors.red,
            onTap: () {
              final id = hasDeviceId ? widget.deviceId! : _idController.text;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => ReportSubmittedScreen(deviceId: id.isEmpty ? null : id)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _uploadBox() {
    return InkWell(
      onTap: _togglePhoto,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 26),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MpColors.borderSoft, width: 1.4),
        ),
        child: const Column(
          children: [
            Icon(Icons.camera_alt_outlined, color: MpColors.textFaint, size: 24),
            SizedBox(height: 8),
            Text('Fotoğraf çek veya yükle', style: TextStyle(color: MpColors.textDark, fontWeight: FontWeight.w600, fontSize: 12.5)),
          ],
        ),
      ),
    );
  }

  Widget _photoPreview() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: MpColors.placeholderBox, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.image, color: Color(0xFF8B8B87), size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ariza_fotografi.jpg', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: MpColors.textDark)),
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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: MpColors.teknikBlue, width: 2))),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: MpColors.textDark)),
    );
  }
}
