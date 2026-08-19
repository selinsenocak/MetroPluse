import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';
import '../data/mock_users.dart';
import '../state/auth_store.dart';
import 'citizen/citizen_shell.dart';
import 'teknik/teknik_shell.dart';
import 'ibb/ibb_shell.dart';
import 'sign_up_screen.dart';

/// The single "Giriş Ekranı" for every role. Which panel opens depends
/// entirely on which demo account's credentials are entered — there's no
/// separate role picker or hidden staff menu anymore.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _idController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _submit() {
    final user = findMockUser(_idController.text, _passController.text);
    if (user == null) {
      setState(() => _error = 'Kullanıcı adı veya şifre hatalı.');
      return;
    }
    setState(() => _error = null);
    AuthStore.instance.login(user);

    final Widget destination = switch (user.role) {
      UserRole.citizen => const CitizenShell(),
      UserRole.teknik => const TeknikShell(),
      UserRole.ibb => const IbbShell(),
    };
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => destination));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
          children: [
            Center(child: Image.asset('assets/images/metro-istanbul-mark.png', width: 72, height: 72)),
            const SizedBox(height: 16),
            const Text('MetroPulse', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: MpColors.navy)),
            const SizedBox(height: 6),
            const Text('Devam etmek için giriş yapın.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.5, color: MpColors.textMuted)),
            const SizedBox(height: 28),
            const Text('E-POSTA VEYA TELEFON NUMARASI', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
            const SizedBox(height: 6),
            TextField(
              controller: _idController,
              style: const TextStyle(fontSize: 13.5, color: MpColors.textDark),
              decoration: InputDecoration(
                hintText: 'ornek@eposta.com veya 0555 555 55 55',
                hintStyle: const TextStyle(color: MpColors.textFaint, fontSize: 13),
                prefixIcon: const Icon(Icons.person_outline, size: 18, color: MpColors.textFaint),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.border)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.citizenBlue)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('ŞİFRE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
            const SizedBox(height: 6),
            TextField(
              controller: _passController,
              obscureText: _obscure,
              style: const TextStyle(fontSize: 13.5, color: MpColors.textDark),
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: const TextStyle(color: MpColors.textFaint, fontSize: 13.5),
                prefixIcon: const Icon(Icons.lock_outline, size: 18, color: MpColors.textFaint),
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 18, color: MpColors.textFaint),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.border)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MpColors.citizenBlue)),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Row(children: [
                const Icon(Icons.error_outline, size: 15, color: MpColors.red),
                const SizedBox(width: 6),
                Expanded(child: Text(_error!, style: const TextStyle(color: MpColors.red, fontSize: 12.5, fontWeight: FontWeight.w600))),
              ]),
            ],
            const SizedBox(height: 24),
            MpPrimaryButton(label: 'Giriş Yap', icon: Icons.arrow_forward, onTap: _submit),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hesabınız yok mu?', style: TextStyle(fontSize: 12.5, color: MpColors.textMuted)),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignUpScreen())),
                  child: const Text('Kayıt Ol', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: MpColors.citizenBlue)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(10)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DEMO HESAPLARI', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
                  SizedBox(height: 8),
                  _DemoAccountLine(label: 'Vatandaş', value: 'selin@gmail.com / 1234'),
                  SizedBox(height: 4),
                  _DemoAccountLine(label: 'Teknik Ekip', value: 'hasan@ibbteknik.com / 1234'),
                  SizedBox(height: 4),
                  _DemoAccountLine(label: 'İBB Personeli', value: 'elifbuyuk@ibbpersonel.com / 1234'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoAccountLine extends StatelessWidget {
  final String label, value;
  const _DemoAccountLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 84, child: Text(label, style: const TextStyle(fontSize: 11.5, color: MpColors.textMuted, fontWeight: FontWeight.w600))),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 11.5, color: MpColors.textDark, fontFamily: 'monospace'))),
      ],
    );
  }
}
