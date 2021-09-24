import '../../../models/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/app_images.dart';
import '../../../core/app_text_style.dart';
import '../../../shared/total_widget.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    Key? key,
    required this.summary,
  }) : super(key: key);

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(0),
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    AppImages.logo,
                    height: 50,
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('Resumo Geral', style: AppTextStyle.boldTitle),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalWidget(
                    title: 'Apiários',
                    amount: summary.numApiaries,
                    icon: Ionicons.ribbon_outline),
                TotalWidget(
                    title: 'Caixas Orfãs',
                    amount: summary.orphanBoxes,
                    icon: Icons.safety_divider),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalWidget(
                    title: 'Colméias',
                    amount: summary.numHives,
                    icon: FeatherIcons.package),
                TotalWidget(
                    title: 'Relatórios',
                    amount: summary.numReports,
                    icon: Ionicons.documents_outline),
              ],
            ),
          ],
        ));
  }
}
