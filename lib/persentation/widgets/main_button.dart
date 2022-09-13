

import 'package:flutter/material.dart';

Widget mainButton(BuildContext context,{
  required Color buttonColor,
  Color textButtomColor = Colors.white,
  double? buttonWidth,
  double? buttonHeight,
  double? borderRadius = 10.0,
  Color boarderColor = Colors.transparent,
  required String text,
  required Function()? press,

}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius!),
        border: Border.all(color: boarderColor),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.8),
        //     spreadRadius: 2,
        //     blurRadius: 3,
        //     offset: Offset(0, 0), // changes position of shadow
        //   ),
        // ],

        color: buttonColor,

      ),
      width: buttonWidth,
      height: buttonHeight,
      child: MaterialButton(
        onPressed: press,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline2!.copyWith(
            color: textButtomColor,
          )
          // TextStyle(color: textButtomColor,
          //     fontWeight: FontWeight.bold),
        ),
      ),
    );
