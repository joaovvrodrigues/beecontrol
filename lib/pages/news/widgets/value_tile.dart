// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../../core/app_text_style.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [iconData]
/// third row displays [value]
class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? iconData;

  const ValueTile(
    this.label,
    this.value, {
    Key? key,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Text(
            label,
          ),
        ),
        const SizedBox(height: 5),
        iconData != null
            ? Flexible(
                child: Icon(
                iconData,
                size: 20,
              ))
            : const SizedBox(),
        const SizedBox(height: 10),
        Flexible(
            child: Text(
          value,
          style: AppTextStyle.boldText,
        )),
      ],
    );
  }
}
