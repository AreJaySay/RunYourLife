import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step4_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class Objective6thPage extends StatefulWidget {
  @override
  _Objective6thPageState createState() => _Objective6thPageState();
}

class _Objective6thPageState extends State<Objective6thPage> {
  List<String> _reasons = ["Je ne sais pas quoi manger","je ne connais pas la quantité à manger","Je ne prépare pas mes repas ou ne planifie pas mes repas","Je n'ai pas le temps de cuisiner","Je bois de l'alcool","J'ai des envies compulsives de manger sucrées et/ou salées","Je mange pour combler un manque émotionnel ou quand je suis stressé.e","Je mange même quand je n'ai pas faim","Je ne me sens jamais rassasié.e, j'ai toujours faim","Je n'ai pas faim","Je me sens coupable / J'ai honte de manger","Je n'ai pas accès à de la nourriture saine"];
  List<double> _values = [step4subs.what_to_eat,step4subs.how_much_to_eat,step4subs.plan_meals,step4subs.time_to_cook,step4subs.drink_alcohol,step4subs.cravings,step4subs.emotional_void,step4subs.eat_when_not_hungry,step4subs.always_hungry,step4subs.not_hungry,step4subs.guilty_to_eat,step4subs.access_to_healthy_food];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Qu'est ce qui t'empêche d'atteindre cet objectif ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Text("1 : ça n'a jamais été un obstacle \n5 : c'est très fréquemment un obstacle",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 25,
        ),
        for(var x = 0; x < _reasons.length; x++)...{
          Text(_reasons[x].toUpperCase(),
            style: TextStyle(color: AppColors.appmaincolor,
                fontSize: 14,fontFamily: "AppFontStyle"),),
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
                  child: Text(_values[x].floor().toString(),
                    style: TextStyle(color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                _values[x] = lowerValue;
                setState(() {
                  if(x == 0){
                    step4subs.what_to_eat = lowerValue;
                  }else if(x == 1){
                    step4subs.how_much_to_eat = lowerValue;
                  }else if(x == 2){
                    step4subs.plan_meals = lowerValue;
                  }else if(x == 3){
                    step4subs.time_to_cook = lowerValue;
                  }else if(x == 4){
                    step4subs.drink_alcohol = lowerValue;
                  }else if(x == 5){
                    step4subs.cravings = lowerValue;
                  }else if(x == 6){
                    step4subs.emotional_void = lowerValue;
                  }else if(x == 7){
                    step4subs.eat_when_not_hungry = lowerValue;
                  }else if(x == 8){
                    step4subs.always_hungry = lowerValue;
                  }else if(x == 9){
                    step4subs.not_hungry = lowerValue;
                  }else if(x == 10){
                    step4subs.guilty_to_eat = lowerValue;
                  }else{
                    step4subs.access_to_healthy_food = lowerValue;
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
