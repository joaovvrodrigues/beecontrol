import 'package:flutter/material.dart';

import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/bee_hive.dart';
import 'package:beecontrol/shared/custom_checkboxtile.dart';

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
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ATENÇÃO',
                style: AppTextStyle.boldTitle,
              ),
              SizedBox(height: 10),
              Text(
                'Ao dividir sua colméia, uma colméia orfã será criada automaticamente!',
                textAlign: TextAlign.center,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomCheckBox(
                    value: count,
                    title: 'Marcar a nova colméia como orfã por 3 semanas',
                    dense: true,
                    contentPadding: EdgeInsets.all(0),
                    onChanged: (value) => setState(() {
                      count = value!;
                    }),
                  )),
              SizedBox(height: 10),
              Text(
                'Deseja dividir a ${widget.hive.name}?',
                style: AppTextStyle.boldText,
              ),
              SizedBox(height: 10),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('CANCELAR'),
                    style: AppTheme.elevatedButtonStyle.copyWith(
                      minimumSize:
                          MaterialStateProperty.all<Size?>(Size.fromHeight(40)),
                      padding: MaterialStateProperty.all<EdgeInsets?>(
                          EdgeInsets.symmetric(horizontal: 5)),
                      backgroundColor:
                          MaterialStateProperty.all<Color?>(AppTheme.sunset),
                    ),
                  )),
                  SizedBox(width: 16),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.divideHive(
                            int.parse(widget.hive.name.substring(7)),
                            count: count);
                        Navigator.of(context).pop(true);
                      },
                      child: Text('DIVIDIR'),
                      style: AppTheme.elevatedButtonStyle.copyWith(
                        minimumSize: MaterialStateProperty.all<Size?>(
                            Size.fromHeight(40)),
                        padding: MaterialStateProperty.all<EdgeInsets?>(
                            EdgeInsets.symmetric(horizontal: 5)),
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
      ),
    );
  }
}
