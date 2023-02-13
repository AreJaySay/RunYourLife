import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

class Eating6thPage extends StatefulWidget {
  @override
  _Eating6thPageState createState() => _Eating6thPageState();
}

class _Eating6thPageState extends State<Eating6thPage> {
  TextEditingController _religion = new TextEditingController()..text=step2subs.cultural_adaptations_diet == "Non" || step2subs.cultural_adaptations_diet == "none" || step2subs.cultural_adaptations_diet == "N/A" ? "" : step2subs.cultural_adaptations_diet;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _religion.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Est-ce que tu as des adaptations de ton alimentation lieés à une religion ou culture ou conviction ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _religion,
          style: TextStyle(fontFamily: "AppFontStyle"),
          maxLines: 4,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              border: InputBorder.none,
              hintText: "Adaptation alimentaire",
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appmaincolor),
                  borderRadius: BorderRadius.circular(10)
              ),
          ),
          onChanged: (text){
            setState(() {
              step2subs.cultural_adaptations_diet = text;
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
        ZoomTapAnimation(end: 0.99,child: Container(
            width: 150,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: step2subs.cultural_adaptations_diet == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                      groupValue: step2subs.cultural_adaptations_diet == "Non" ? 2 : 1,
                      onChanged: (val) {
                        setState(() {
                          _religion.text = "";
                          step2subs.cultural_adaptations_diet = "Non";
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('Aucun',style: new TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
              ],
            ),
          ),
          onTap: (){
            setState(() {
              _religion.text = "";
              step2subs.cultural_adaptations_diet = "Non";
            });
          },
        ),
        SizedBox(
          height: 70,
        ),
      ],
    );
  }
}