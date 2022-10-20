import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../widgets/textfields.dart';

class Eating8thPage extends StatefulWidget {
  @override
  _Eating8thPageState createState() => _Eating8thPageState();
}

class _Eating8thPageState extends State<Eating8thPage> {
  TextEditingController _coffee = new TextEditingController()..text=step2subs.coffee_per_day == "I never drink coffee" ? "" : step2subs.coffee_per_day;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _coffee.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("COMBIEN DE CAFÉ PAR JOUR ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        TextFields(_coffee,hintText: "Café/jour",onChanged: (text){
          setState(() {
            step2subs.coffee_per_day = text;
          });
        },inputType: TextInputType.number,),
        SizedBox(
          height: 30,
        ),
        ZoomTapAnimation(end: 0.99,child: Container(
            width: 250,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: step2subs.coffee_per_day == "I never drink coffee" ? AppColors.appmaincolor : Colors.transparent,)
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
                      groupValue: step2subs.coffee_per_day == "I never drink coffee" ? 2 : 1,
                      onChanged: (val) {
                        setState(() {
                          _coffee.text = "";
                          step2subs.coffee_per_day = "I never drink coffee";
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('Je ne bois jamais de café',style: new TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
              ],
            ),
          ),
          onTap: (){
            setState(() {
              _coffee.text = "";
              step2subs.coffee_per_day = "I never drink coffee";
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}