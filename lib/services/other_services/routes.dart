import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes{
   void navigator_push(context, Widget? targetPage, {PageTransitionType transitionType = PageTransitionType.rightToLeftWithFade})async{
    await Navigator.push(
      context,
      PageTransition(
          type: transitionType,
          child: targetPage!,
          inheritTheme: false,
          ctx: context),
    );
   }
   void navigator_pushreplacement(context, Widget? targetPage, {PageTransitionType transitionType = PageTransitionType.rightToLeftWithFade}){
     Navigator.pushReplacement(
       context,
       PageTransition(
           type: transitionType,
           child: targetPage!,
           inheritTheme: false,
           ctx: context),
     );
   }
}