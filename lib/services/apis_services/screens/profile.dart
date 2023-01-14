import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/notifications.dart';
import 'package:run_your_life/services/stream_services/screens/profile.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/network_util.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import '../../../models/auths_model.dart';
import '../../../screens/welcome.dart';
import '../../stream_services/screens/blogs.dart';

class ProfileServices{
  final NetworkUtility _networkUtility = new NetworkUtility();
  final Routes _routes = new Routes();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();

  Future getProfile({required String clientid, String relation = "activeSubscription"})async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/clients/$clientid?relations=$relation"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          Auth.loggedUser = data;
          Auth.isNotSubs = data["active_subscription"].toString() == "[]" ? true : false;
          profileStreamServices.update(data: data);
          if(relation == "notifications"){
            notificationServices.update(data: data["notifications"]);
          }else{
            subscriptionDetails.updateSubs(data: data["active_subscription"]);
          }
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  Future sendCode()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/clients/send_delete_code"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("SEND CODE ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
    }
  }

  Future VerifyCode(context,{required String code})async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/clients/delete"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "code": code,
        }
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("VERIFY CODE ${data.toString()}");
        if(respo.statusCode == 500 || respo.statusCode == 400){
          _snackbarMessage.snackbarMessage(context, message: "Code invalide, veuillez vérifier et réessayer !", is_error: true);
          Navigator.of(context).pop(null);
        }else{
          _routes.navigator_pushreplacement(context, Welcome());
        }
      });
    } catch (e) {
    }
  }
}