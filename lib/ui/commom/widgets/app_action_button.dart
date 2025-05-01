import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';

class AppActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isPrimary;
  final Color? backgroundColor;
  final Color? textColor;

  const AppActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.isPrimary = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon:
          isLoading
              ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                child: CircularProgressIndicator(
                  color: isPrimary ? Colors.white : AppColors.primary,
                  strokeWidth: 3,
                ),
              )
              : Icon(icon),
      label: Text(isLoading ? 'Aguarde...' : label),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ??
            (isPrimary ? AppColors.primary : Colors.transparent),
        foregroundColor:
            textColor ?? (isPrimary ? AppColors.textLight : AppColors.primary),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingL,
          vertical: AppDimensions.spacingM,
        ),
        elevation: isPrimary ? AppDimensions.elevationS : 0,
      ),
    );
  }

  // Botao de texto
  factory AppActionButton.secondary({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return AppActionButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      isLoading: isLoading,
      isPrimary: false,
    );
  }

  // Botão de sucesso
  factory AppActionButton.success({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return AppActionButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: AppColors.success,
      textColor: AppColors.textLight,
    );
  }

  // Botão de aviso
  factory AppActionButton.warning({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return AppActionButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: AppColors.warning,
      textColor: AppColors.textLight,
    );
  }

  // Botão de erro
  factory AppActionButton.error({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return AppActionButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: AppColors.error,
      textColor: AppColors.textLight,
    );
  }
}
