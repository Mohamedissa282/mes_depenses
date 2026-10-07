import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';

void ShowDialogSucces(BuildContext context, String desc) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.rightSlide,
    descTextStyle: TextStyle(fontWeight: FontWeight.bold),
    btnOkColor: Colors.green,
    desc: desc,

    btnOkOnPress: () {},
  )..show();
}