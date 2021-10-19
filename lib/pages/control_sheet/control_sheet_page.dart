// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import '../../core/app_text_style.dart';
import '../../core/app_theme.dart';
import '../../models/apiary.dart';
import '../../models/report.dart';
import '../../shared/circular_button.dart';
import '../../shared/empty_widget.dart';
import '../../shared/info_card.dart';
import 'control_sheet_controller.dart';
import 'widgets/bee_pasture.dart';
import 'widgets/comments.dart';
import 'widgets/goals_card.dart';
import 'widgets/hive_card.dart';

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
  ScrollController scrollController = ScrollController();

  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 2),
    content: const Text(
      'Nova colméia adicionada!',
      style: TextStyle(fontSize: 16, color: AppTheme.eclipse),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    backgroundColor: AppTheme.dandelion,
  );

  @override
  void initState() {
    controller.report = Report.fromJson(widget.report.toJson());
    textController.text = controller.report.comments;
    controller.apiary = Apiary.fromJson(context.read<Apiary>().toJson());
    controller.initHives();
    findLast();
    super.initState();
  }

  void findLast() {
    setState(() {
      controller.findLastReport();
    });
  }

  void onChanged(String obs) {
    controller.report.comments = obs;
  }

  void divideHive(num mother, {bool count = false}) {
    setState(() {
      controller.divideHive(mother, count: count);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    Text(controller.report.name, style: AppTextStyle.boldTitle),
                    const SizedBox(width: 35, height: 35)
                  ],
                )),
          ),
          floatingActionButton:
              (controller.report.newReport || controller.lastReport)
                  ? FloatingActionButton(
                      elevation: 8,
                      backgroundColor: AppTheme.dandelion,
                      child: const Icon(
                        FeatherIcons.plus,
                        color: AppTheme.eclipse,
                      ),
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          controller.addHive();
                        });
                        await scrollController.animateTo(
                            scrollController.position.maxScrollExtent + 100,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut);
                      },
                    )
                  : null,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: SingleChildScrollView(
                controller: scrollController,
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
                              readOnly: !(controller.report.newReport ||
                                  controller.lastReport),
                              apiary: controller.apiary,
                              report: controller.report),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Pasto Apícula:'),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        child: BeePasture(
                                            groupValue:
                                                controller.report.beePasture,
                                            onChanged: (controller
                                                        .report.newReport ||
                                                    controller.lastReport)
                                                ? (value) {
                                                    setState(() {
                                                      controller.report
                                                          .beePasture = value;
                                                    });
                                                  }
                                                : null))
                                  ],
                                ),
                              )),
                          CommentsCard(
                            textController: textController,
                            onChanged: onChanged,
                            readOnly: !(controller.report.newReport ||
                                controller.lastReport),
                          ),
                          if (controller.report.hives.isEmpty)
                            Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.report.hives.length,
                                itemBuilder: (context, index) {
                                  return HiveCard(
                                      readOnly: !(controller.report.newReport ||
                                          controller.lastReport),
                                      hive: controller.report.hives[index],
                                      divideHive: divideHive);
                                }),
                          if (controller.report.hives.isNotEmpty &&
                              (controller.report.newReport ||
                                  controller.lastReport))
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 80),
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.saveReport();
                                    context
                                        .read<Apiary>()
                                        .updateProvider(controller.apiary);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(controller.lastReport
                                      ? 'Salvar Relatório'
                                      : 'Finalizar Relatório'),
                                  style: AppTheme.elevatedButtonStyle),
                            )
                          else
                            const SizedBox(height: 60)
                        ]),
                  )),
                )),
          )),
    );
  }
}
