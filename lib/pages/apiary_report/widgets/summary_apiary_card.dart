import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/pages/apiary_report/widgets/last_visit.dart';
import 'package:beecontrol/shared/total_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:transparent_image/transparent_image.dart';

class SummaryApiaryCard extends StatelessWidget {
  const SummaryApiaryCard({Key? key}) : super(key: key);

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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          //  apiary.image ??
                          'https://thumbs.dreamstime.com/b/hives-bees-apiaries-outskirts-forest-hives-bees-apiaries-outskirts-forest-126420117.jpg',
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                      // alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Apiário Santa Clara',
                            style: AppTextStyle.boldTitle),
                        Text('Bambuí, MG',
                            style: AppTextStyle.boldTitle.copyWith(
                                fontSize: 16,
                                color: AppTheme.eclipse.withAlpha(80))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalWidget(
                    title: 'Colméias',
                    amount: 0,
                    icon: Ionicons.airplane_outline),
                TotalWidget(
                    title: 'Caixas Orfãs',
                    amount: 0,
                    icon: Icons.inventory_2_outlined),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalWidget(title: 'Visitas', amount: 0, icon: Icons.inventory),
                LastVisit(),
              ],
            ),
          ],
        ));
  }
}
