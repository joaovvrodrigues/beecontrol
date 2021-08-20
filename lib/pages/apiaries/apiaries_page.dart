import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/pages/apiaries/apiaries_controller.dart';
import 'package:beecontrol/pages/apiaries/widgets/apiaries_card.dart';
import 'package:beecontrol/pages/apiaries/widgets/search_widget.dart';
import 'package:beecontrol/pages/apiaries/widgets/summary_card.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:beecontrol/shared/empty_widget.dart';
import 'package:beecontrol/shared/info_card.dart';
import 'package:beecontrol/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ApiariesPage extends StatefulWidget {
  const ApiariesPage({Key? key}) : super(key: key);

  @override
  _ApiariesPageState createState() => _ApiariesPageState();
}

class _ApiariesPageState extends State<ApiariesPage> {
  ApiariesController controller = ApiariesController();
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void search(String text) async {
    await Future.delayed(Duration(milliseconds: 200)).then((value) {
      setState(() {
        if (text.isNotEmpty) {
          controller.search(text);
        } else {
          controller.clear();
        }
      });
    });
  }

  void clear() {
    setState(() {
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.initSummary();
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
                        onTap: () {}, icon: Ionicons.reorder_two_outline),
                    Text('Meus Apiários', style: AppTextStyle.boldTitle),
                    const SizedBox(width: 35, height: 35)
                  ],
                )),
          ),
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
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
                    SummaryCard(summary: controller.summary),
                    SearchWidget(
                      clear: clear,
                      search: search,
                      textController: textController,
                    ),
                    ValueListenableBuilder(
                        valueListenable: Hive.box(CONSTANTS.box).listenable(),
                        builder: (context, Box box, _) {
                          // print(box.name);
                          // print(box.values.length);
                          // print(box.isOpen);
                          // controller.apiaries.clear();
                          // for (var item in box.values) {
                          //   controller.apiaries.add(item as Apiary);
                          // }

                          if (controller.apiaries.isEmpty)
                            return Column(
                              children: [
                                EmptyWidget(
                                    icon: FeatherIcons.package,
                                    text: 'Sem apiários cadastrados'),
                                InfoCard(
                                    title: 'CADASTRE SEUS APIÁRIOS',
                                    text:
                                        'Cadastre seu primeiro apiário, adicione os relatórios e controle o seu manejo!')
                              ],
                            );
                          else if (textController.value.text == '')
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.apiaries.length,
                                itemBuilder: (context, index) {
                                  return ApiariesCard(
                                      apiary: controller.apiaries[index]);
                                });
                          else if (controller.searchApiaries.isEmpty)
                            return EmptyWidget(
                                icon: FeatherIcons.package,
                                text: 'Aípiário não encontrado');
                          else
                            return AnimationLimiter(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.searchApiaries.length,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration.staggeredList(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: SlideAnimation(
                                              child: FadeInAnimation(
                                                  child: ApiariesCard(
                                                      apiary: controller
                                                              .searchApiaries[
                                                          index]))));
                                    }));
                        })
                  ],
                ),
              )))),
    );
  }
}
