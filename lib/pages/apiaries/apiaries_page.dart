import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/pages/apiaries/widgets/apiaries_card.dart';
import 'package:beecontrol/pages/apiaries/widgets/search_widget.dart';
import 'package:beecontrol/pages/apiaries/widgets/summary_card.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:beecontrol/shared/empty_widget.dart';
import 'package:beecontrol/shared/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';

class ApiariesPage extends StatefulWidget {
  const ApiariesPage({Key? key}) : super(key: key);

  @override
  _ApiariesPageState createState() => _ApiariesPageState();
}

class _ApiariesPageState extends State<ApiariesPage> {
  Apiary apiary = Apiary(
      city: 'Bambuí', uf: 'MG', numHives: 5, name: 'Apiário Santa Clara');

  List<Apiary> apiaries = [
    Apiary(city: 'Bambuí', uf: 'MG', numHives: 5, name: 'Apiário Santa Clara'),
    Apiary(city: 'Bambuí', uf: 'MG', numHives: 3, name: 'Apiário Lagoinha')
  ];

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
                    CircularButton(onTap: () {}, icon: Icons.menu_rounded),
                    Text('Meus Apiários', style: AppTextStyle.boldTitle),
                    SizedBox(width: 35)
                  ],
                )),
          ),
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
                    SummaryCard(),
                    SearchWidget(),
                    if (apiaries.isEmpty)
                      Column(
                        children: [
                          EmptyWidget(
                              icon: Ionicons.albums_outline,
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
