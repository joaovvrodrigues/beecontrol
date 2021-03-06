// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../core/app_text_style.dart';
import '../core/app_theme.dart';

class TotalWidget extends StatelessWidget {
  final String title;
  final num amount;
  final IconData icon;

  const TotalWidget({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14, color: AppTheme.eclipse)),
                  Text(amount.toString(),
                      style: AppTextStyle.boldTitle.copyWith(fontSize: 24))
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: AppTheme.seashell,
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(icon),
                ))
          ],
        ),
      ),
    );
  }
}
