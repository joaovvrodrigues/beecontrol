import 'package:flutter/material.dart';

import 'package:beecontrol/core/app_theme.dart';

class CustomDropDownField extends StatelessWidget {
  const CustomDropDownField({
    Key? key,
    this.errorText,
    required this.hintText,
    this.icon,
    this.size,
    this.validator,
    this.onSaved,
    this.items,
    this.initialValue,
  }) : super(key: key);

  final String? errorText;
  final String hintText;
  final IconData? icon;
  final double? size;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final List<DropdownMenuItem<String>>? items;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      items: items,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      onChanged: onSaved,
      dropdownColor: Colors.white,
      icon: Icon(Icons.arrow_drop_down_rounded),
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.dandelion),
      decoration: InputDecoration(
        // Configurações do Prefix
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            size: size,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 50,
          minHeight: 25,
        ),

        // Configurações do fundo
        filled: true,
        fillColor: Colors.white,
        isDense: false,

        // Configurações de erro
        errorText: errorText,
        errorStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.sunset),

        // Configurações de hint
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.eclipse.withAlpha(80)),

        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),

        // Borda
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
