import 'package:flutter/material.dart';

import '../widgets/status_badge.dart';

/// intennt.md §6 durum makinesi: Aktif → Arızalı → Onarımda → Aktif.
enum DeviceLifecycleStatus { active, fault, repair }

extension DeviceLifecycleStatusBadge on DeviceLifecycleStatus {
  DeviceStatusBadge get badge => switch (this) {
        DeviceLifecycleStatus.active => DeviceStatusBadge.active,
        DeviceLifecycleStatus.fault => DeviceStatusBadge.fault,
        DeviceLifecycleStatus.repair => DeviceStatusBadge.repair,
      };
}

enum DeviceType {
  escalator('Yürüyen Merdiven', Icons.escalator_rounded),
  walkway('Yürüyen Bant', Icons.moving_rounded),
  elevator('Asansör', Icons.elevator_rounded);

  const DeviceType(this.label, this.icon);

  final String label;
  final IconData icon;
}

/// Modül 2 — Cihaz Durum Takibi (intennt.md §6) asgari veri seti.
class Device {
  const Device({
    required this.id,
    required this.type,
    required this.line,
    required this.lineColor,
    required this.station,
    required this.status,
    required this.lastMaintenance,
    this.lastFaultReason,
  });

  final String id;
  final DeviceType type;
  final String line;
  final Color lineColor;
  final String station;
  final DeviceLifecycleStatus status;
  final String lastMaintenance;
  final String? lastFaultReason;
}

/// Örnek/demo veri — gerçek veri kaynağı (backend/API) bu sürümde tanımlı
/// değil; UI'ı designn.md token'larıyla göstermek amaçlıdır.
const sampleDevices = <Device>[
  Device(
    id: 'M2-ESK-014',
    type: DeviceType.escalator,
    line: 'M2',
    lineColor: Color(0xFF059A4D),
    station: 'Taksim',
    status: DeviceLifecycleStatus.fault,
    lastMaintenance: '02.07.2026',
    lastFaultReason: 'Basamak sensör arızası',
  ),
  Device(
    id: 'M4-ASN-007',
    type: DeviceType.elevator,
    line: 'M4',
    lineColor: Color(0xFFE81E77),
    station: 'Kadıköy',
    status: DeviceLifecycleStatus.repair,
    lastMaintenance: '28.06.2026',
    lastFaultReason: 'Kapı motoru değişimi',
  ),
  Device(
    id: 'M1A-BNT-002',
    type: DeviceType.walkway,
    line: 'M1A',
    lineColor: Color(0xFFEE2229),
    station: 'Yenikapı',
    status: DeviceLifecycleStatus.active,
    lastMaintenance: '10.08.2026',
  ),
  Device(
    id: 'T1-ASN-019',
    type: DeviceType.elevator,
    line: 'T1',
    lineColor: Color(0xFF004B86),
    station: 'Eminönü',
    status: DeviceLifecycleStatus.active,
    lastMaintenance: '05.08.2026',
  ),
];
