import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'login_screen.dart';

/// First screen the app shows: a subdued station photo behind the İBB /
/// Metro İstanbul lockup, fading and scaling in, then handing off to the
/// login screen after a fixed 3-second beat.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.86, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();

    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MpColors.navy,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background photo, dimmed down so the centered lockup reads clearly.
          Opacity(
            opacity: 0.34,
            child: Image.asset('assets/images/splash_background.png', fit: BoxFit.cover),
          ),
          Container(color: MpColors.navy.withValues(alpha: 0.55)),
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 28, offset: Offset(0, 12))],
                  ),
                  child: Image.asset('assets/images/ibb_metro_lockup.png', width: 240, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 56,
            child: FadeTransition(
              opacity: _fade,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white70),
                  ),
                  SizedBox(height: 14),
                  Text('MetroPulse yükleniyor...', style: TextStyle(color: Colors.white70, fontSize: 12.5, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
