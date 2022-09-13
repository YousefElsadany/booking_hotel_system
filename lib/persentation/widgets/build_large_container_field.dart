// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class BuildLargeContainerField extends StatelessWidget {
  const BuildLargeContainerField({
    Key? key,
    this.child,
    this.titleContainer,
    this.height = 40,
    required this.borderColor,
    this.bgColor = Colors.white,
  }) : super(key: key);
  final child;
  final titleContainer;
  final double height;
  final Color borderColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      // margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          titleContainer,
          SizedBox(width: 10),
          child,
        ],
      ),
    );
  }
}
