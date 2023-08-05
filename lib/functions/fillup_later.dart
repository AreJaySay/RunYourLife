import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/other_services/routes.dart';

class SignLater{
  final Routes _routes = new Routes();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();

  void signLater(context){
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Veuillez confirmer',style: TextStyle(fontFamily: "AppFontStyle"),),
            content: const Text('Êtes-vous sûr de vouloir remplir le formulaire plus tard ? Vous pouvez revenir le remplir plus tard.',style: TextStyle(fontFamily: "AppFontStyle"),),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  _screenLoaders.functionLoader(context);
                  _subscriptionServices.getInfos().whenComplete((){
                    Navigator.of(context).pop(null);
                    _routes.navigator_pushreplacement(context, Landing(), transitionType: PageTransitionType.fade);
                  });
                },
                child: const Text('Oui',style: TextStyle(fontFamily: "AppFontStyle"),),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Non',style: TextStyle(fontFamily: "AppFontStyle"),),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }
}

SignLater signLater = new SignLater();