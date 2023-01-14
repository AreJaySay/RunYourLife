import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

class Eating5thPage extends StatefulWidget {
  @override
  _Eating5thPageState createState() => _Eating5thPageState();
}

class _Eating5thPageState extends State<Eating5thPage> {
  TextEditingController _intolerance = new TextEditingController()..text=step2subs.intolerances == "Non" ? "" : step2subs.intolerances;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _intolerance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Est-ce que tu as des intolérances alimentaires ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: _intolerance,
          style: TextStyle(fontFamily: "AppFontStyle"),
          maxLines: 4,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            border: InputBorder.none,
            hintText: "Intolérances alimentaires",
            hintStyle: TextStyle(color: Colors.grey),
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
              step2subs.intolerances = text;
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
        ZoomTapAnimation(end: 0.99,child: Container(
            width: 230,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: step2subs.intolerances == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                      groupValue: step2subs.intolerances == "Non" ? 2 : 1,
                      onChanged: (val) {
                        setState(() {
                          _intolerance.text = "";
                          step2subs.intolerances = "Non";
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text("Non pas d'intolérance",style: new TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
              ],
            ),
          ),
          onTap: (){
            setState(() {
              _intolerance.text = "";
              step2subs.intolerances = "Non";
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