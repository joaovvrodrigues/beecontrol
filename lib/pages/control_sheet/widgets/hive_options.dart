import 'package:flutter/material.dart';

import 'package:beecontrol/core/app_theme.dart';

class HiveOptions extends StatelessWidget {
  const HiveOptions({
    Key? key,
    required this.item,
  }) : super(key: key);
  final String item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.5),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.eclipse.withAlpha(180)),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6),
        child: Text(item),
      ),
    );
  }
}
