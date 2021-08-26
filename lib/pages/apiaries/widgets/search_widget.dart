import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/shared/circular_button.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.search,
    required this.clear,
    required this.textController,
  }) : super(key: key);
  final Function(String) search;
  final VoidCallback clear;

  final TextEditingController textController;

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
            child: TextField(
                onChanged: search,
                controller: textController,
                decoration: InputDecoration(
                    hintText: 'Digite o nome do Apiário',
                    hintStyle: AppTextStyle.boldTitleAlpha90,
                    border: InputBorder.none),
                style: AppTextStyle.boldTitle),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: textController,
                builder: (_, value, ___) {
                  return CircularButton(
                      onTap: () {
                        if (value.text.isNotEmpty) {
                          textController.clear();
                          clear();
                        }
                      },
                      icon: value.text == ''
                          ? Ionicons.search_outline
                          : Ionicons.close_outline);
                }),
          )
        ],
      ),
    );
  }
}
