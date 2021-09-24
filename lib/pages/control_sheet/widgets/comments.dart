import 'package:flutter/material.dart';

class CommentsCard extends StatelessWidget {
  const CommentsCard({
    Key? key,
    required this.textController,
    required this.onChanged,
    required this.readOnly,
  }) : super(key: key);

  final TextEditingController textController;
  final Function(String) onChanged;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Observações:'),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: TextField(
                readOnly: readOnly,
                autofocus: false,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                onChanged: onChanged,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Insira observações aqui'),
                maxLines: null,
                controller: textController,
              ),
            )
          ],
        ));
  }
}
