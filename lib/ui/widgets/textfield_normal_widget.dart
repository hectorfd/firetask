import 'package:flutter/material.dart';

import '../general/colors.dart';

class TextfieldNormalWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function? onTap;
  final TextEditingController controller;

  TextfieldNormalWidget({
    required this.hintText,
    required this.icon,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap != null ? () { onTap!(); } : null,
      readOnly: onTap != null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        prefixIcon: Icon(
          icon,
          size: 20,
          color: primary,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: primary.withOpacity(0.6),
        ),
        filled: true,
        fillColor: secondary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (String? value) {
        if (value != null && value.isEmpty) {
          return "Campo Obligatorio";
        }
        return null;
      },
    );
  }
}

