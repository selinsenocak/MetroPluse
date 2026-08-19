import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/common.dart';
import '../../data/station_mock_data.dart';

class _MockDevice {
  final String code, type, loc, date;
  final bool active;
  final String? sub;
  const _MockDevice({required this.code, required this.type, required this.loc, required this.date, required this.active, this.sub});
}

const _deviceTypes = [
  ('Yürüyen Merdiven', 'ESC'),
  ('Asansör', 'LIF'),
  ('Turnike (Geçiş)', 'TRN'),
  ('Yürüyen Bant', 'BLT'),
];
const _exits = ['Kuzey Çıkışı', 'Güney Çıkışı', 'Doğu Çıkışı', 'Batı Çıkışı', 'Ana Giriş', 'Peron Girişi'];
const _details = ['Zemin Kat → B1', 'Engelli Erişimi', 'Gişe Yanı', 'Peron İniş', 'Bilet Turnikeleri', '-1. Kat Bağlantısı'];
const _months = ['Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'];

/// Every station gets a different, but stable, set of mock devices and
/// counts — seeded from the station's own name so the same station always
/// shows the same data across visits instead of one hardcoded example.
class _StationData {
  final int total, active, faulty;
  final int escalators, elevators, turnstiles;
  final List<_MockDevice> devices;
  const _StationData({
    required this.total,
    required this.active,
    required this.faulty,
    required this.escalators,
    required this.elevators,
    required this.turnstiles,
    required this.devices,
  });

  factory _StationData.generate(String lineCode, String stationName) {
    // Same fault figure the station list / line status screens show for
    // this station — generated once via the shared helper so numbers
    // never disagree between screens.
    final faulty = stationFaultCount(lineCode, stationName);
    // A separately-seeded Random (different seed string) for everything
    // else, so it doesn't consume from the same sequence as the call above.
    final rnd = Random('$lineCode-$stationName-inventory'.hashCode);
    final escalators = 4 + rnd.nextInt(10);
    final elevators = 2 + rnd.nextInt(6);
    final turnstiles = 6 + rnd.nextInt(16);
    final total = escalators + elevators + turnstiles;
    final active = total - faulty;

    final deviceCount = 3 + rnd.nextInt(3);
    final devices = List.generate(deviceCount, (i) {
      final t = _deviceTypes[rnd.nextInt(_deviceTypes.length)];
      final isActive = i >= faulty.clamp(0, deviceCount);
      final day = 1 + rnd.nextInt(28);
      final month = _months[rnd.nextInt(_months.length)];
      return _MockDevice(
        code: '${t.$2}-${(i + 1).toString().padLeft(2, '0')}',
        type: t.$1,
        loc: '${_exits[rnd.nextInt(_exits.length)]} - ${_details[rnd.nextInt(_details.length)]}',
        date: '$day $month 2023',
        active: isActive,
        sub: isActive ? null : 'Müdahale Bekliyor',
      );
    });

    return _StationData(
      total: total,
      active: active,
      faulty: faulty,
      escalators: escalators,
      elevators: elevators,
      turnstiles: turnstiles,
      devices: devices,
    );
  }
}

class StationDetailScreen extends StatelessWidget {
  final String stationName;
  final String lineCode;
  const StationDetailScreen({super.key, this.stationName = 'Yenikapı İstasyonu', this.lineCode = 'M2'});

  @override
  Widget build(BuildContext context) {
    final data = _StationData.generate(lineCode, stationName);

    return Scaffold(
      backgroundColor: MpColors.bg,
      appBar: const MpHeader(title: 'MetroPulse', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
        children: [
          Text('$lineCode HATTI > İSTASYON DETAYI', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
          const SizedBox(height: 4),
          Text(stationName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: MpColors.textDark)),
          const SizedBox(height: 4),
          const Text('İstasyon Cihaz ve Envanter Durumu', style: TextStyle(fontSize: 13, color: MpColors.textMuted)),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                _statCol('TOPLAM', '${data.total}', MpColors.textDark),
                _vDiv(),
                _statCol('AKTİF', '${data.active}', MpColors.green),
                _vDiv(),
                _statCol('ARIZALI', '${data.faulty}', MpColors.red),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _filterChip('Tümü', active: true),
              _filterChip('Yürüyen Merdiven (${data.escalators})'),
              _filterChip('Asansör (${data.elevators})'),
              _filterChip('Turnike (${data.turnstiles})'),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MpColors.border), borderRadius: BorderRadius.circular(8)),
            child: Row(children: const [
              Icon(Icons.search, size: 16, color: MpColors.textFaint),
              SizedBox(width: 8),
              Text('Cihaz kodu ara...', style: TextStyle(color: MpColors.textFaint, fontSize: 13)),
            ]),
          ),
          const SizedBox(height: 14),
          for (final d in data.devices) ...[
            _DeviceRow(code: d.code, type: d.type, loc: d.loc, date: d.date, active: d.active, sub: d.sub),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _statCol(String label, String value, Color color) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(children: [
            Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: MpColors.textMuted, letterSpacing: 0.5)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color)),
          ]),
        ),
      );

  Widget _vDiv() => Container(width: 1, height: 48, color: MpColors.border);

  Widget _filterChip(String label, {bool active = false}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? MpColors.navy : Colors.white,
          border: active ? null : Border.all(color: MpColors.border),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? Colors.white : MpColors.textDark)),
      );
}

class _DeviceRow extends StatelessWidget {
  final String code, type, loc, date;
  final bool active;
  final String? sub;
  const _DeviceRow({required this.code, required this.type, required this.loc, required this.date, required this.active, this.sub});

  @override
  Widget build(BuildContext context) {
    // BoxDecoration can't mix a borderRadius with non-uniform border side
    // colors, so the colored accent is drawn as a separate strip inside a
    // clipped row rather than as a differently-colored left BorderSide.
    return Container(
      decoration: BoxDecoration(
        color: active ? Colors.white : MpColors.redBg,
        border: Border.all(color: active ? MpColors.border : const Color(0xFFF2AFB6)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        // IntrinsicHeight gives the Row a bounded height to stretch to —
        // without it, a stretch-aligned Row inside a ListView item (whose
        // incoming height constraint is unbounded) throws "BoxConstraints
        // forces an infinite height".
        child: IntrinsicHeight(
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 3, color: active ? MpColors.green : MpColors.red),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(code, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: MpColors.textDark)),
                          const SizedBox(height: 2),
                          Text(type, style: const TextStyle(fontSize: 11.5, color: MpColors.textMuted)),
                          const SizedBox(height: 4),
                          Text(loc, style: const TextStyle(fontSize: 12, color: MpColors.textMuted)),
                          const SizedBox(height: 2),
                          Text(date, style: const TextStyle(fontSize: 11, color: MpColors.textFaint)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MpBadge(text: active ? 'Aktif' : 'Arızalı', fg: Colors.white, bg: active ? MpColors.green : MpColors.red),
                        if (sub != null) ...[
                          const SizedBox(height: 4),
                          Text(sub!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: MpColors.red)),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
