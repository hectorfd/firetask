import 'package:flutter/material.dart';

import '../general/colors.dart';

class TextfieldNormalWidget extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        prefixIcon: Icon(Icons.search, size: 20, color: primary,),
        hintText: "Buscar tarea",
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
      ),
    );
  }
}
