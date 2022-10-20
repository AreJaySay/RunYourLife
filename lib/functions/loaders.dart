import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class ScreenLoaders{
  void functionLoader(context){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(0.0),
              child: Center(
                child: Platform.isIOS ? CupertinoActivityIndicator(
                  animating: true,
                  radius: 20,
                  color: Colors.white,
                ) : LoadingAnimationWidget.discreteCircle(
                  color: Colors.white,
                  size: 40,
                  secondRingColor: AppColors.appmaincolor,
                  thirdRingColor: AppColors.pinkColor,
                ),
              ),
            ),
          );
        },
      );
  }
}