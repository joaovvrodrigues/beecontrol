// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:brasil_fields/brasil_fields.dart';
import 'package:ionicons/ionicons.dart';

// 🌎 Project imports:
import '../../../core/app_text_style.dart';
import '../../../core/app_theme.dart';
import '../../../models/report.dart';

class ReportsCard extends StatelessWidget {
  const ReportsCard({
    Key? key,
    required this.report,
    required this.onTap,
  }) : super(key: key);
  final Report report;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        // context.read<Report>().updateProvider(report);
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                        color: AppTheme.seashell,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Ionicons.document_outline),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Ionicons.chevron_forward_outline,
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
                        const Text('Resumo: '),
                        Text(report.resume
                            .toString()
                            .replaceAll(RegExp(r"[\[\]']"), '')),
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
