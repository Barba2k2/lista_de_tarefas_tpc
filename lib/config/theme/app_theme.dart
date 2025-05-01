import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_text_styles.dart';

class AppTheme {
  // Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: AppColors.primarySwatch,
      textTheme: GoogleFonts.robotoTextTheme(),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.textLight,
        secondary: AppColors.accent,
        onSecondary: AppColors.textLight,
        error: AppColors.error,
        onError: AppColors.textLight,
        background: AppColors.background,
        onBackground: AppColors.textPrimary,
        surface: AppColors.backgroundLight,
        onSurface: AppColors.textPrimary,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: AppDimensions.elevationS,
        centerTitle: true,
        titleTextStyle: AppTextStyles.title.copyWith(
          color: AppColors.textLight,
          fontSize: AppTextStyles.headlineLarge,
        ),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      cardTheme: CardTheme(
        color: AppColors.background,
        elevation: AppDimensions.elevationS,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: AppDimensions.spacingS,
          horizontal: AppDimensions.spacingM,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingL,
            vertical: AppDimensions.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
          ),
          textStyle: AppTextStyles.buttonText,
          elevation: AppDimensions.elevationS,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingM,
            vertical: AppDimensions.spacingS,
          ),
          textStyle: AppTextStyles.buttonText.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.primary,
          backgroundColor: Colors.transparent,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.backgroundLight,
        filled: true,
        contentPadding: const EdgeInsets.all(AppDimensions.spacingM),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
          borderSide: const BorderSide(
            color: AppColors.backgroundDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppTextStyles.inputLabel,
        hintStyle: AppTextStyles.inputText.copyWith(
          color: AppColors.textSecondary.withOpacity(0.7),
        ),
        errorStyle: AppTextStyles.inputError,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.backgroundDark;
          }, //
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusS),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textLight,
        elevation: AppDimensions.elevationM,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.backgroundDark,
        thickness: 1,
        space: AppDimensions.spacingM,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.body.copyWith(
          color: AppColors.textLight,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
        ),
      ),
    );
  }
}
