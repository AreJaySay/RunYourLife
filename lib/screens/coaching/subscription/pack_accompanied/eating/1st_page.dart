import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../../widgets/textfields.dart';

class Eating1stPage extends StatefulWidget {
  @override
  _Eating1stPageState createState() => _Eating1stPageState();
}

class _Eating1stPageState extends State<Eating1stPage> {
  TextEditingController _mealday = new TextEditingController()..text=step2subs.meals_per_day;
  List<String> _preferences = ["Végétarienne","Complétement baseé sur les plantés/Vegan","Méditerranéenne","Paleo","Cétogène","Non/Aucune"];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mealday.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Combien de repas manges-tu généralement par jour ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        TextFields(_mealday,hintText: "Nombre de repas / jour",onChanged: (text){
          setState(() {
            step2subs.meals_per_day = text;
          },);
        },inputType: TextInputType.number,),
        SizedBox(
          height: 40,
        ),
        Text("AS-TU UNE PRÉFÉRENCE ALIMENTAIRE ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        for(var x = 0 ;x < _preferences.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step2subs.food_preference == _preferences[x] ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
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
                            color: step2subs.food_preference == _preferences[x] ? AppColors.appmaincolor : Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(_preferences[x], style: new TextStyle(fontSize: 15,
                          color: Colors.black,fontFamily: "AppFontStyle"),),
                    ),
                  ],
                ),
              ),
            ),
            onTap: (){
              setState(() {
                step2subs.food_preference = _preferences[x];
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