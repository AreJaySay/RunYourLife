import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              width: 150,
              color: AppColors.appmaincolor,
              fit: BoxFit.cover,
              image: AssetImage("assets/important_assets/logo.png"),
            ),
            SizedBox(
              height: 40,
            ),
            LoadingAnimationWidget.hexagonDots(
              color: AppColors.appmaincolor,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
