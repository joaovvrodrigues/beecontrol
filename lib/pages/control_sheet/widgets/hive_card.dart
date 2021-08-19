import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/pages/control_sheet/widgets/hive_options.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

import 'package:beecontrol/models/hive.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HiveCard extends StatefulWidget {
  const HiveCard({
    Key? key,
    required this.hive,
  }) : super(key: key);
  final Hive hive;

  @override
  _HiveCardState createState() => _HiveCardState();
}

class _HiveCardState extends State<HiveCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                FeatherIcons.package,
                size: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    widget.hive.name,
                    style: AppTextStyle.boldText.copyWith(fontSize: 16),
                  ),
                ),
              ),
              if (widget.hive.orphan)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Orfã da Colméia ${widget.hive.motherHive}',
                        style: AppTextStyle.boldText.copyWith(fontSize: 16),
                      ),
                      Text(
                        timeago.format(widget.hive.dateOrphan!,
                            locale: 'pt_br'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Situação'),
                  ),
                  for (var item in widget.hive.situation)
                    HiveOptions(item: item),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        FeatherIcons.plus,
                        color: AppTheme.eclipse,
                      ),
                      style: AppTheme.elevatedButtonStyle.copyWith(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(162, 40)),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Produção'),
                  ),
                  for (var item in widget.hive.production)
                    HiveOptions(item: item),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        FeatherIcons.plus,
                        color: AppTheme.eclipse,
                      ),
                      style: AppTheme.elevatedButtonStyle.copyWith(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(162, 40)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
