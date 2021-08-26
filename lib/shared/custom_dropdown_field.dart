import 'package:flutter/material.dart';

import 'package:beecontrol/core/app_theme.dart';
import 'package:ionicons/ionicons.dart';

class CustomDropDownField<T> extends StatelessWidget {
  const CustomDropDownField(
      {Key? key,
      this.errorText,
      required this.hintText,
      this.icon,
      // this.size,
      this.validator,
      this.onSaved,
      this.items,
      this.initialValue,
      this.radius = 12,
      this.style,
      this.contentPadding,
      this.isDense = false})
      : super(key: key);

  final String? errorText;
  final String hintText;
  final IconData? icon;
  // final double? size;
  final String? Function(T? text)? validator;
  final void Function(T? text)? onSaved;
  final List<DropdownMenuItem<T>>? items;
  final T? initialValue;
  final double radius;
  final TextStyle? style;
  final EdgeInsets? contentPadding;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      // isExpanded: true,
      isDense: isDense,
      value: initialValue,
      items: items,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      onChanged: onSaved,
      dropdownColor: Colors.white,
      icon: Icon(Ionicons.chevron_down_outline),
      style: style ??
          TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.eclipse),
      decoration: InputDecoration(
        // Configurações do Prefix
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Icon(
        //     icon,
        //     size: size,
        //   ),
        // ),
        // prefixIconConstraints: BoxConstraints(
        //   minWidth: 50,
        //   minHeight: 25,
        // ),

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

        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 25),

        // Borda
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}
