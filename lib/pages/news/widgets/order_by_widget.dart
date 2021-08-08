import 'package:flutter/material.dart';

import 'package:beecontrol/core/app_text_style.dart';

class OrderBy extends StatelessWidget {
  const OrderBy(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Text(text, style: AppTextStyle.boldText),
            Container(
              height: 25,
              width: 25,
              margin: EdgeInsets.only(left: 5),
              child: Icon(Icons.arrow_drop_down_rounded),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 13,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
