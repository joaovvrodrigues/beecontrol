import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text('Digite o nome do Apiário',
                style: AppTextStyle.boldTitleAlpha90),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CircularButton(
                onTap: () {
                  print('Search');
                },
                icon: Ionicons.search_outline),
          )
        ],
      ),
    );
  }
}
