import 'package:flutter/material.dart';

import '../core/app_text_style.dart';
import '../core/app_theme.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 80,
          color: AppTheme.eclipse.withAlpha(90),
        ),
        Text(
          text,
          style: AppTextStyle.boldTitleAlpha90,
        )
      ],
    );
  }
}
