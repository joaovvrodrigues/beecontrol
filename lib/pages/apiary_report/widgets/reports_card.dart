import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import 'package:beecontrol/models/report.dart';

class ReportsCard extends StatelessWidget {
  const ReportsCard({
    Key? key,
    required this.report,
  }) : super(key: key);
  final Report report;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                        color: AppTheme.seashell,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.inventory_outlined),
                    )),
                Expanded(
                  child: Text(
                    report.name,
                    style: AppTextStyle.boldText,
                  ),
                ),
                Text(
                  'Ver mais',
                  style: TextStyle(
                      color: AppTheme.eclipse.withAlpha(180), fontSize: 10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Data: ${UtilData.obterDataDDMMAAAA(report.date!)}'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text('Colméias: ${report.numHives}'),
                        ),
                        Text('Caixas Orfãs: ${report.orphanBoxes}'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Resumo:'),
                        Text(report.resume),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
