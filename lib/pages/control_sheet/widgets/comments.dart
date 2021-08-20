import 'package:flutter/material.dart';

class CommentsCard extends StatelessWidget {
  const CommentsCard({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Observações:'),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 150),
              child: TextField(
                decoration: InputDecoration(
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
