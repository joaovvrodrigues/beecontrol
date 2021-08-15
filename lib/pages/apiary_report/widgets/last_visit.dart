import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:flutter/material.dart';

class LastVisit extends StatelessWidget {
  const LastVisit({
    Key? key,
    this.lastDate,
  }) : super(key: key);
  final String? lastDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Última visita',
                      style: TextStyle(fontSize: 14, color: AppTheme.eclipse)),
                  Text(lastDate ?? '-- / -- / --',
                      style: AppTextStyle.boldTitle.copyWith(fontSize: 24))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
