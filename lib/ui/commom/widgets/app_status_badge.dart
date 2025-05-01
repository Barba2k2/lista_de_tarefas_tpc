import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_text_styles.dart';

class AppStatusBadge extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData? activeIcon;
  final IconData? inactiveIcon;

  const AppStatusBadge({
    super.key,
    required this.label,
    required this.isActive,
    this.activeIcon = Icons.check_circle,
    this.inactiveIcon = Icons.pending_actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingM,
        vertical: AppDimensions.spacingS,
      ),
      decoration: BoxDecoration(
        color: isActive ? AppColors.success : AppColors.warning,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? activeIcon : inactiveIcon,
            color: AppColors.textLight,
            size: AppDimensions.iconSizeM,
          ),
          const SizedBox(width: AppDimensions.spacingS),
          Text(
            label,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
