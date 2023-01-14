import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../../utils/palettes/app_colors.dart';

class Presentation2ndPage extends StatefulWidget {
  @override
  _Presentation2ndPageState createState() => _Presentation2ndPageState();
}

class _Presentation2ndPageState extends State<Presentation2ndPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Es-tu marié ? Ou engagé en couple".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
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
                    border: Border.all(color: step1subs.isMarried == "Oui" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step1subs.isMarried == "Oui" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step1subs.isMarried = "Oui";
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
                  step1subs.isMarried = "Oui";
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
                    border: Border.all(color:  step1subs.isMarried == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue:  step1subs.isMarried == "Non" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step1subs.isMarried = "Non";
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
                  step1subs.isMarried = "Non";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text("As-tu des enfants ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
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
                    border: Border.all(color: step1subs.haveChildren == "Oui" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step1subs.haveChildren == "Oui" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step1subs.haveChildren = "Oui";
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
                  step1subs.haveChildren = "Oui";
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
                    border: Border.all(color: step1subs.haveChildren == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step1subs.haveChildren == "Non" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step1subs.haveChildren = "Non";
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
                  step1subs.haveChildren = "Non";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text("A quel point te sens-tu soutenu par les personnes chez toi à la maison".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 10,
        ),
        Text("0 : je vis seul(e)\n1: peu de soutien\n2: peu/modéremment soutenu(e)\n3: modéremment/hautement soutenu(e)\n4:très soutenu(e)",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 70,
          child: FlutterSlider(
            values: [step1subs.peopeSupport],
            max: 4,
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
                child: Text(step1subs.peopeSupport.floor().toString(),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                step1subs.peopeSupport = lowerValue;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Fais-tu les courses pour ton foyer ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
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
                    border: Border.all(color: step1subs.shopforHousehold == "Oui" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step1subs.shopforHousehold == "Oui" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step1subs.shopforHousehold = "Oui";
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
                  step1subs.shopforHousehold = "Oui";
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
                    border: Border.all(color: step1subs.shopforHousehold == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue:  step1subs.shopforHousehold == "Non" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step1subs.shopforHousehold = "Non";
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
                  step1subs.shopforHousehold = "Non";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text("Fais-tu la cuisine pour ton foyer ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
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
                    border: Border.all(color: step1subs.cookforHousehold == "Oui" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step1subs.cookforHousehold == "Oui" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step1subs.cookforHousehold = "Oui";
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
                  step1subs.cookforHousehold = "Oui";
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
                    border: Border.all(color: step1subs.cookforHousehold == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step1subs.cookforHousehold == "Non" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step1subs.cookforHousehold = "Non";
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
                  step1subs.cookforHousehold = "Non";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
