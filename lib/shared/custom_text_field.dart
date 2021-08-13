import 'package:flutter/material.dart';

import 'package:beecontrol/core/app_theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.errorText,
    required this.hintText,
    this.icon,
    this.validator,
    this.onSaved,
    this.onChanged,
  }) : super(key: key);

  final String? errorText;
  final String hintText;
  final IconData? icon;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppTheme.dandelion,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w900, color: AppTheme.dandelion),
      decoration: InputDecoration(
        // Configurações do Prefix
        prefixIcon: Icon(icon),
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

        contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),

        // Borda
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
