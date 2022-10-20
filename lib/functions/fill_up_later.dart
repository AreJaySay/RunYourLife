import 'package:flutter/cupertino.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/other_services/routes.dart';

class FillUpLater{
  final Routes _routes = new Routes();

  Future fillupLater(context)async{
    credentialsServices.login(context, email: Auth.email!, password: Auth.pass!).then((value){
      if(value != null){
        _routes.navigator_pushreplacement(context, Landing());
      }else{
        Navigator.of(context).pop(null);
      }
    });
  }
}