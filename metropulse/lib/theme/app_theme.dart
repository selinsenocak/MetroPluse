import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_text_styles.dart';

/// MetroPulse'un üç paneli. Panel ayrımı yalnızca başlık renginde yapılır —
/// token seti aynıdır (designn.md § Panel Ayrımı).
enum MetroPanel { citizen, ibb, technical }

extension MetroPanelStyle on MetroPanel {
  /// Panel AppBar / panel-header arkaplan rengi.
  Color get headerColor => switch (this) {
        MetroPanel.citizen => AppColors.brand,
        MetroPanel.ibb => AppColors.brandAccent,
        MetroPanel.technical => AppColors.brandRail,
      };

  String get label => switch (this) {
        MetroPanel.citizen => 'Vatandaş Paneli',
        MetroPanel.ibb => 'İBB Personeli Paneli',
        MetroPanel.technical => 'Teknik Ekip Paneli',
      };
}

/// Uygulama genel ThemeData'sı — designn.md token'larından üretilir.
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.brand,
      brightness: Brightness.light,
      primary: AppColors.brand,
      secondary: AppColors.info,
      error: AppColors.fault,
      surface: AppColors.surfaceRaised,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.station,
      splashFactory: InkRipple.splashFactory,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.brand,
        foregroundColor: AppColors.station,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.h3.copyWith(color: AppColors.station),
        iconTheme: const IconThemeData(color: AppColors.station),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surfaceRaised,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brand,
          foregroundColor: AppColors.station,
          minimumSize: const Size.fromHeight(48),
          textStyle: AppTextStyles.labelStrong.copyWith(color: AppColors.station),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.brandSurface,
          foregroundColor: AppColors.brand,
          minimumSize: const Size.fromHeight(48),
          side: BorderSide.none,
          textStyle: AppTextStyles.labelStrong.copyWith(color: AppColors.brand),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceRaised,
        hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.full),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.full),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.full),
          borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
        ),
      ),

      textTheme: TextTheme(
        headlineLarge: AppTextStyles.h1,
        headlineMedium: AppTextStyles.h2,
        headlineSmall: AppTextStyles.h3,
        bodyLarge: AppTextStyles.bodyLg,
        bodyMedium: AppTextStyles.bodyMd,
        bodySmall: AppTextStyles.bodySm,
        labelLarge: AppTextStyles.labelStrong,
        labelSmall: AppTextStyles.labelCaps,
      ),
    );
  }
}
