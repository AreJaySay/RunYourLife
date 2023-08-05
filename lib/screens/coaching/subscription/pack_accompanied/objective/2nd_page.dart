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
          height: 10,
        ),
        // Text(step4subs.goal == "Perdre du poids (Tu veux perdre au moins 5 kg)" ? "for (une perte de poids)\n- Confortable : 9 à 18 semaines\n- Raisonnable : 4 à 9 semaines\n- Extrême : 3 à 4 semaines" : "for (une prise de masse musculaire, niveau sportif)\n- Débutant : 11 à 16 mois\n- Intermédiaire : 22 à 33 mois\n- Avancé : 44 à 66 moi",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        // SizedBox(
        //   height: 10,
        // ),
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
