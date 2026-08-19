import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MetroPulseApp());
}

class MetroPulseApp extends StatelessWidget {
  const MetroPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MetroPulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: MpColors.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: MpColors.navy),
        textTheme: const TextTheme().apply(
          bodyColor: MpColors.textDark,
          displayColor: MpColors.textDark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: MpColors.navy,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
