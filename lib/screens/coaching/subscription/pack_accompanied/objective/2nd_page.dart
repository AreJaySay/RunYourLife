import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step4_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../../widgets/textfields.dart';

class Objective2ndPage extends StatefulWidget {
  @override
  _Objective2ndPageState createState() => _Objective2ndPageState();
}

class _Objective2ndPageState extends State<Objective2ndPage> {
  TextEditingController _weight = new TextEditingController()..text=step4subs.desired_weight;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _weight.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quel est ton poids désiré ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Text("Selon ton niveau sportif\nDébutant : 11 à 16 mois\nntermédiaire : 22 à 33 mois\nAvancé : 44 à 66 mois",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 30,
        ),
        TextFields(_weight, hintText: "poids (kg)",onChanged: (text){
          setState(() {
            step4subs.desired_weight = text;
          });
        },),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
