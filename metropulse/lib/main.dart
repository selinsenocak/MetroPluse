import 'package:flutter/material.dart';

import 'screens/panel_select_screen.dart';
import 'theme/app_theme.dart';

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
      theme: AppTheme.light(),
      home: const PanelSelectScreen(),
    );
  }
}
