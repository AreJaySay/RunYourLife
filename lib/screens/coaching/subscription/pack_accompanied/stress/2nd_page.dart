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
  List _manage = ["Oui rapidement","Oui mais difficilement","Non, je n'y arrive pas "];
  final TextEditingController _manageStress = new TextEditingController()..text=step6subs.manage_stress == "Non, je ne peux pas" ? "" : step6subs.manage_stress;

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
        Text("Es-tu stressé(e) à la maison".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Text("1 : Je suis serein(e) à la maison\n3: Modéremment\n5 : Je suis toujours sous pression à la maison",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
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
        Text("Quand tu te sens très stressé(e)  (par exemple quand tu es en colère ou anxieux), arrives tu à trouver des moyens qui t'apaisent ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        for(var x = 0 ;x < _manage.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: step6subs.manage_stress == _manage[x] ? AppColors.appmaincolor : Colors.transparent,)
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
                            color: step6subs.manage_stress == _manage[x] ? AppColors.appmaincolor : Colors.white,
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      step6subs.manage_stress = _manage[x];
                    });
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(_manage[x], style: new TextStyle(fontSize: 15,
                      color: Colors.black,fontFamily: "AppFontStyle"),),
                ),
              ],
            ),
          ),
            onTap: (){
              setState(() {
                step6subs.manage_stress = _manage[x];
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
