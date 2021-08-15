import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:beecontrol/core/app_images.dart';
import 'package:beecontrol/core/app_text_style.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              AppImages.logo,
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              title,
              style: AppTextStyle.boldTitle
                  .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                text,
                style: AppTextStyle.boldTitleAlpha90,
                textAlign: TextAlign.center,
              )),
          Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Ionicons.arrow_down_outline),
          )
        ],
      ),
    );
  }
}
