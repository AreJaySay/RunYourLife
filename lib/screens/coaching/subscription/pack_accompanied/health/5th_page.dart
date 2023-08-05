import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step3_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class Health5thPage extends StatefulWidget {
  @override
  _Health5thPageState createState() => _Health5thPageState();
}

class _Health5thPageState extends State<Health5thPage> {
  TextEditingController _contraception = new TextEditingController()..text=step3subs.contraception == "Non" ||  step3subs.contraception == "none" || step3subs.contraception == "" ? "" : step3subs.contraception;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _contraception.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quel moyen de contraception utilises-tu".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: _contraception,
          maxLines: 4,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              border: InputBorder.none,
              hintText: "Moyen de contraception",
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
              step3subs.contraception = text;
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
