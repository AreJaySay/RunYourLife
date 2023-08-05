import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../../../models/subscription_models/step4_subs.dart';

class Objective4thPage extends StatefulWidget {
  @override
  _Objective4thPageState createState() => _Objective4thPageState();
}

class _Objective4thPageState extends State<Objective4thPage> {
  DateTime _selectedDate = DateTime.now().toUtc().add(Duration(hours: 2));
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('fr'),
        initialDate:  DateTime.now().toUtc().add(Duration(hours: 2)),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        step4subs.date_to_reach_goal = selectedDate.toString();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(step4subs.date_to_reach_goal != ""){
    step4subs.date_to_reach_goal = _selectedDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("QUEL DÉLAI TU T'ACCORDES POUR ATTEINDRE TON OBJECTIF?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 10,
        ),
        step4subs.goal == "Perdre du poids (Tu veux perdre au moins 5 kg)" ?
        Text("Pour une perte de poids :\n- Confortable : 9 à 18 semaines\n- Raisonnable : 4 à 9 semaines\n- Extrême : 3 à 4 semaines",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),) :
        step4subs.goal == "Construire du muscle (tu veux construire du muscle et augmenter ton poids de corps)" ?
        Text("Pour une prise de masse musculaire, niveau sportif :\n- Débutant : 11 à 16 mois\n- Intermédiaire : 22 à 33 mois\n- Avancé : 44 à 66 mois",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),) :
        Container(),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Text(selectedDate == null ? "Date" : DateFormat("dd/MM/yyyy").format(DateTime.parse(selectedDate.toString())) ,style: TextStyle(color: selectedDate == null ? Colors.grey : Colors.black,fontFamily: "AppFontStyle",fontSize: 15.5),),
          ),
          onTap: (){
            _selectDate(context);
          },
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}