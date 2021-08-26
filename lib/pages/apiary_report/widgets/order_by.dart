import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/shared/custom_dropdown_field.dart';

class OrderBy extends StatelessWidget {
  const OrderBy(
      {Key? key,
      required this.orderByList,
      required this.orderBy,
      required this.onSaved,
      this.title = 'Ordernar por: '})
      : super(key: key);

  final String title;
  final List<String> orderByList;
  final int orderBy;
  final Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyle.boldText),
        SizedBox(width: 12),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
              child: CustomDropDownField<String>(
                radius: 20,
                onSaved: onSaved,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                style: AppTextStyle.boldText,
                icon: Ionicons.business_outline,
                items: orderByList.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hintText: 'Ordernar por:',
                initialValue: orderByList[orderBy],
              )),
        ),
        // Expanded(child: OrderBy('Data (Decrescente)')),
      ],
    );
  }
}
