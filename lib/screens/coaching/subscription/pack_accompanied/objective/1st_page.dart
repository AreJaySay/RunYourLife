import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step4_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Objective1stPage extends StatefulWidget {
  @override
  _Objective1stPageState createState() => _Objective1stPageState();
}

class _Objective1stPageState extends State<Objective1stPage> {
  List<String> _goals = [
    "Perdre du poids (au moins 5kg)",
    "Améliorer ta santé (améliorer ta nutrition en maintenant ton poids actuel)",
    "Recomposition corporelle (perdre moins de 5kg, en construisant du muscle)",
    // if(subscriptionDetails.currentdata["plan_id"] == 1)...{
    //   "Composition corporelle (tu veux perdre moins de 5kg en construisant du muscle)"
    // },
    "Contruire du muscle (et augmenter ton poids de corps)",
    "Performance athlétique (pour supporter les entrainements)",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quel est ton objectif ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0 ;x < _goals.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: step4subs.goal == _goals[x] ? AppColors.appmaincolor : Colors.transparent,)
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
                              color: step4subs.goal == _goals[x] ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        step4subs.goal = _goals[x];
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(_goals[x], style: new TextStyle(fontSize: 15,
                        color: Colors.black,fontFamily: "AppFontStyle"),),
                  ),
                ],
              ),
            ),
            onTap: (){
              setState(() {
                step4subs.goal = _goals[x];
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
        },
      ],
    );
  }
}