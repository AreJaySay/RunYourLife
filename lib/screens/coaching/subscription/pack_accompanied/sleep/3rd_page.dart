import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step7_subs.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../../utils/palettes/app_colors.dart';

class Sleep3rdPage extends StatefulWidget {
  @override
  _Sleep3rdPageState createState() => _Sleep3rdPageState();
}

class _Sleep3rdPageState extends State<Sleep3rdPage> {
  List _isgotoBed = ["Oui","Oui sauf le week-end","Non je change tout le temps mes heures de coucher"];
  List _isWakeUp = ["Oui","Oui sauf le week-end","Non je me réveille à des heures changeantes dans la semaine"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Te couches-tu à des heures régulières toute la semaine (week-end inclu)?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0 ;x < _isgotoBed.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: step7subs.regular_times_bed == _isgotoBed[x] ? AppColors.appmaincolor : Colors.transparent,)
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
                              color: step7subs.regular_times_bed == _isgotoBed[x] ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        step7subs.regular_times_bed = _isgotoBed[x];
                      });
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(_isgotoBed[x], style: new TextStyle(fontSize: 15,
                        color: Colors.black,fontFamily: "AppFontStyle"),),
                  ),
                ],
              ),
            ),
            onTap: (){
              setState(() {
                step7subs.regular_times_bed = _isgotoBed[x];
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
        },
        SizedBox(
          height: 30,
        ),
        Text("Te réveilles-tu à des heures régulières toute la semaine (week-end inclu) ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0 ;x < _isWakeUp.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: step7subs.regular_hours_wake_up == _isWakeUp[x] ? AppColors.appmaincolor : Colors.transparent,)
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
                              color: step7subs.regular_hours_wake_up == _isWakeUp[x] ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        step7subs.regular_hours_wake_up = _isWakeUp[x];
                      });
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(_isWakeUp[x], style: new TextStyle(fontSize: 15,
                        color: Colors.black,fontFamily: "AppFontStyle"),),
                  ),
                ],
              ),
            ),
            onTap: (){
              setState(() {
                step7subs.regular_hours_wake_up = _isWakeUp[x];
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
        },
        SizedBox(
          height: 30,
        ),
        Text("Est-ce que tu t'exposes à la lumière du jour (dehors) avant 10 h du matin au moins 10 min".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step7subs.daylight_exposure == "Oui" ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Transform.scale(
                        scale: 1.4,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 1,
                          groupValue: step7subs.daylight_exposure == "Oui" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step7subs.daylight_exposure = "Oui";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Oui',style: new TextStyle(fontSize: 14,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step7subs.daylight_exposure = "Oui";
                });
              },
            ),
            SizedBox(
              width: 30,
            ),
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step7subs.daylight_exposure == "Non" ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Transform.scale(
                        scale: 1.4,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 2,
                          groupValue: step7subs.daylight_exposure == "Non" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step7subs.daylight_exposure = "Non";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Non',style: new TextStyle(fontSize: 14,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step7subs.daylight_exposure = "Non";
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
