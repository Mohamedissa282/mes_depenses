import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void ShowDialog(BuildContext context, String desc) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    descTextStyle: TextStyle(fontWeight: FontWeight.bold),
    btnOkColor: Colors.red,
    desc: desc,

    btnOkOnPress: () {},
  )..show();
}