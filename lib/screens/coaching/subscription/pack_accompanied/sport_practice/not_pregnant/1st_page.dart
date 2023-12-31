 import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import '../../../../../../../widgets/appbar.dart';
import '../../../../../../../widgets/materialbutton.dart';

class NotPregnant1stPage extends StatefulWidget {
  @override
  _NotPregnant1stPageState createState() => _NotPregnant1stPageState();
}

class _NotPregnant1stPageState extends State<NotPregnant1stPage> {
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();
  final AppBars _appBars = AppBars();
  List<String> _reasons = ["Je ne suis pas confiante en mes qualités sportives","Je ne trouve pas d'endroit dans lequel je suis à l'aise de pratiquer un sport","Je n'ai pas de place pour pratiquer","Je n'ai pas d'énergie pour pratiquer","Je n'ai pas le temps","Je n'ai pas de motivation / je ne suis pas certain(e) de l'importance que cela a pour moi"];
  List<double> _values = [step5subs.confident_on_athletic_ability,step5subs.comfortable_place,step5subs.place_to_practice,step5subs.energy_to_practice,step5subs.time,step5subs.motivation];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("POUR QUEL(S) RAISON(S) NE PRATIQUES-TU PAS DE SPORT ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 10,
        ),
        Text("1 : Ça n'a jamais été un obstacle\n5 : C'est très frequemment un obstacle",style: TextStyle(fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0; x < _reasons.length; x++)...{
          Text(_reasons[x].toUpperCase(), style: TextStyle(color: AppColors.appmaincolor, fontSize: 14,fontFamily: "AppFontStyle"),),
          Container(
            height: 60,
            child: FlutterSlider(
              values: [_values[x]],
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
                  child: Text(_values[x].floor().toString(), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                setState(() {
                  _values[x] = lowerValue;
                  if(x == 0){
                    step5subs.confident_on_athletic_ability = lowerValue;
                  }else if(x == 1){
                    step5subs.comfortable_place = lowerValue;
                  }else if(x == 2){
                    step5subs.place_to_practice = lowerValue;
                  }else if(x == 3){
                    step5subs.energy_to_practice = lowerValue;
                  }else if(x == 4){
                    step5subs.time = lowerValue;
                  }else{
                    step5subs.motivation = lowerValue;
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
        },
      ],
    );
  }
}
