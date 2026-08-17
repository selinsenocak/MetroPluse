import 'package:flutter/material.dart';

/// MetroPulse renk tokenleri.
///
/// Kaynak: designn.md — 6 ana renk (fault, active, brand, work, info,
/// station) ve bunlardan türetilmiş 30 ara renk. Ara renkler İstanbul Metro
/// hat renklerinden türetilmiştir; bu dosya yalnızca token değerlerini taşır,
/// türetim formülleri designn.md'de belgelenmiştir.
class AppColors {
  AppColors._();

  // Ana renkler
  static const fault = Color(0xFFD32F2F);
  static const active = Color(0xFF2E7D32);
  static const brand = Color(0xFF1A365D);
  static const work = Color(0xFFF57C00);
  static const info = Color(0xFF0288D1);
  static const station = Color(0xFFF4F6F8);

  // fault ailesi
  static const faultSurface = Color(0xFFFBEAEA);
  static const faultSoft = Color(0xFFF9C9CB);
  static const faultStrong = Color(0xFFE0282C);
  static const faultAccent = Color(0xFFDA2948);
  static const faultDeep = Color(0xFF891F1F);

  // active/ok ailesi
  static const okSurface = Color(0xFFE6EFE6);
  static const okSoft = Color(0xFFC1DCBF);
  static const okStrong = Color(0xFF1A8C40);
  static const okMuted = Color(0xFF4B8B53);
  static const okDeep = Color(0xFF1E5120);

  // brand ailesi
  static const brandSurface = Color(0xFFE8EBEF);
  static const brandSoft = Color(0xFFB1C1D6);
  static const brandRail = Color(0xFF0D4072);
  static const brandAccent = Color(0xFF353460);
  static const brandDeep = Color(0xFF102038);

  // work ailesi
  static const workSurface = Color(0xFFFEEFE0);
  static const workAmber = Color(0xFFF8A206);
  static const workStrong = Color(0xFFFA7D21);
  static const workPlan = Color(0xFFE19136);
  static const workDeep = Color(0xFFA25900);

  // info ailesi
  static const infoSurface = Color(0xFFE6F3FA);
  static const infoSoft = Color(0xFF9CD5EF);
  static const infoStrong = Color(0xFF0797D8);
  static const infoScan = Color(0xFF2282C9);
  static const infoDeep = Color(0xFF0166A8);

  // station/nötr ailesi
  static const surfaceRaised = Color(0xFFFBFBFC);
  static const border = Color(0xFFD5DBE2);
  static const platform = Color(0xFFD9D9D5);
  static const textSecondary = Color(0xFF5B708C);
  static const textPrimary = Color(0xFF30496C);
}
