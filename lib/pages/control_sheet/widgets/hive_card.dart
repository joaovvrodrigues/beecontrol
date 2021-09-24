import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/app_text_style.dart';
import '../../../core/app_theme.dart';
import '../../../models/bee_hive.dart';
import 'hive_options.dart';
import '../../../shared/circular_button.dart';
import '../../../shared/custom_dropdown_field.dart';

import 'divide_dialog.dart';

class HiveCard extends StatefulWidget {
  const HiveCard(
      {Key? key,
      required this.hive,
      required this.divideHive,
      required this.readOnly})
      : super(key: key);
  final BeeHive hive;
  final Function(num mother, {bool count}) divideHive;
  final bool readOnly;

  @override
  _HiveCardState createState() => _HiveCardState();
}

class _HiveCardState extends State<HiveCard> {
  static final List<String> productionOptions = [
    'Liberar',
    'Dividir',
    'Alimentar',
    'Colher Mel',
    'Colher Própolis',
    'Colméia Poedeira',
    'Colocar Melgueira',
    'Ninho',
    'Instalar Suporte',
    'Limpar'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
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
                      if (widget.hive.count)
                        Text(
                          timeago.format(widget.hive.dateOrphan!,
                              locale: 'pt_br'),
                        ),
                    ],
                  ),
                ),
            ],
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Situação', style: AppTextStyle.boldText),
                  ),
                  if (widget.hive.situation.isNotEmpty)
                    for (var item in widget.hive.situation)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 50.0,
                                    minWidth: 450.0,
                                    maxHeight: 50.0,
                                    maxWidth: 450.0,
                                  ),
                                  child: HiveOptions(item: item))),
                        ],
                      )
                  else
                    const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
                        child: Text('Nenhum registro'))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Produção', style: AppTextStyle.boldText),
                  ),
                  if (widget.hive.production.isNotEmpty)
                    for (var i = 0; i < widget.hive.production.length; i++)
                      widget.readOnly
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Flexible(
                                      child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            minHeight: 50.0,
                                            minWidth: 450.0,
                                            maxHeight: 50.0,
                                            maxWidth: 450.0,
                                          ),
                                          child: HiveOptions(
                                              item: widget.hive.production[i])))
                                ])
                          : Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minHeight: 50.0,
                                        minWidth: 150.0,
                                        maxHeight: 50.0,
                                        maxWidth: 400.0,
                                      ),
                                      child: Container(
                                          height: 50,
                                          margin: const EdgeInsets.all(2.5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppTheme.eclipse
                                                      .withAlpha(100)),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: CustomDropDownField<String>(
                                            isDense: true,
                                            hintText: 'Opção',
                                            onSaved: (text) async {
                                              setState(() {
                                                widget.hive.production[i] =
                                                    text!;
                                              });
                                              if (text! == 'Dividir') {
                                                bool? divide = await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return DivideDialog(
                                                        hive: widget.hive,
                                                        divideHive:
                                                            widget.divideHive);
                                                  },
                                                );

                                                if (!(divide ?? true)) {
                                                  setState(() {
                                                    widget.hive.production[i] =
                                                        'null';
                                                  });
                                                }
                                              }
                                            },
                                            initialValue:
                                                widget.hive.production[i] ==
                                                        'null'
                                                    ? null
                                                    : widget.hive.production[i],
                                            // icon: Ionicons.business_outline,
                                            items: productionOptions
                                                .map((String uf) {
                                              return DropdownMenuItem(
                                                value: uf,
                                                child: Text(uf),
                                              );
                                            }).toList(),
                                          )),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  CircularButton(
                                      onTap: () {
                                        setState(() {
                                          widget.hive.production.removeAt(i);
                                        });
                                      },
                                      icon: Ionicons.close_outline,
                                      iconSize: 25),
                                ],
                              ),
                            )
                ],
              ),
            ],
          ),
          if (!widget.readOnly)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.hive.production.add('null');
                    });
                  },
                  child: const Icon(
                    FeatherIcons.plus,
                    color: AppTheme.eclipse,
                  ),
                  style: AppTheme.elevatedButtonStyle.copyWith(
                    minimumSize:
                        MaterialStateProperty.all<Size?>(const Size(162, 40)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
