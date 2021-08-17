import 'package:flutter/material.dart';

import 'package:beecontrol/core/app_theme.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    Key? key,
    required this.value,
    required this.title,
    this.onChanged,
    this.dense,
    this.contentPadding,
  }) : super(key: key);
  final bool value;
  final String title;
  final void Function(bool? value)? onChanged;
  final bool? dense;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      checkColor: AppTheme.eclipse,
      dense: dense,
      contentPadding: contentPadding,
      controlAffinity: ListTileControlAffinity.leading,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
