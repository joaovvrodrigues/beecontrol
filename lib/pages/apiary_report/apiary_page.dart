import 'package:beecontrol/pages/apiary_report/widgets/summary_card.dart';
import 'package:beecontrol/shared/empty_widget.dart';
import 'package:beecontrol/shared/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/shared/circular_button.dart';

class ApiaryPage extends StatefulWidget {
  const ApiaryPage({
    Key? key,
    required this.apiary,
  }) : super(key: key);
  final Apiary apiary;

  @override
  _ApiaryPageState createState() => _ApiaryPageState();
}

class _ApiaryPageState extends State<ApiaryPage> {
  List reports = [];
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
                        icon: Icons.arrow_back_ios_new_rounded),
                    Text(widget.apiary.name, style: AppTextStyle.boldTitle),
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

                      if (reports.isEmpty)
                        Column(
                          children: [
                            EmptyWidget(
                                icon: Icons.inventory_outlined,
                                text: 'Sem relatórios cadastrados'),
                            InfoCard(
                                title: 'CADASTRE SEU RELATÓRIO',
                                text:
                                    'Cadastre seu primeiro relatório, adicione as informações de suas colméias e controle o manejo do seu apiário!')
                          ],
                        )
                      // else
                      //   ListView.builder(
                      //       shrinkWrap: true,
                      //       itemCount: apiaries.length,
                      //       itemBuilder: (context, index) {
                      //         return ApiariesCard(apiary: apiaries[index]);
                      //       })
                    ]),
              )))),
    );
  }
}
