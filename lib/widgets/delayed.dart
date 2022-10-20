import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';

class DelayedWidgets{
  Widget delayedWidget({int? delayDuration, int? animationDuration, DelayedAnimations? delayedAnimations, Widget? widget}){
    return DelayedWidget(
      delayDuration: Duration(milliseconds: delayDuration!),
      animationDuration: Duration(milliseconds: animationDuration!),
      animation: delayedAnimations!,
      child: widget!,
    );
  }
}