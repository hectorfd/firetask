import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';

Widget caja3() => const SizedBox(height: 3);
Widget caja6() => const SizedBox(height: 6);
Widget caja10() => const SizedBox(height: 10);
Widget caja20() => const SizedBox(height: 20);
Widget caja30() => const SizedBox(height: 30);
Widget caja40() => const SizedBox(height: 40);

Widget cajaWith3() => const SizedBox(height: 3);
Widget cajaWith6() => const SizedBox(height: 6);
Widget cajaWith10() => const SizedBox(height: 10);
Widget cajaWith20() => const SizedBox(height: 20);
Widget cajaWith40() => const SizedBox(height: 40);


Widget loadingWidget()=>Center(
  child: SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      color: primary,
      strokeWidth: 2.2,
    ),
  ),
);

showSnackBarSuccess(BuildContext currentContext, String text){
  ScaffoldMessenger.of(currentContext).showSnackBar(
            SnackBar(
              backgroundColor: Color(0xFF17c3b2),
              content: Row(
                children: [
                  Icon(Icons.check, color: Colors.white),
                  SizedBox(width: 10),
                  Text(text),
                ],
              ),
            ),
          );
}

showSnackBarError(BuildContext currentContext, String text){
  ScaffoldMessenger.of(currentContext).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.white),
                  SizedBox(width: 10),
                  Text(text),
                ],
              ),
            ),
          );
}