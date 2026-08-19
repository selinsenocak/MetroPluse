import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'fault_history_screen.dart';
import 'maintenance_plan_screen.dart';
import 'lost_item_form_screen.dart';
import 'teknik_account_screen.dart';

class TeknikShell extends StatefulWidget {
  const TeknikShell({super.key});

  @override
  State<TeknikShell> createState() => _TeknikShellState();
}

class _TeknikShellState extends State<TeknikShell> {
  int _index = 0;

  static const _tabs = [
    FaultHistoryScreen(),
    MaintenancePlanScreen(),
    LostItemFormScreen(),
    TeknikAccountScreen(),
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
        selectedItemColor: MpColors.teknikBlue,
        unselectedItemColor: MpColors.textFaint,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: 'Arıza Geçmişi'),
          BottomNavigationBarItem(icon: Icon(Icons.build_outlined), label: 'Bakım Planı'),
          BottomNavigationBarItem(icon: Icon(Icons.backpack_outlined), label: 'Kayıp Eşya'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Hesabım'),
        ],
      ),
    );
  }
}
