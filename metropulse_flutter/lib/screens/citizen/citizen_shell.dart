import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'citizen_home_screen.dart';
import 'line_status_screen.dart';
import 'alerts_screen.dart';
import 'account_screen.dart';

class CitizenShell extends StatefulWidget {
  const CitizenShell({super.key});

  @override
  State<CitizenShell> createState() => _CitizenShellState();
}

class _CitizenShellState extends State<CitizenShell> {
  int _index = 0;

  static const _tabs = [
    CitizenHomeScreen(),
    LineStatusScreen(),
    AlertsScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: MpColors.navy,
        unselectedItemColor: MpColors.textFaint,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Giriş'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_subway_filled_outlined), label: 'Hizmet Durumu'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Bildirimler'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Hesabım'),
        ],
      ),
    );
  }
}
