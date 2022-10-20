import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../../widgets/materialbutton.dart';

class Pregnant6thPage extends StatefulWidget {
  @override
  _Pregnant6thPageState createState() => _Pregnant6thPageState();
}

class _Pregnant6thPageState extends State<Pregnant6thPage> {
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();
  List<String> _activitylevel = [
    "Très léger (assis presque toute la journée - ex : travail de bureau)",
    "Léger (un mix assis/debout, et légère activité - ex : professeur)",
    "Modéré (une activité basse à modérée - ex : serveur de restaurant)",
    "Intense (activité fatigante tout au long de la journée - ex : travail dans le bâtiment)",
    "Très intense (7+heures d'exercices intenses)"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Comment décrirais-tu ton niveau d’activité sportive en heures par semaine ? ".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0 ;x < _activitylevel.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: step5subs.activity_outside_sport_level == _activitylevel[x] ? AppColors.appmaincolor : Colors.transparent,)
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
                              color: step5subs.activity_outside_sport_level == _activitylevel[x] ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        step5subs.activity_outside_sport_level = _activitylevel[x];
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(_activitylevel[x], style: new TextStyle(fontSize: 15,
                        color: Colors.black,fontFamily: "AppFontStyle"),),
                  ),
                ],
              ),
            ),
            onTap: (){
              setState(() {
                step5subs.activity_outside_sport_level = _activitylevel[x];
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