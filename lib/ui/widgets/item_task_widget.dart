import 'package:firetask/ui/widgets/item_category_widget.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';
import 'general_widgets.dart';

class ItemTaskWidget extends StatelessWidget {
  const ItemTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(4, 4),
              blurRadius: 12
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemCategoryWidget( text: "Trabajo",),
          caja3(),
          Text("tantas graecis class sanctus epicuri",
            style: TextStyle(
              fontSize:15,
              fontWeight: FontWeight.w600,
              color: primary.withOpacity(0.85),
            ),
          ),
          Text("aptent dissentiunt magna finibus putent potenti blandit utroque feugait aliquip",
            style: TextStyle(
              fontSize:14,
              fontWeight: FontWeight.w500,
              color: primary.withOpacity(0.75),
            ),
          ),
          caja6(),
          Text("10/12/2024",
            style: TextStyle(
              fontSize:12,
              fontWeight: FontWeight.w600,
              color: primary.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }
}
