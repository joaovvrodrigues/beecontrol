import '../../models/apiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../core/app_text_style.dart';
import '../../core/app_theme.dart';
import '../../models/report.dart';
import 'apiary_controller.dart';
import 'widgets/order_by.dart';
import 'widgets/reports_card.dart';
import 'widgets/summary_apiary_card.dart';
import '../control_sheet/control_sheet_page.dart';
import '../../shared/circular_button.dart';
import '../../shared/empty_widget.dart';
import '../../shared/info_card.dart';

class ApiaryPage extends StatefulWidget {
  const ApiaryPage({
    Key? key,
    // required this.id,
  }) : super(key: key);
  // final Apiary controller.apiary;
  // final String id;

  @override
  _ApiaryPageState createState() => _ApiaryPageState();
}

class _ApiaryPageState extends State<ApiaryPage> {
  ApiaryController controller = ApiaryController();

  @override
  void initState() {
    context.read<Apiary>().reports.sort((a, b) => -a.date!.compareTo(b.date!));
    super.initState();
  }

  void onSaved(text) {
    setState(() {
      controller.sortList(text);
    });
  }

  void openReport(Report report) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ControlSheetPage(report: report)));
  }

  @override
  Widget build(BuildContext context) {
    controller.apiary = context.watch<Apiary>();
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55.0),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularButton(
                        onTap: () => Navigator.of(context).pop(),
                        icon: Ionicons.chevron_back_outline),
                    Text(controller.apiary.name, style: AppTextStyle.boldTitle),
                    const SizedBox(width: 35, height: 35)
                  ],
                )),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 8,
            backgroundColor: AppTheme.dandelion,
            child: const Icon(
              FeatherIcons.plus,
              color: AppTheme.eclipse,
            ),
            onPressed: () => openReport(controller.addReport()),
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
                      SummaryApiaryCard(apiary: controller.apiary),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: OrderBy(
                            orderByList: controller.orderByList,
                            orderBy: controller.orderBy,
                            onSaved: onSaved),
                      ),
                      if (controller.apiary.reports.isEmpty)
                        Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: EmptyWidget(
                                  icon: Ionicons.documents_outline,
                                  text: 'Sem relatórios cadastrados'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 40),
                              child: InfoCard(
                                  title: 'CADASTRE SEU RELATÓRIO',
                                  text:
                                      'Cadastre seu primeiro relatório, adicione as informações de suas colméias e controle o manejo do seu apiário!'),
                            )
                          ],
                        )
                      else
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.apiary.reports.length,
                            itemBuilder: (context, index) {
                              return ReportsCard(
                                report: controller.apiary.reports[index],
                                onTap: () => openReport(controller
                                    .apiary.reports[index]
                                    .copyWith(newReport: false)),
                              );
                            })
                    ]),
              )))),
    );
  }
}
