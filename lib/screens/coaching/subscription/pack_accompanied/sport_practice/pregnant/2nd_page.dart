import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../../widgets/appbar.dart';
import '../../../../../../../widgets/materialbutton.dart';

class Pregnant2ndPage extends StatefulWidget {
  @override
  _Pregnant2ndPageState createState() => _Pregnant2ndPageState();
}

class _Pregnant2ndPageState extends State<Pregnant2ndPage> {
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();
  final AppBars _appBars = AppBars();
  List<String> _goals = [
    "Très léger (presque pas d'activité physique)",
    "Léger (1-3 heures d'exercices légers à modérés)",
    "Modéré (3-4 heures d'exercices modérés)",
    "Intense (4-6 heures d'exercices modérés à intenses)",
    "Très intense (7+ heures d'exercices intenses)"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Comment décrirais-tu ton niveau d'activité sportive ? (heures par semaine)".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0 ;x < _goals.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: step5subs.sporting_activity_level == _goals[x] ? AppColors.appmaincolor : Colors.transparent,)
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
                              color: step5subs.sporting_activity_level == _goals[x] ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        step5subs.sporting_activity_level = _goals[x];
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
                step5subs.sporting_activity_level = _goals[x];
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