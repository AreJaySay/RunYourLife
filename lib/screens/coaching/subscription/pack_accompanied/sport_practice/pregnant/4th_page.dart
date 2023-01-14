import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class Pregnant4thPage extends StatefulWidget {
  @override
  _Pregnant4thPageState createState() => _Pregnant4thPageState();
}

class _Pregnant4thPageState extends State<Pregnant4thPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Si tu ne peux pas faire ton entrainement du jour (pas le temps, équipement, ...) que fais-tu généralement ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Text("1 :j'adapte rarement =  j'abandonne l'entrainement du jour\n5 : j'adapte forcément = je trouverais quelque chose en substitution pour rester active/actif",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        // SizedBox(
        //   height: 10,
        // ),
        // Text("1 : j'adapte rarement \n3 : modéremment\n5: j'adapte forcément ",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 60,
          child: FlutterSlider(
            values: [step5subs.no_training_day],
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
                child: Text(step5subs.no_training_day.floor().toString(),
                  style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                step5subs.no_training_day = lowerValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
