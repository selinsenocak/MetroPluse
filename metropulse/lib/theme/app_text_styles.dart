import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// MetroPulse tipografi tokenleri (kaynak: designn.md).
///
/// Gövde/başlık ailesi Inter; `deviceId` cihaz/Metro ID ve QR sonuçları için
/// Roboto Mono kullanır (0/O, 1/l karışmasını önlemek amacıyla, designn.md
/// "Tipografi Kullanımı" bölümü).
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get h1 => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.28,
        color: AppColors.textPrimary,
      );

  static TextStyle get h2 => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: AppColors.textPrimary,
      );

  static TextStyle get h3 => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.35,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyLg => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.55,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMd => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySm => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: AppColors.textSecondary,
      );

  static TextStyle get labelStrong => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.textPrimary,
      );

  static TextStyle get labelCaps => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 0.88,
        color: AppColors.textPrimary,
      );

  static TextStyle get deviceId => GoogleFonts.robotoMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.28,
        color: AppColors.brand,
      );

  static TextStyle get lineBadge => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.0,
        letterSpacing: 0.24,
        color: AppColors.surfaceRaised,
      );
}
