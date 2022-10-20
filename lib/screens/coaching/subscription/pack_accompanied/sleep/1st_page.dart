import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/subscription_models/step7_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Sleep1stPage extends StatefulWidget {
  @override
  _Sleep1stPageState createState() => _Sleep1stPageState();
}

class _Sleep1stPageState extends State<Sleep1stPage> {
  List<String> _hours = ["<5 h","5-6 h","6-7h","7-9 h",">9h"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Combien d'heures de sommeil avez-vous par nuit ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        GridView.count(
          padding: EdgeInsets.only(left: 5,right: 5,top: 20),
          primary: false,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: DeviceModel.isMobile ? 3 : 4,
          childAspectRatio: (1 / .4),
          children: <Widget>[
            for(int x = 0; x < _hours.length; x++)...{
              ZoomTapAnimation(end: 0.99,child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: step7subs.hours == _hours[x] ? AppColors.appmaincolor : Colors.transparent,)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Transform.scale(
                          scale: 1.4,
                          child: Radio(
                            activeColor: AppColors.appmaincolor,
                            value: step7subs.hours == _hours[x] ? x : 7,
                            groupValue: x,
                            onChanged: (val) {
                              setState(() {
                                step7subs.hours = _hours[x];
                              });
                            },
                          ),
                        ),
                      ),
                      Text(_hours[x], style: new TextStyle(fontSize: 15,
                          color: Colors.black, fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
                onTap: (){
                  setState(() {
                    step7subs.hours = _hours[x];
                  });
                },
              ),
            }
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text("Vous sentez-vous en forme lorsque vous vous réveillez chaque jour ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Text("1 = Je me réveille fatigué, un peu hors de forme. \n5 = Je me réveille bien et semble avoir bien récupéré de ma nuit.",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 60,
          child: FlutterSlider(
            values: [step7subs.wake_up_feelings],
            max: 5,
            min: 0,
            handlerWidth: 50,
            handlerHeight: 40,
            tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: false,
                disabled: true
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBarHeight: 10,
              activeTrackBarHeight: 10,
              activeTrackBar: BoxDecoration(
                  color: AppColors.appmaincolor,
                  borderRadius: BorderRadius.circular(1000)
              ),
              inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000)
              ),
            ),
            handler: FlutterSliderHandler(
                decoration: BoxDecoration(
                    color: AppColors.appmaincolor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Text(step7subs.wake_up_feelings.floor().toString(),
                  style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                step7subs.wake_up_feelings = lowerValue;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("J'ai déjà pris des compléments alimentaires pour dormir ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
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
                    border: Border.all(color: step7subs.sleeping_supplements == "Yes" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step7subs.sleeping_supplements == "Yes" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step7subs.sleeping_supplements = "Yes";
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
                  step7subs.sleeping_supplements = "Yes";
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
                    border: Border.all(color: step7subs.sleeping_supplements == "No" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step7subs.sleeping_supplements == "No" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step7subs.sleeping_supplements = "No";
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
                  step7subs.sleeping_supplements = "No";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
