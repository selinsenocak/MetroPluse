import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import 'device_info_screen.dart';

/// "Manuel Giriş" flow — lets the citizen type a 6-digit device ID
/// instead of scanning a QR code.
class ManualDeviceEntryScreen extends StatefulWidget {
  const ManualDeviceEntryScreen({super.key});

  @override
  State<ManualDeviceEntryScreen> createState() => _ManualDeviceEntryScreenState();
}

class _ManualDeviceEntryScreenState extends State<ManualDeviceEntryScreen> {
  static const _digitCount = 6;
  final _controllers = List.generate(_digitCount, (_) => TextEditingController());
  final _focusNodes = List.generate(_digitCount, (_) => FocusNode());
  String? _error;

  bool get _isComplete => _controllers.every((c) => c.text.trim().isNotEmpty);

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < _digitCount - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() => _error = null);
  }

  void _submit() {
    if (!_isComplete) {
      setState(() => _error = 'Lütfen 6 haneli cihaz ID\'sini eksiksiz giriniz.');
      return;
    }
    final enteredId = _controllers.map((c) => c.text.trim()).join();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => DeviceInfoScreen(deviceId: enteredId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'Manuel Giriş', showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(color: MpColors.lightBlueBg, shape: BoxShape.circle),
                child: const Icon(Icons.pin_outlined, color: MpColors.citizenBlue, size: 26),
              ),
              const SizedBox(height: 18),
              const Text('Cihaz ID Girin',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: MpColors.textDark)),
              const SizedBox(height: 8),
              const Text(
                'Cihaz etiketinde yazan 6 haneli kimlik numarasını girin.',
                style: TextStyle(fontSize: 13, color: MpColors.textMuted, height: 1.4),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_digitCount, (i) => _DigitBox(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      autofocus: i == 0,
                      onChanged: (v) => _onChanged(i, v),
                      onSubmit: _isComplete ? _submit : null,
                    )),
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!, style: const TextStyle(color: MpColors.red, fontSize: 12.5, fontWeight: FontWeight.w600)),
              ],
              const SizedBox(height: 32),
              MpPrimaryButton(
                label: 'Devam Et',
                icon: Icons.arrow_forward,
                onTap: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DigitBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmit;

  const _DigitBox({
    required this.controller,
    required this.focusNode,
    required this.autofocus,
    required this.onChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 54,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: MpColors.textDark),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: MpColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: MpColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: MpColors.citizenBlue, width: 1.6),
          ),
        ),
        onChanged: onChanged,
        onSubmitted: (_) => onSubmit?.call(),
      ),
    );
  }
}
