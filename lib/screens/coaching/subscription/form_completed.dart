import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/backbutton.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

class FormCompleted extends StatefulWidget {
  @override
  State<FormCompleted> createState() => _FormCompletedState();
}

class _FormCompletedState extends State<FormCompleted> {
  final AppBars _appBars = new AppBars();
  final ProfileServices _profileServices = new ProfileServices();
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Routes _routes = new Routes();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.preferredSize(height: 70,logowidth: 95),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageBackButton(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MERCI ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                      Text("POUR",style: TextStyle(fontSize: 23,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                  Text("TES RÉPONSES",style: TextStyle(fontSize: 23,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Tes réponses vont être transmises au coach qui prendra contact avec toi pour démarrer le coaching.",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _materialbutton.materialButton("TERMINER LE FORMULAIRE", () {
                _screenLoaders.functionLoader(context);
                _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString()).whenComplete((){
                  Navigator.of(context).pop(null);
                    _routes.navigator_pushreplacement(context, Landing(), transitionType: PageTransitionType.fade);
                });
              }),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
