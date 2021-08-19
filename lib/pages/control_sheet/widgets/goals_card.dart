import 'package:beecontrol/shared/custom_checkboxtile.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/apiary.dart';

class GoalsApiaryCard extends StatefulWidget {
  const GoalsApiaryCard({
    Key? key,
    required this.apiary,
  }) : super(key: key);

  final Apiary apiary;

  static List<String> manejo = [
    'Alimentação',
    'Limpeza',
    'Colheita de Mel',
    'Colheita de Própolis',
    'Divisão de Enxame',
    'Instalar Suportes',
    'Outro'
  ];

  @override
  _GoalsApiaryCardState createState() => _GoalsApiaryCardState();
}

class _GoalsApiaryCardState extends State<GoalsApiaryCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(0),
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: expanded ? 600 : 220,
            curve: Curves.ease,
            child: ListView(
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.apiary.name,
                                style: AppTextStyle.boldTitle),
                            Text('${widget.apiary.city}, ${widget.apiary.uf}',
                                style: AppTextStyle.boldTitle.copyWith(
                                    fontSize: 16,
                                    color: AppTheme.eclipse.withAlpha(80))),
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         expanded = !expanded;
                    //       });
                    //     },
                    //     child: Text(expanded ? 'Encolher' : 'Expandir'),
                    //     style: AppTheme.elevatedButtonStyle.copyWith(
                    //       minimumSize:
                    //           MaterialStateProperty.all<Size?>(Size(100, 50)),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    child: Text(expanded ? 'Encolher' : 'Expandir'),
                    style: AppTheme.elevatedButtonStyle.copyWith(
                      minimumSize:
                          MaterialStateProperty.all<Size?>(Size(100, 50)),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(expanded
                            ? 'Objetivos do Manejo:'
                            : 'Clique expandir para editar objetivos do manejo'),
                      ),
                      Text('Data: 06/08/2021'),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 600),
                    child: expanded
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (String tipo in GoalsApiaryCard.manejo)
                                CustomCheckBox(
                                  value: true,
                                  title: tipo,
                                  onChanged: (bool) {},
                                ),
                            ],
                          )
                        : SizedBox()),
              ],
            )));
  }
}
