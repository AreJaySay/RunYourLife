// import 'package:flutter/material.dart';
// import 'package:run_your_life/models/subscription_models/step4_subs.dart';
// import 'package:run_your_life/utils/palettes/app_colors.dart';
// import 'package:run_your_life/services/other_services/routes.dart';
// import '../../../../../../widgets/appbar.dart';
// import 'package:run_your_life/widgets/materialbutton.dart';
// import '../../../../../../widgets/textfields.dart';
//
// class Objective3rdPage extends StatefulWidget {
//   @override
//   _Objective3rdPageState createState() => _Objective3rdPageState();
// }
//
// class _Objective3rdPageState extends State<Objective3rdPage> {
//   TextEditingController _weight = new TextEditingController()..text=step4subs.date_to_reach_goal;
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _weight.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Quelle est la date pour atteindre votre objectif ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
//         SizedBox(
//           height: 15,
//         ),
//         Text("Débutant : 11 à 16 mois \nIntermédiaire : 22 à 33 mois \nAvancé : 44 à 66 mois",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
//         SizedBox(
//           height: 20,
//         ),
//         TextFields(_weight, hintText: "poids (kg)",onChanged: (text){
//           setState(() {
//             step4subs.date_to_reach_goal = text;
//           });
//         },),
//         SizedBox(
//           height: 50,
//         ),
//       ],
//     );
//   }
// }
