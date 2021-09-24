import 'package:flutter/material.dart';

import '../../../core/app_text_style.dart';
import '../../../core/app_theme.dart';
import '../../../models/bee_hive.dart';
import '../../../shared/custom_checkboxtile.dart';

class DivideDialog extends StatefulWidget {
  const DivideDialog({
    Key? key,
    required this.hive,
    required this.divideHive,
  }) : super(key: key);
  final BeeHive hive;
  final Function(num mother, {bool count}) divideHive;

  @override
  _DivideDialogState createState() => _DivideDialogState();
}

class _DivideDialogState extends State<DivideDialog> {
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
            const Text(
              'Ao dividir sua colméia, uma colméia orfã será criada automaticamente!',
              textAlign: TextAlign.center,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCheckBox(
                  value: count,
                  title: 'Marcar a nova colméia como orfã por 3 semanas',
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  onChanged: (value) => setState(() {
                    count = value!;
                  }),
                )),
            const SizedBox(height: 10),
            Text(
              'Deseja dividir a ${widget.hive.name}?',
              style: AppTextStyle.boldText,
            ),
            const SizedBox(height: 10),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('CANCELAR'),
                  style: AppTheme.elevatedButtonStyle.copyWith(
                    minimumSize:
                        MaterialStateProperty.all<Size?>(const Size.fromHeight(40)),
                    padding: MaterialStateProperty.all<EdgeInsets?>(
                        const EdgeInsets.symmetric(horizontal: 5)),
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(AppTheme.sunset),
                  ),
                )),
                const SizedBox(width: 16),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.divideHive(
                          int.parse(widget.hive.name.substring(7)),
                          count: count);
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('DIVIDIR'),
                    style: AppTheme.elevatedButtonStyle.copyWith(
                      minimumSize: MaterialStateProperty.all<Size?>(
                          const Size.fromHeight(40)),
                      padding: MaterialStateProperty.all<EdgeInsets?>(
                          const EdgeInsets.symmetric(horizontal: 5)),
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          Colors.green[200]),
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
