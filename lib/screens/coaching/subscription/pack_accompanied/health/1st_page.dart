import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step3_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Health1stPage extends StatefulWidget {
  @override
  _Health1stPageState createState() => _Health1stPageState();
}

class _Health1stPageState extends State<Health1stPage> {
  TextEditingController _medical = new TextEditingController()..text=step3subs.medical_history == "Non" ? "" : step3subs.medical_history;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _medical.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("As-tu des antécédents médicaux".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: _medical,
          maxLines: 4,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              border: InputBorder.none,
              hintText: "Antécédents médicaux",
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
              step3subs.medical_history = text;
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
        ZoomTapAnimation(end: 0.99,child: Container(
            width: 130,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: step3subs.medical_history == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                      groupValue: step3subs.medical_history == "Non" ? 2 : 1,
                      onChanged: (val) {
                        setState(() {
                          _medical.text = "";
                          step3subs.medical_history = "Non";
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('Non',style: new TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
              ],
            ),
          ),
          onTap: (){
            setState(() {
              _medical.text = "";
              step3subs.medical_history = "Non";
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
