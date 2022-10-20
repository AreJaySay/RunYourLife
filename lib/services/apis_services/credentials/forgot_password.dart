import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/screens/credentials/login.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../screens/credentials/components/forgot_password/components/email_sent.dart';
import '../../../../utils/snackbars/snackbar_message.dart';
import '../../other_services/http_requests.dart';
import '../../other_services/routes.dart';

class ForgotPasswordServices{
  final Routes _routes = new Routes();
  final HttpRequest _request =  HttpRequest.instance;
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future enter_email(context,{String? email})async{
    try{
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/forgot_password"),
          headers: _request.defaultHeader,
          body: {
            "email": email,
          }
      ).then((data)async{
        var respo = json.decode(data.body);
        print("EMAIL ${respo.toString()}");
        if(data.statusCode == 200 || data.statusCode == 201){
          _routes.navigator_pushreplacement(context, EmailSent());
        }else{
          Navigator.of(context).pop(null);
          _snackbarMessage.snackbarMessage(context, is_error: true, message: respo["message"]);
        }
      });
    }catch(e){
      print("ERROR ${e.toString()}");
    }
  }

  Future reset_password(context,{String? token, String? newpass})async{
    try{
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/reset_password"),
          headers: _request.defaultHeader,
          body: {
            "token": token,
            "new_password": newpass,
          }
      ).then((data)async{
        var respo = json.decode(data.body);
        print("RETURN ${data.body.toString()}");
        if(data.statusCode == 200 || data.statusCode == 201){
          _snackbarMessage.snackbarMessage(context, message: "Votre mot de passe a été changé avec succès.");
          _routes.navigator_pushreplacement(context, Login(), transitionType: PageTransitionType.leftToRightWithFade);
        }else{
          Navigator.of(context).pop(null);
          _snackbarMessage.snackbarMessage(context, is_error: true, message: respo["message"]);
        }
      });
    }catch(e){
      print("ERROR ${e.toString()}");
    }
  }
}