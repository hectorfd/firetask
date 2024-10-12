import 'package:firetask/ui/general/colors.dart';
import 'package:flutter/material.dart';

class ItemCategoryWidget extends StatelessWidget {
  // const ItemCategoryWidget({super.key});

  String text;
  ItemCategoryWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),

      decoration: BoxDecoration(
        color: categoryColor[text],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize:12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
