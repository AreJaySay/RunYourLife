import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/services/stream_services/subscriptions/update_data.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';
import '../../../utils/snackbars/snackbar_message.dart';


class SubscriptionServices{
  final NetworkUtility _networkUtility = new NetworkUtility();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();

  Future getInfos()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/subscriptions/${subscriptionDetails.currentdata[0]["id"].toString()}"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200){
          subStreamServices.addSubs(data: data == null ? {} : data);
          return data["client_info"];
        }else{
          return null;
        }
      });
    } catch (e) {
      
    }
  }

  Future update(context,{required String model, required Map? data})async{
    try {
      return await http.put(Uri.parse("${_networkUtility.url}/user/api/subscriptions/update_form/${model}"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
          body: data
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("UPDATE ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      Navigator.of(context).pop(null);
      print(e.toString());
    }
  }

  // CANCEL SUBSCRIPTION
  Future cancelSubscription(context,{required String subs_id})async{
    try{
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/instant-cancel-subscription"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
          body: {
            "subscription_id": subs_id,
          }
      ).then((data)async{
        var respo = json.decode(data.body);
        print("CANCEL SUBSCRIPTION ${respo.toString()}");
        if(data.statusCode == 200 || data.statusCode == 201){
          return respo;
        }else{
          Navigator.of(context).pop(null);
          _snackbarMessage.snackbarMessage(context, message: respo['message'], is_error: true);
        }
      });
    }catch(e){
      Navigator.of(context).pop(null);
      print("ERROR CANCEL SUBSCRIPTION ${e.toString()}");
    }
  }
}