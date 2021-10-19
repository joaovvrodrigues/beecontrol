// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../../core/app_text_style.dart';
import '../../../core/app_theme.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({
    Key? key,
  }) : super(key: key);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  bool count = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ATENÇÃO',
              style: AppTextStyle.boldTitle,
            ),
            const SizedBox(height: 10),
            Text(
              'Deseja remover esta colméia?',
              style: AppTextStyle.boldText.copyWith(fontSize: 18),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'NÃO',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: AppTheme.elevatedButtonStyle.copyWith(
                    minimumSize: MaterialStateProperty.all<Size?>(
                        const Size.fromHeight(40)),
                    padding: MaterialStateProperty.all<EdgeInsets?>(
                        const EdgeInsets.symmetric(horizontal: 5)),
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(Colors.green[200]),
                  ),
                )),
                const SizedBox(width: 16),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'SIM',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: AppTheme.elevatedButtonStyle.copyWith(
                      minimumSize: MaterialStateProperty.all<Size?>(
                          const Size.fromHeight(40)),
                      padding: MaterialStateProperty.all<EdgeInsets?>(
                          const EdgeInsets.symmetric(horizontal: 5)),
                      backgroundColor:
                          MaterialStateProperty.all<Color?>(AppTheme.sunset),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
