import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/report.dart';
import 'package:beecontrol/pages/control_sheet/control_sheet_controller.dart';
import 'package:beecontrol/pages/control_sheet/widgets/bee_pasture.dart';
import 'package:beecontrol/pages/control_sheet/widgets/comments.dart';
import 'package:beecontrol/pages/control_sheet/widgets/goals_card.dart';
import 'package:beecontrol/pages/control_sheet/widgets/hive_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:beecontrol/shared/empty_widget.dart';
import 'package:beecontrol/shared/info_card.dart';
import 'package:provider/provider.dart';

class ControlSheetPage extends StatefulWidget {
  const ControlSheetPage({
    Key? key,
    required this.report,
  }) : super(key: key);

  final Report report;
  // final Apiary apiary;

  @override
  _ControlSheetPageState createState() => _ControlSheetPageState();
}

class _ControlSheetPageState extends State<ControlSheetPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  ControlSheetController controller = ControlSheetController();

  @override
  void initState() {
    controller.report = Report.fromJson(widget.report.toJson());
    textController.text = controller.report.comments;
    controller.apiary = Apiary.fromJson(context.read<Apiary>().toJson());
    super.initState();
  }

  void onChanged(String obs) {
    controller.report.comments = obs;
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
                    Text(controller.report.name, style: AppTextStyle.boldTitle),
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
            onPressed: () => setState(() {
              controller.addHive();
            }),
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
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
                            child: FadeInAnimation(child: widget),
                          ),
                      children: [
                        GoalsApiaryCard(
                            apiary: controller.apiary,
                            report: controller.report),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pasto Apícula:'),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: BeePasture(
                                        groupValue:
                                            controller.report.beePasture,
                                        onChanged: (value) {
                                          setState(() {
                                            controller.report.beePasture =
                                                value;
                                          });
                                        },
                                      ))
                                ],
                              ),
                            )),
                        CommentsCard(
                            textController: textController,
                            onChanged: onChanged),
                        if (controller.apiary.hives.isEmpty)
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
                              padding: EdgeInsets.symmetric(vertical: 5),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.apiary.hives.length,
                              itemBuilder: (context, index) {
                                return HiveCard(
                                    hive: controller.apiary.hives[index]);
                              }),
                        if (controller.apiary.hives.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 80),
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.saveReport();
                                  context
                                      .read<Apiary>()
                                      .updateProvider(controller.apiary);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Finalizar Relatório'),
                                style: AppTheme.elevatedButtonStyle),
                          ),
                      ]),
                )),
              ))),
    );
  }
}
