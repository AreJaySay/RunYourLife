import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';

import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Eating9thPage extends StatefulWidget {
  @override
  _Eating9thPageState createState() => _Eating9thPageState();
}

class _Eating9thPageState extends State<Eating9thPage> {
  List<String> _alcoholcons = ["Jamais","Rarement (quelque fois par an)","Occasionnellement : Quelques fois par mois","Régulièrement : Quelques fois par semaine","Quotidiennement : 1 à 2 fois par jour","Quotidiennement : Plus de 2 fois par jour"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("QUELLE EST TA CONSOMMATION D’ALCOOL ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0 ;x < _alcoholcons.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: step2subs.alcohol_per_week == _alcoholcons[x] ? AppColors.appmaincolor : Colors.transparent,)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                      child: Center(
                        child: Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                              color: step2subs.alcohol_per_week == _alcoholcons[x] ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        step2subs.alcohol_per_week = _alcoholcons[x];
                      });
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(_alcoholcons[x], style: new TextStyle(fontSize: 15,
                        color: Colors.black,fontFamily: "AppFontStyle"),),
                  ),
                ],
              ),
            ),
            onTap: (){
              setState(() {
                step2subs.alcohol_per_week = _alcoholcons[x];
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
        },
      ],
    );
  }
}
