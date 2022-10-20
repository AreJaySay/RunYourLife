import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step6_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Stress2ndPage extends StatefulWidget {
  @override
  _Stress2ndPageState createState() => _Stress2ndPageState();
}

class _Stress2ndPageState extends State<Stress2ndPage> {
  final TextEditingController _manageStress = new TextEditingController()..text=step6subs.manage_stress == "No, i can't" ? "" : step6subs.manage_stress;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _manageStress.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Êtes-vous stressé à la maison ".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Text("1 : je suis serein chez moi \n3: modérément \n5 : Je suis toujours sous pression à la maison.",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 60,
          child: FlutterSlider(
            values: [step6subs.home_stressed],
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
                child: Text(step6subs.home_stressed.floor().toString(),
                  style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                step6subs.home_stressed = lowerValue;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Pouvez-vous trouver des moyens de vous calmer ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: TextField(
            controller: _manageStress,
            maxLines: 4,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                border: InputBorder.none,
                hintText: "Façons de gérer le stress",
                hintStyle: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle")
            ),
            onChanged: (text){
              setState(() {
                step6subs.manage_stress = text;
              });
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ZoomTapAnimation(end: 0.99,child: Container(
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: step6subs.manage_stress == "No, i can't" ? AppColors.appmaincolor : Colors.transparent,)
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
                    groupValue: step6subs.manage_stress == "No, i can't" ? 2 : 1,
                    onChanged: (val) {
                      setState(() {
                        _manageStress.text = "";
                        step6subs.manage_stress = "No, i can't";
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text("No, je n'y arrive pas",style: new TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
            ],
          ),
        ),
          onTap: (){
            setState(() {
              _manageStress.text = "";
              step6subs.manage_stress = "No, i can't";
            });
          },
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
