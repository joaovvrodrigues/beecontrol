import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {Key? key,
      this.errorText,
      required this.hintText,
      this.icon,
      this.size,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.inputFormatters,
      this.keyboardType,
      this.textCapitalization = TextCapitalization.none,
      this.initialValue,
      this.readOnly = false,
      this.obscureText = false})
      : super(key: key);

  final String? errorText;
  final String hintText;
  final IconData? icon;
  final double? size;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final String? initialValue;
  final bool readOnly;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      cursorColor: AppTheme.dandelion,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      readOnly: readOnly,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w900, color: AppTheme.eclipse),
      decoration: InputDecoration(
        // Configurações do Prefix
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  size: size,
                ),
              )
            : null,
        prefixIconConstraints: icon != null
            ? const BoxConstraints(
                minWidth: 50,
                minHeight: 25,
              )
            : null,

        // Configurações do fundo
        filled: true,
        fillColor: Colors.white,
        isDense: false,

        // Configurações de erro
        errorText: errorText,
        errorStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.sunset),

        // Configurações de hint
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.eclipse.withAlpha(80)),

        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 25),

        // Borda
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
