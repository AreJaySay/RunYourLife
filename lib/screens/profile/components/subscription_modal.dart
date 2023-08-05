import 'package:flutter/material.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../../../services/apis_services/screens/checkin.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../utils/palettes/app_colors.dart';

class SubscriptionModal extends StatefulWidget {
  @override
  State<SubscriptionModal> createState() => _SubscriptionModalState();
}

class _SubscriptionModalState extends State<SubscriptionModal> {
  final Materialbutton _materialbutton = new Materialbutton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      child: Column(
        children: [
          Text("Étant donné que votre abonnement a été pris sur le store, pour switcher sur l’abonnement 100% suivi il vous faut le faire dans la gestion de vos abonnements (dans les paramètres de votre téléphone).",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFont"),textAlign: TextAlign.center,),
          Spacer(),
          _materialbutton.materialButton("D'accord".toUpperCase(), () {
            Navigator.of(context).pop(null);
          },bckgrndColor: AppColors.appmaincolor, textColor: Colors.white),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
