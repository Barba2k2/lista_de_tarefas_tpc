import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_text_styles.dart';

class AppInfoContainer extends StatelessWidget {
  final String label;
  final String content;
  final Color borderColor;
  final bool lineThrough;
  final TextStyle? labelStyle;
  final TextStyle? contentStyle;

  const AppInfoContainer({
    super.key,
    required this.label,
    required this.content,
    this.borderColor = AppColors.primary,
    this.lineThrough = false,
    this.labelStyle,
    this.contentStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              labelStyle ??
              AppTextStyles.subtitle.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppDimensions.spacingS),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Text(
            content,
            style:
                contentStyle ??
                AppTextStyles.title.copyWith(
                  fontSize: AppTextStyles.headlineLarge,
                  decoration: lineThrough ? TextDecoration.lineThrough : null,
                  color:
                      lineThrough
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                ),
          ),
        ),
      ],
    );
  }
}
