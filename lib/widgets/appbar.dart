import 'dart:io';

import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';

class AppBars {
  PreferredSizeWidget preferredSize(
      {double height = 100, double logowidth = 150}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height), // here the desired height
      child: Container(
        decoration: BoxDecoration(
          gradient: AppGradientColors.gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                3.5, // vertical, move down 10
              ),
            )
          ],
        ),
        child: SafeArea(
          child: Center(
            child: Image(
              color: Colors.white,
              width: logowidth,
              image: AssetImage("assets/important_assets/logo-white.png"),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget whiteappbar(context,
      {String title = "", bool isprofile = false}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(80), // here the desired height
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: isprofile
            ? null
            : BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 3.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(
                      5.0, // horizontal, move right 10
                      3.5, // vertical, move down 10
                    ),
                  )
                ],
              ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  child: Center(
                    child: Platform.isAndroid
                        ? Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 22,
                          )
                        : Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.white,
                            size: 22,
                          ),
                  ),
                  decoration: BoxDecoration(
                      gradient: AppGradientColors.gradient,
                      borderRadius: BorderRadius.circular(1000)),
                ),
                onTap: () {
                  Navigator.of(context).pop(null);
                },
              ),
              SizedBox(
                width: 15,
              ),
              Hero(
                tag: title,
                child: Text(
                  title,
                  style: TextStyle(
                      color: AppColors.appmaincolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "AppFontStyle"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget bluegradient(context, Widget widget) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56), // here the desired height
      child: Container(
        decoration: BoxDecoration(
          gradient: AppGradientColors.gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                3.5, // vertical, move down 10
              ),
            )
          ],
        ),
        child: SafeArea(
          child: Center(
            child: widget,
          ),
        ),
      ),
    );
  }
}
