import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/report.dart';
import 'package:beecontrol/pages/apiary_report/widgets/reports_card.dart';
import 'package:beecontrol/pages/apiary_report/widgets/summary_apiary_card.dart';
import 'package:beecontrol/pages/control_sheet/control_sheet_page.dart';
import 'package:beecontrol/shared/empty_widget.dart';
import 'package:beecontrol/shared/info_card.dart';
import 'package:beecontrol/shared/order_by_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:ionicons/ionicons.dart';

class ApiaryPage extends StatefulWidget {
  const ApiaryPage({
    Key? key,
    // required this.apiary,
  }) : super(key: key);
  // final Apiary apiary;

  @override
  _ApiaryPageState createState() => _ApiaryPageState();
}

class _ApiaryPageState extends State<ApiaryPage> {
  Apiary apiary = Apiary(hives: [], reports: []);
  Report report = Report(resume: []);

  @override
  void initState() {
    apiary = context.read<Apiary>();
    report = context.read<Report>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.0),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularButton(
                        onTap: () => Navigator.of(context).pop(),
                        icon: Ionicons.chevron_back_outline),
                    Text(apiary.name, style: AppTextStyle.boldTitle),
                    const SizedBox(width: 35, height: 35)
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
            onPressed: () {
              report.updateProvider(Report(
                  date: DateTime.now(),
                  name: 'Ficha de Controle ${apiary.reports.length + 1}', resume: []));
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ControlSheetPage()));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
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
                      SummaryApiaryCard(apiary: apiary),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ordernar por: ',
                                style: AppTextStyle.boldText),
                            SizedBox(width: 12),
                            Expanded(child: OrderBy('Data (Decrescente)')),
                          ],
                        ),
                      ),
                      if (apiary.reports.isEmpty)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: EmptyWidget(
                                  icon: Ionicons.documents_outline,
                                  text: 'Sem relatórios cadastrados'),
                            ),
                            InfoCard(
                                title: 'CADASTRE SEU RELATÓRIO',
                                text:
                                    'Cadastre seu primeiro relatório, adicione as informações de suas colméias e controle o manejo do seu apiário!')
                          ],
                        )
                      else
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: apiary.reports.length,
                            itemBuilder: (context, index) {
                              return ReportsCard(
                                  report: apiary.reports[index]);
                            })
                    ]),
              )))),
    );
  }
}
