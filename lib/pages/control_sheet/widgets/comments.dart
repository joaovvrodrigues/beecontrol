import 'package:beecontrol/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CommentsCard extends StatelessWidget {
  const CommentsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Observações:'),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Observações',
                  suffixIcon: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.dandelion,
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(
                        Ionicons.create_outline,
                        size: 20,
                        color: AppTheme.eclipse,
                      ))),
            )
          ],
        ));
  }
}
