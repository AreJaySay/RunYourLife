import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step6_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Stress4thPage extends StatefulWidget {
  @override
  _Stress4thPageState createState() => _Stress4thPageState();
}

class _Stress4thPageState extends State<Stress4thPage> {
  List<String> _spendoutside = [
    "<3 min",
    "3-4 min",
    "5-8 min (<1hour/week)",
    "9-16 min (1-2 h/week)",
    " + de 17 min (2h/week)"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Combien de temps passez-vous dehors chaque jour ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0 ;x < _spendoutside.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: step6subs.time_outside_per_day == _spendoutside[x] ? AppColors.appmaincolor : Colors.transparent,)
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
                            color: step6subs.time_outside_per_day == _spendoutside[x] ? AppColors.appmaincolor : Colors.white,
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      step6subs.time_outside_per_day = _spendoutside[x];
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(_spendoutside[x],style: new TextStyle(fontSize: 15,
                      color: Colors.black,fontFamily: "AppFontStyle"),),
                ),
              ],
            ),
          ),
            onTap: (){
              setState(() {
                 step6subs.time_outside_per_day = _spendoutside[x];
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