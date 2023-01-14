import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
class Eating11thPage extends StatefulWidget {
  @override
  _Eating11thPageState createState() => _Eating11thPageState();
}

class _Eating11thPageState extends State<Eating11thPage> {
  List<String> _hintTexts = ['Petit dej:',"Encas matinale:","Dejeuner:","Encas arpès-midi:","Diner"];
  List<TextEditingController> _controllers = [TextEditingController()..text=step2subs.breakfast,TextEditingController()..text=step2subs.morning_snack,TextEditingController()..text=step2subs.lunch,TextEditingController()..text=step2subs.afternoon_snack,TextEditingController()..text=step2subs.dinner,];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for(int x = 0; x < _controllers.length; x++){
      _controllers[x].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Peux-tu me décrire une journée type de ton repas de la veille ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        // Text("Complète uniquement les champs qui te concernent.",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        // SizedBox(
        //   height: 20,
        // ),
        for(var x = 0; x < _hintTexts.length;x++)...{
          TextField(
            controller: _controllers[x],
            maxLines: 3,
            style: TextStyle(fontFamily: "AppFontStyle"),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                border: InputBorder.none,
                hintText: _hintTexts[x],
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
                if(x == 0){
                  step2subs.breakfast = text;
                }else if(x == 1){
                  step2subs.morning_snack = text;
                }else if(x == 2){
                  step2subs.lunch = text;
                }else if(x == 3){
                  step2subs.afternoon_snack = text;
                }else{
                  step2subs.dinner = text;
                }
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
        },
      ],
    );
  }
}
