import 'package:flutter/material.dart';

import 'package:run_your_life/utils/palettes/app_colors.dart';

class Materialbutton{
  Widget materialButton(String? text,void Function()? function,{double spacing = 5,Color bckgrndColor = AppColors.appmaincolor, Color textColor = Colors.white, String icon = "", double radius = 1000, double fontsize = 16}){
    return MaterialButton(
      height: 55,
      color: bckgrndColor,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           icon == "" ? Container() : Image(
              width: 25,
              image: AssetImage(icon),
            ),
            SizedBox(
              width: spacing,
            ),
            Text(text!,style: TextStyle(fontSize: fontsize,fontFamily: "AppFontStyle",color: textColor),),
          ],
        ),
      ),
      onPressed: function,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}