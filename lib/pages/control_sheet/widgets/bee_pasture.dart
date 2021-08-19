import 'package:flutter/material.dart';

enum PastoApicola { polen, nectar, florada }

class BeePasture extends StatelessWidget {
  const BeePasture({
    Key? key,
    required this.onChanged,
    required this.groupValue,
  }) : super(key: key);
  final void Function(dynamic) onChanged;
  final dynamic groupValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: RadioListTile<PastoApicola>(
              title: const Text('Entrada de Pólen'),
              value: PastoApicola.polen,
              groupValue: groupValue,
              contentPadding: EdgeInsets.all(0),
              dense: true,
              onChanged: onChanged),
        ),
        Expanded(
          child: RadioListTile<PastoApicola>(
              title: const Text('Entrada de Néctar'),
              value: PastoApicola.nectar,
              groupValue: groupValue,
              dense: true,
              contentPadding: EdgeInsets.all(0),
              onChanged: onChanged),
        ),
        Expanded(
          child: RadioListTile<PastoApicola>(
              title: const Text('Florada'),
              contentPadding: EdgeInsets.all(0),
              value: PastoApicola.florada,
              groupValue: groupValue,
              dense: true,
              onChanged: onChanged),
        ),
      ],
    );
  }
}
