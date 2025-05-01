import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';

class AppStatusSwitch extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final Function(bool) onChanged;
  final EdgeInsetsGeometry contentPadding;
  final bool enabled;

  const AppStatusSwitch({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.contentPadding = EdgeInsets.zero,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: AppTextStyles.subtitle.copyWith(
          fontSize: AppTextStyles.bodyLarge,
        ),
      ),
      subtitle:
          subtitle != null
              ? Text(subtitle!, style: AppTextStyles.bodySmallStyle)
              : null,
      value: value,
      activeColor: AppColors.success,
      contentPadding: contentPadding,
      onChanged: enabled ? onChanged : null,
    );
  }
}
