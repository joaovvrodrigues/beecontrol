import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/pages/apiary_options/edit_apiary.dart';
import 'package:beecontrol/pages/apiary_report/widgets/last_visit.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:beecontrol/shared/total_widget.dart';

class SummaryApiaryCard extends StatelessWidget {
  const SummaryApiaryCard({
    Key? key,
    required this.apiary,
  }) : super(key: key);
  final Apiary apiary;
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
                          apiary.image ??
                          'https://thumbs.dreamstime.com/b/hives-bees-apiaries-outskirts-forest-hives-bees-apiaries-outskirts-forest-126420117.jpg',
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                      // alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(apiary.name,
                            style: AppTextStyle.boldTitle),
                        Text('${apiary.city}, ${apiary.uf}',
                            style: AppTextStyle.boldTitle.copyWith(
                                fontSize: 16,
                                color: AppTheme.eclipse.withAlpha(80))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CircularButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditApiaryPage()));
                      },
                      icon: Icons.mode_edit_outline_rounded),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalWidget(
                    title: 'Colméias', amount: apiary.numHives, icon: FeatherIcons.package),
                TotalWidget(
                    title: 'Caixas Orfãs',
                    amount: apiary.orphanBoxes,
                    icon: Icons.safety_divider),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalWidget(
                    title: 'Visitas', amount: apiary.visits, icon: Ionicons.walk_outline),
                LastVisit(lastDate: apiary.lastVisit)
              ],
            ),
          ],
        ));
  }
}
