// 📦 Package imports:
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../core/app_text_style.dart';
import '../../core/app_theme.dart';
import '../../models/recognition.dart';
import '../../models/user_model.dart';
import '../../shared/circular_button.dart';

class VigorResultPage extends StatefulWidget {
  const VigorResultPage({
    Key? key,
    required this.recognition,
  }) : super(key: key);
  final Recognition recognition;
  @override
  _VigorResultPageState createState() => _VigorResultPageState();
}

class _VigorResultPageState extends State<VigorResultPage> {
  final formKey = GlobalKey<FormState>();
  var user = UserModel();
  @override
  void initState() {
    log(widget.recognition.toString());
    super.initState();
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
                      CircularButton(onTap: () => Navigator.of(context).pop(), icon: Ionicons.chevron_back_outline),
                      const Text('Vigor da abelha', style: AppTextStyle.boldTitle),
                      const SizedBox(width: 35, height: 35)
                    ],
                  )),
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: AnimationLimiter(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: [
                        Center(
                          child: CircularPercentIndicator(
                            header: const Text(
                              'Confiança',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                            ),
                            radius: 80.0,
                            lineWidth: 15.0,
                            animation: true,
                            percent: widget.recognition.confidence!,
                            center: Text(
                              '${(widget.recognition.confidence! * 100).toStringAsFixed(2)}%',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            footer: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'O vigor da abelha rainha foi classificado como: ',
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: widget.recognition.label!.substring(2).toUpperCase(),
                                      style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.eclipse))
                                ],
                              ),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: AppTheme.dandelion,
                          ),
                        ),
                      ]),
                )))));
  }
}
