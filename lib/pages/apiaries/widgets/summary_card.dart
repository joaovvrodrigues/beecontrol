import 'package:beecontrol/core/app_images.dart';
import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/shared/total_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(0),
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('Resumo Geral', style: AppTextStyle.boldTitle),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalWidget(
                    title: 'Apiários',
                    amount: 0,
                    icon: Ionicons.ribbon_outline),
                TotalWidget(
                    title: 'Caixas Orfãs',
                    amount: 0,
                    icon: Icons.safety_divider),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalWidget(
                    title: 'Colméias', amount: 0, icon: FeatherIcons.package),
                TotalWidget(
                    title: 'Relatórios',
                    amount: 0,
                    icon: Ionicons.documents_outline
),
              ],
            ),
          ],
        ));
  }
}
