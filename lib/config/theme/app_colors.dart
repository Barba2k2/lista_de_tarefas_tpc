import 'package:flutter/material.dart';

class AppColors {
  
  // Cores principais
  static const Color primary = Color(0xFF3F51B5);
  static const Color primaryDark = Color(0xFF303F9F);
  static const Color primaryLight = Color(0xFFC5CAE9);
  static const Color accent = Color(0xFFFF4081);

  // Cores de texto
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);

  // Cores de fundo
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFFE0E0E0);

  // Cores de status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Cores para tarefas
  static const Color taskCompleted = Color(0xFFDCEDC8);
  static const Color taskPending = Color(0xFFFFF9C4);

  // Sombras
  static const Color shadow = Color(0x40000000);

  // Material color swatch
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF3F51B5,
    <int, Color>{
      50: Color(0xFFE8EAF6),
      100: Color(0xFFC5CAE9),
      200: Color(0xFF9FA8DA),
      300: Color(0xFF7986CB),
      400: Color(0xFF5C6BC0),
      500: Color(0xFF3F51B5),
      600: Color(0xFF3949AB),
      700: Color(0xFF303F9F),
      800: Color(0xFF283593),
      900: Color(0xFF1A237E),
    },
  );
}