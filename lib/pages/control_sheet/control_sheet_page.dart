import 'package:beecontrol/pages/control_sheet/widgets/goals_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';

import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/report.dart';
import 'package:beecontrol/pages/apiary_report/widgets/reports_card.dart';
import 'package:beecontrol/pages/apiary_report/widgets/summary_apiary_card.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:beecontrol/shared/empty_widget.dart';
import 'package:beecontrol/shared/info_card.dart';
import 'package:beecontrol/shared/order_by_widget.dart';

enum PastoApicola { polen, nectar, florada }

class ControlSheetPage extends StatefulWidget {
  const ControlSheetPage({
    Key? key,
    required this.apiary,
  }) : super(key: key);

  final Apiary apiary;

  @override
  _ControlSheetPageState createState() => _ControlSheetPageState();
}

class _ControlSheetPageState extends State<ControlSheetPage> {
  List sheets = [];
  final formKey = GlobalKey<FormState>();
  PastoApicola? _pastoApicola;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularButton(
                        onTap: () => Navigator.of(context).pop(),
                        icon: Ionicons.chevron_back_outline),
                    Text('Ficha de Controle 1', style: AppTextStyle.boldTitle),
                    SizedBox(width: 35)
                  ],
                )),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 8,
            backgroundColor: AppTheme.dandelion,
            child: Icon(
              FeatherIcons.plus,
              color: AppTheme.eclipse,
            ),
            onPressed: () {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: AnimationLimiter(
                    child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: [
                        GoalsApiaryCard(apiary: widget.apiary),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Pasto Apícula:'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: RadioListTile<PastoApicola>(
                                            title:
                                                const Text('Entrada de Pólen'),
                                            value: PastoApicola.polen,
                                            groupValue: _pastoApicola,
                                            contentPadding: EdgeInsets.all(0),
                                            onChanged: (PastoApicola? value) {
                                              setState(() {
                                                _pastoApicola = value;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<PastoApicola>(
                                            title:
                                                const Text('Entrada de Néctar'),
                                            value: PastoApicola.nectar,
                                            groupValue: _pastoApicola,
                                            contentPadding: EdgeInsets.all(0),
                                            onChanged: (PastoApicola? value) {
                                              setState(() {
                                                _pastoApicola = value;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<PastoApicola>(
                                            title: const Text('Florada'),
                                            contentPadding: EdgeInsets.all(0),
                                            value: PastoApicola.florada,
                                            groupValue: _pastoApicola,
                                            onChanged: (PastoApicola? value) {
                                              setState(() {
                                                _pastoApicola = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        OrderBy('Data (Decrescente)'),
                        if (sheets.isEmpty)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: EmptyWidget(
                                    icon: FeatherIcons.package,
                                    text: 'Sem colméias cadastradas'),
                              ),
                              InfoCard(
                                  title: 'CADASTRE SUAS COLMÉIAS',
                                  text:
                                      'Cadastre sua primeira colméia, adicione suas informações de manejo e controle seu apiário!')
                            ],
                          )
                        else
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: sheets.length,
                              itemBuilder: (context, index) {
                                return ReportsCard(report: sheets[index]);
                              })
                      ]),
                )),
              ))),
    );
  }
}
