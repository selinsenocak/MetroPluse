import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';
import '../data/mock_users.dart';
import '../state/auth_store.dart';
import 'citizen/citizen_shell.dart';

/// The single sign-up screen — registers with either an email or a phone
/// number. New accounts are always citizens (Vatandaş Paneli); staff
/// accounts are provisioned separately and log in with their own demo
/// credentials on the Giriş Ekranı.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    final id = _idController.text.trim();
    final pass = _passController.text.trim();
    if (name.isEmpty || id.isEmpty || pass.isEmpty) {
      setState(() => _error = 'Lütfen tüm alanları doldurun.');
      return;
    }
    setState(() => _error = null);

    // No real backend for this prototype — signing up logs the citizen
    // straight in with the details just entered.
    AuthStore.instance.login(MockUser(name: name, identifiers: [id], password: pass, role: UserRole.citizen));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const CitizenShell()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'Kayıt Ol', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        children: [
          const Text('Hesap Oluştur', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: MpColors.textDark)),
          const SizedBox(height: 6),
          const Text('E-posta veya telefon numaranızla vatandaş hesabı oluşturun.',
              style: TextStyle(fontSize: 12.5, color: MpColors.textMuted, height: 1.4)),
          const SizedBox(height: 24),
          MpFieldText(label: 'Ad Soyad', hint: 'Adınız Soyadınız', controller: _nameController),
          const SizedBox(height: 16),
          MpFieldText(label: 'E-posta veya Telefon Numarası', hint: 'ornek@eposta.com veya 0555 555 55 55', controller: _idController),
          const SizedBox(height: 16),
          const Text('Şifre', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textDark)),
          const SizedBox(height: 6),
          TextField(
            controller: _passController,
            obscureText: _obscure,
            style: const TextStyle(fontSize: 13.5, color: MpColors.textDark),
            decoration: InputDecoration(
              hintText: 'En az 4 karakter',
              hintStyle: const TextStyle(color: MpColors.textFaint, fontSize: 13.5),
              suffixIcon: IconButton(
                icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 18, color: MpColors.textFaint),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
              filled: true,
              fillColor: MpColors.cardBg,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.border)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.border)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.citizenBlue)),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 10),
            Text(_error!, style: const TextStyle(color: MpColors.red, fontSize: 12.5, fontWeight: FontWeight.w600)),
          ],
          const SizedBox(height: 24),
          MpPrimaryButton(label: 'Kayıt Ol', color: MpColors.citizenBlue, icon: Icons.check, onTap: _submit),
          const SizedBox(height: 14),
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Zaten hesabınız var mı? Giriş Yap', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: MpColors.citizenBlue)),
            ),
          ),
        ],
      ),
    );
  }
}
