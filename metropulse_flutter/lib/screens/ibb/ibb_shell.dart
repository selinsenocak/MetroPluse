import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'dashboard_screen.dart';
import 'lost_item_list_screen.dart';

class IbbShell extends StatefulWidget {
  const IbbShell({super.key});

  @override
  State<IbbShell> createState() => _IbbShellState();
}

class _IbbShellState extends State<IbbShell> {
  int _index = 0;

  static const _tabs = [
    DashboardScreen(),
    LostItemListScreen(),
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
        selectedItemColor: MpColors.purple,
        unselectedItemColor: MpColors.textFaint,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.backpack_outlined), label: 'Kayıp Eşya'),
        ],
      ),
    );
  }
}
