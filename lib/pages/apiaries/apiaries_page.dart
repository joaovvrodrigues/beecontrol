import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/models/summary.dart';
import 'package:beecontrol/pages/apiaries/widgets/apiaries_card.dart';
import 'package:beecontrol/pages/apiaries/widgets/search_widget.dart';
import 'package:beecontrol/pages/apiaries/widgets/summary_card.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:beecontrol/shared/empty_widget.dart';
import 'package:beecontrol/shared/info_card.dart';
import 'package:beecontrol/utils/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';

class ApiariesPage extends StatefulWidget {
  const ApiariesPage({Key? key}) : super(key: key);

  @override
  _ApiariesPageState createState() => _ApiariesPageState();
}

class _ApiariesPageState extends State<ApiariesPage> {
  Summary summary =
      Summary(numApiaries: 0, numHives: 0, numReports: 0, orphanBoxes: 0);

  @override
  void initState() {
    summary.numApiaries = apiaries.length;
    for (var apiary in apiaries) {
      summary.orphanBoxes += apiary.orphanBoxes;
      summary.numReports += apiary.reports.length;
      summary.numHives += apiary.hives.length;
    }

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
                    SummaryCard(summary: summary),
                    SearchWidget(),
                    if (apiaries.isEmpty)
                      Column(
                        children: [
                          EmptyWidget(
                              icon: FeatherIcons.package,
                              text: 'Sem apiários cadastrados'),
                          InfoCard(
                              title: 'CADASTRE SEUS APIÁRIOS',
                              text:
                                  'Cadastre seu primeiro apiário, adicione os relatórios e controle o seu manejo!')
                        ],
                      )
                    else
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: apiaries.length,
                          itemBuilder: (context, index) {
                            return ApiariesCard(apiary: apiaries[index]);
                          })
                  ],
                ),
              )))),
    );
  }
}
