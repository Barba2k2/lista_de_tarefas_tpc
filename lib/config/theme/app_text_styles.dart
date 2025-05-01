import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {

  // Tamanhos de fonte
  static const double displayLarge = 28;
  static const double displayMedium = 24;
  static const double displaySmall = 20;
  static const double headlineLarge = 18;
  static const double headlineMedium = 16;
  static const double headlineSmall = 14;
  static const double bodyLarge = 16;
  static const double bodyMedium = 14;
  static const double bodySmall = 12;
  static const double labelLarge = 14;
  static const double labelMedium = 12;
  static const double labelSmall = 10;

  // Títulos
  static TextStyle get title => GoogleFonts.poppins(
    fontSize: displayMedium,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get subtitle => GoogleFonts.poppins(
    fontSize: headlineLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  // Corpo
  static TextStyle get body => GoogleFonts.roboto(
    fontSize: bodyMedium,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodySmallStyle => GoogleFonts.roboto(
    fontSize: bodySmall,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Tarefas
  static TextStyle get taskTitle => GoogleFonts.poppins(
    fontSize: headlineMedium,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get taskTitleCompleted => GoogleFonts.poppins(
    fontSize: headlineMedium,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    decoration: TextDecoration.lineThrough,
  );

  static TextStyle get taskDescription => GoogleFonts.roboto(
    fontSize: bodyMedium,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Botões
  static TextStyle get buttonText => GoogleFonts.poppins(
    fontSize: labelLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  // Inputs
  static TextStyle get inputText => GoogleFonts.roboto(
    fontSize: bodyMedium,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle get inputLabel => GoogleFonts.roboto(
    fontSize: labelMedium,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get inputError => GoogleFonts.roboto(
    fontSize: labelSmall,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
  );
}
