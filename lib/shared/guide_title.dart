import '../core/app_text_style.dart';
import '../core/app_theme.dart';
import 'package:flutter/material.dart';

class GuideTitle extends StatelessWidget {
  const GuideTitle({Key? key, required this.icon, required this.title})
      : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, size: 15, color: AppTheme.eclipse),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: AppTextStyle.boldText,
          ),
        ),
      ],
    );
  }
}
