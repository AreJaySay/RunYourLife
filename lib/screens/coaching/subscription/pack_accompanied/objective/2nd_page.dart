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
  TextEditingController _level = new TextEditingController();

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
          height: 30,
        ),
        // step4subs.goal == "Perdre du poids (Tu veux perdre au moins 5 kg)" || step4subs.goal == "Construire du muscle (tu veux construire du muscle et augmenter ton poids de corps)"  ?
        TextFields(_weight, hintText: "Poids (kg)",onChanged: (text){
          setState(() {
            step4subs.desired_weight = text;
          });
        },),
        //     :
        // TextFields(_level, hintText: "Niveau de sport",onChanged: (text){
        //   setState(() {
        //     // step4subs.desired_weight = text;
        //   });
        // },),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}
