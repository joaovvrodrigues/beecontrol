import 'package:flutter/material.dart';

import '../core/app_text_style.dart';
import 'package:ionicons/ionicons.dart';

class OrderBy extends StatelessWidget {
  const OrderBy(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(child: Text(text, style: AppTextStyle.boldText)),
            Container(
              height: 25,
              width: 25,
              child: const Icon(Ionicons.chevron_down_outline),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 13,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
