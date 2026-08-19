import 'dart:math';

/// Every screen that needs a station's "how many faults" figure calls this
/// same seeded function, so the number for e.g. "M2 - Yenikapı" always
/// matches everywhere it's shown (station list, line status, station
/// detail) instead of three screens independently guessing at random.
///
/// Real stations are fault-free the vast majority of the time, so only
/// ~12% of stations roll a fault at all — a flat 0-4 range made most
/// stations look broken, which read as unrealistic.
int stationFaultCount(String lineCode, String stationName) {
  final rnd = Random('$lineCode-$stationName'.hashCode);
  if (rnd.nextInt(100) >= 12) return 0;
  return 1 + rnd.nextInt(3);
}

bool lineHasFault(String lineCode, List<String> stations) {
  return stations.any((s) => stationFaultCount(lineCode, s) > 0);
}

/// How many of the line's stations currently have at least one fault —
/// a more realistic headline figure than summing every device fault on
/// the line, which tends to look alarmingly high on longer lines.
int lineAffectedStationCount(String lineCode, List<String> stations) {
  return stations.where((s) => stationFaultCount(lineCode, s) > 0).length;
}
