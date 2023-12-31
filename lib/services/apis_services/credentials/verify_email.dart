import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/screens/credentials/components/account_created.dart';
import 'package:run_your_life/screens/credentials/login.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../screens/credentials/components/forgot_password/components/email_sent.dart';
import '../../../../utils/snackbars/snackbar_message.dart';
import '../../other_services/http_requests.dart';
import '../../other_services/routes.dart';

class VerifyEmailServices{
  final HttpRequest _request =  HttpRequest.instance;
  final Routes _routes = new Routes();
  final NetworkUtility _networkUtility = new NetworkUtility();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();

  Future code(context,{String? token})async{
    try{
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/validate_email"),
          headers: _request.defaultHeader,
          body: {
            "token": token,
          }
      ).then((data)async{
        var respo = json.decode(data.body);
        if(data.statusCode == 200 || data.statusCode == 201){
          _routes.navigator_pushreplacement(context, AccountCreated());
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