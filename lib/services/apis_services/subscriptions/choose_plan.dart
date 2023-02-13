import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';
import '../../../../utils/snackbars/snackbar_message.dart';

class ChoosePlanService{
  final NetworkUtility _networkUtility = new NetworkUtility();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();

  // SUBSCRIPTION
  Future choosePlan(context,{required String planid, required String purchaseToken, required String type, required String transacId})async{
    try{
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/add-subscription"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
          body: {
            "plan_id": planid,
            "purchaseToken": purchaseToken,
            "packageName": "com.runyourlife4.runyourlife",
            "transactionId": transacId,
            "payment_method": type,
          }
      ).then((data)async{
        var respo = json.decode(data.body);
        print("RETURN ${respo.toString()}");
        if(data.statusCode == 200 || data.statusCode == 201){
          return respo;
        }else{
          Navigator.of(context).pop(null);
          _snackbarMessage.snackbarMessage(context, message: respo['message'], is_error: true);
        }
      });
    }catch(e){
      Navigator.of(context).pop(null);
      print("ERROR SUBS ${e.toString()}");
    }
  }

  // UPGRADE SUBSCRIPTION
  Future upgrade(context,{required String planid, required String purchaseToken, required String type, required String transacId})async{
    try{
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/add-subscription"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
          body: {
            "plan_id": planid,
            "purchaseToken": purchaseToken,
            "packageName": "com.runyourlife4.runyourlife",
            "transactionId": transacId,
            "payment_method": type,
          }
      ).then((data)async{
        var respo = json.decode(data.body);
        print("RETURN ${respo.toString()}");
        if(data.statusCode == 200 || data.statusCode == 201){
          return respo;
        }else{
          Navigator.of(context).pop(null);
          _snackbarMessage.snackbarMessage(context, message: respo['message'], is_error: true);
        }
      });
    }catch(e){
      Navigator.of(context).pop(null);
      print("ERROR UPGRADE ${e.toString()}");
    }
  }
}