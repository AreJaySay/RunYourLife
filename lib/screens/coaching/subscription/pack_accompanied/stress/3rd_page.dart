import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step6_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Stress3rdPage extends StatefulWidget {
  @override
  _Stress3rdPageState createState() => _Stress3rdPageState();
}

class _Stress3rdPageState extends State<Stress3rdPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Arrives-tu à prévoir tes journées (plutôt que de répondre à des demandes non prévues)".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Text("1: Jamais = Je n'arrive pas à prévoir mes journées, je suis sans cesse en train d'éteindre les feux de tout le monde, je réponds aux demandes des gens qui m'envoient dans toutes les directions\n3 :Modéremment\n5 : Toujours = mes journées sont bien ordonnées, j'ai le contrôle de ma place et mon attention et j'ai un plan pour executer cela chaque jour",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 60,
          child: FlutterSlider(
            values: [step6subs.plan_your_day],
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
                child: Text(step6subs.plan_your_day.floor().toString(),
                  style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                step6subs.plan_your_day = lowerValue;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}