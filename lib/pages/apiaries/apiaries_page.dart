// 🐦 Flutter imports:
import 'package:flutter/material.dart';
// 📦 Package imports:
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';

// 🌎 Project imports:
import '../../core/app_text_style.dart';
import '../../models/apiary.dart';
import '../../shared/empty_widget.dart';
import '../../shared/info_card.dart';
import '../../utils/constants.dart';
import 'apiaries_controller.dart';
import 'widgets/apiaries_card.dart';
import 'widgets/search_widget.dart';
import 'widgets/summary_card.dart';

class ApiariesPage extends StatefulWidget {
  const ApiariesPage({Key? key}) : super(key: key);

  @override
  _ApiariesPageState createState() => _ApiariesPageState();
}

class _ApiariesPageState extends State<ApiariesPage> {
  ApiariesController controller = ApiariesController();
  TextEditingController textController = TextEditingController();
  late Box<Apiary> box;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void search(String text) async {
    await Future.delayed(const Duration(milliseconds: 200)).then((value) {
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
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55.0),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    // CircularButton(
                    //     onTap: () {}, icon: Ionicons.reorder_two_outline),
                    SizedBox(width: 35, height: 35),
                    Text('Meus Apiários', style: AppTextStyle.boldTitle),
                    SizedBox(width: 35, height: 35)
                  ],
                )),
          ),
          body: ValueListenableBuilder<Box<Apiary>>(
              valueListenable: Hive.box<Apiary>(CONSTANTS.box).listenable(),
              builder: (context, box, widget) {
                controller.apiaries.clear();
                controller.apiaries.addAll(box.values.toList());
                controller.initSummary();
                return SingleChildScrollView(
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
                          if (controller.apiaries.isEmpty)
                            Column(
                              children: const [
                                EmptyWidget(
                                    icon: FeatherIcons.package,
                                    text: 'Sem apiários cadastrados'),
                                InfoCard(
                                    title: 'CADASTRE SEUS APIÁRIOS',
                                    text:
                                        'Cadastre seu primeiro apiário, adicione os relatórios e controle o seu manejo!')
                              ],
                            )
                          else if (textController.value.text == '')
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.apiaries.length,
                                itemBuilder: (context, index) {
                                  return ApiariesCard(
                                      apiary: controller.apiaries[index]);
                                })
                          else if (controller.searchApiaries.isEmpty)
                            const EmptyWidget(
                                icon: FeatherIcons.package,
                                text: 'Aípiário não encontrado')
                          else
                            AnimationLimiter(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                    }))
                        ],
                      ),
                    )));
              })),
    );
  }
}
