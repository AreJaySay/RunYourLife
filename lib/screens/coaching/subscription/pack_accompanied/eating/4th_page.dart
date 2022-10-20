import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

class Eating4thPage extends StatefulWidget {
  @override
  _Eating4thPageState createState() => _Eating4thPageState();
}

class _Eating4thPageState extends State<Eating4thPage> {
  TextEditingController _allergies = new TextEditingController()..text=step2subs.allergies == "No allergies" ? "" : step2subs.allergies;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _allergies.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("DES ALLERGIES ALIMENTAIRES ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: TextField(
            controller: _allergies,
            style: TextStyle(fontFamily: "AppFontStyle"),
            maxLines: 4,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                border: InputBorder.none,
                hintText: "Allergies alimentaire",
                hintStyle: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle")
            ),
            onChanged: (text){
              setState(() {
                step2subs.allergies = text;
              });
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ZoomTapAnimation(end: 0.99,child: Container(
            width: 220,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: step2subs.allergies == "No allergies" ? AppColors.appmaincolor : Colors.transparent,)
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
                      groupValue: step2subs.allergies == "No allergies" ? 2 : 1,
                      onChanged: (val) {
                        setState(() {
                          _allergies.text = "";
                          step2subs.allergies = "No allergies";
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text("Non,pas d'allergie.",style: new TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
              ],
            ),
          ),
          onTap: (){
            setState(() {
              _allergies.text = "";
              step2subs.allergies = "No allergies";
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
