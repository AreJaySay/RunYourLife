import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../../widgets/textfields.dart';

class Eating3rdPage extends StatefulWidget {
  @override
  _Eating3rdPageState createState() => _Eating3rdPageState();
}

class _Eating3rdPageState extends State<Eating3rdPage> {
  TextEditingController _calories = new TextEditingController()..text=step2subs.calories_today == "No I don't stalk" ? "" : step2subs.calories_today;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _calories.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Si aujourd'hui tu traques tes calories, quel est le total journalier".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        TextFields(_calories,hintText: "Calories/jour",onChanged: (text){
          setState(() {
            step2subs.calories_today = text;
          },);
        },inputType: TextInputType.number,),
        SizedBox(
          height: 20,
        ),
        ZoomTapAnimation(end: 0.99,child: Container(
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: step2subs.calories_today == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                    groupValue: step2subs.calories_today == "Non" ? 2 : 1,
                    onChanged: (val) {
                      setState(() {
                        _calories.text = "";
                        step2subs.calories_today = "Non";
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text("Non je ne traque pas",style: new TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
            ],
          ),
        ),
          onTap: (){
            setState(() {
              _calories.text = "";
              step2subs.calories_today = "Non";
            });
          },
        ),
        SizedBox(
          height: 80,
        ),
      ],
    );
  }
}