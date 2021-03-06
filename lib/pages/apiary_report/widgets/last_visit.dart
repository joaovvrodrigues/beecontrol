// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:brasil_fields/brasil_fields.dart';

// 🌎 Project imports:
import '../../../core/app_text_style.dart';
import '../../../core/app_theme.dart';

class LastVisit extends StatelessWidget {
  const LastVisit({
    Key? key,
    required this.lastDate,
  }) : super(key: key);
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Última visita',
                      style: TextStyle(fontSize: 14, color: AppTheme.eclipse)),
                  Text(
                      lastDate != null
                          ? UtilData.obterDataDDMMAAAA(lastDate!)
                          : '-- / -- / --',
                      style: AppTextStyle.boldTitle.copyWith(fontSize: 20))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
