import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Eating10thPage extends StatefulWidget {
  @override
  _Eating10thPageState createState() => _Eating10thPageState();
}

class _Eating10thPageState extends State<Eating10thPage> {
  TextEditingController _supplement = new TextEditingController()..text=step2subs.food_supplement == "Non" || step2subs.food_supplement == "none" || step2subs.food_supplement == "" ? "" : step2subs.food_supplement;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _supplement.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Prends-tu des suppléments alimentaires (oméga 3, protéine en poudre, probotiques, enzymes digestives, calcium, créatine, BCAA, pre/post workout, multivitamines ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _supplement,
          maxLines: 4,
          style: TextStyle(fontFamily: "AppFontStyle"),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              border: InputBorder.none,
              hintText: "Compléments alimentaires",
              hintStyle: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),
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
              step2subs.food_supplement = text;
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
        ZoomTapAnimation(end: 0.99,child: Container(
            width: 310,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: step2subs.food_supplement == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                      groupValue: step2subs.food_supplement == "Non" ? 2 : 1,
                      onChanged: (val) {
                        setState(() {
                          _supplement.text = "";
                          step2subs.food_supplement = "Non";
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('Aucun complément alimentaire',style: new TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
              ],
            ),
          ),
            onTap: (){
              setState(() {
                _supplement.text = "";
                step2subs.food_supplement = "Non";
              });
            }
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
