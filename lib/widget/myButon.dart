import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';

class Mybuton extends StatelessWidget {
  
  final void Function()? onTap;
  final Widget? child;
  const new({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child:child
        ),
      ),
    );
  }
}
