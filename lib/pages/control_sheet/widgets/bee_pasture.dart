import 'package:flutter/material.dart';

class BeePasture extends StatelessWidget {
  const BeePasture({
    Key? key,
    required this.onChanged,
    required this.groupValue,
  }) : super(key: key);
  final void Function(int?)? onChanged;
  final int? groupValue;

  static List<String> beePastureList = [
    'Entrada de Pólen',
    'Entrada de Néctar',
    'Florada'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List<Widget>.generate(
          beePastureList.length,
          (index) => Expanded(
            child: RadioListTile<int>(
                toggleable: true,
                title: Text(beePastureList[index]),
                value: index,
                groupValue: groupValue,
                contentPadding: const EdgeInsets.all(0),
                dense: true,
                onChanged: onChanged),
          ),
        ));
  }
}
