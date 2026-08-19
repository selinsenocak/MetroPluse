import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'device_info_screen.dart';
import 'manual_device_entry_screen.dart';

class QrScanScreen extends StatelessWidget {
  const QrScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071B3D),
      // A real AppBar (not a hand-rolled Container) so the status bar area
      // is respected automatically. This screen is now reached by pushing
      // from "Arıza Bildir", so a working back button belongs here.
      appBar: AppBar(
        backgroundColor: MpColors.navy,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Cihaz Tarama', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
      ),
      // SingleChildScrollView instead of a fixed-height Column: on shorter
      // screens the content now scrolls instead of overflowing.
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('QR Kodunu Çerçeveye Hizalayın',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 21)),
                    SizedBox(height: 8),
                    Text('Cihaz tanımlaması otomatik yapılacaktır',
                        style: TextStyle(color: Color(0xFF9FB1CC), fontSize: 13)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const DeviceInfoScreen()),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.qr_code_scanner, color: Colors.white24, size: 64),
                                  SizedBox(height: 10),
                                  Text('Taramayı başlatmak için dokunun',
                                      textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          _corner(Alignment.topLeft),
                          _corner(Alignment.topRight),
                          _corner(Alignment.bottomLeft),
                          _corner(Alignment.bottomRight),
                          Positioned.fill(
                            child: IgnorePointer(
                              child: Align(
                                alignment: const Alignment(0, -0.12),
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: ColoredBox(color: MpColors.red, child: const SizedBox(height: 2)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ScanAction(icon: Icons.flash_on, label: 'Flaş', onTap: () {}),
                    _ScanAction(
                      icon: Icons.keyboard_alt_outlined,
                      label: 'Manuel Giriş',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ManualDeviceEntryScreen()),
                      ),
                    ),
                  ],
                ),
              ),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _corner(Alignment alignment) {
    final isTop = alignment.y < 0;
    final isLeft = alignment.x < 0;
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            border: Border(
              top: isTop ? const BorderSide(color: MpColors.red, width: 3) : BorderSide.none,
              bottom: !isTop ? const BorderSide(color: MpColors.red, width: 3) : BorderSide.none,
              left: isLeft ? const BorderSide(color: MpColors.red, width: 3) : BorderSide.none,
              right: !isLeft ? const BorderSide(color: MpColors.red, width: 3) : BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ScanAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF33507A), width: 1.5)),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
