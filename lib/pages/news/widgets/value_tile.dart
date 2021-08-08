import 'package:beecontrol/core/app_text_style.dart';
import 'package:flutter/material.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [iconData]
/// third row displays [value]
class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? iconData;

  ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Text(
            this.label,
          ),
        ),
        SizedBox(height: 5),
        this.iconData != null
            ? Flexible(
                child: Icon(
                iconData,
                size: 20,
              ))
            : SizedBox(),
        SizedBox(height: 10),
        Flexible(
            child: Text(
          this.value,
          style: AppTextStyle.boldText,
        )),
      ],
    );
  }
}
