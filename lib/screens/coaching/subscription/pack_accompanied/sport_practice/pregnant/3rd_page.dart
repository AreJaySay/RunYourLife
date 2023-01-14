import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class Pregnant3rdPage extends StatefulWidget {
  @override
  _Pregnant3rdPageState createState() => _Pregnant3rdPageState();
}

class _Pregnant3rdPageState extends State<Pregnant3rdPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Est ce que tu récupères assez de tes entraînements ? Continues-tu à progresser".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Text("1: mauvaise récupération = j'ai souvent peu d'énergie, à cause de celà j'ai du mal à m'entrainer plus. Cette fatigue dure souvent plus de 2 jours après une session d'entrainement normale\n5: bonne récupération = je sens que j'ai toujours récupéré à 100 % et je continue de progresser à l'entrainement",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        // SizedBox(
        //   height: 10,
        // ),
        // Text("echelle de 1 à 5\n1: mauvaise récupération\n3: récupération modérée\n5: super récupération",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 60,
          child: FlutterSlider(
            values: [step5subs.training_recovery],
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
                child: Text(step5subs.training_recovery.floor().toString(),
                  style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                step5subs.training_recovery = lowerValue;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
