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

  Future choosePlan(context,{required Map planDetails, required String code, required String card_number, required String expiration_date_month, required String expiration_date_year, required String cvc})async{
    try{
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/test-payment"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
          body: {
            "client_id": Auth.loggedUser!['id'].toString(),
            "plan_id": planDetails["id"].toString(),
            "price_id": planDetails["prices"][planDetails["prices"].length - 1]["id"].toString(),
            "price_code": planDetails["prices"][planDetails["prices"].length - 1]["stripe_id"].toString(),
            "code": code.toString(),
            "card_number": card_number.toString(),
            "expiration_date_month": expiration_date_month.toString(),
            "expiration_date_year": expiration_date_year.toString(),
            "cvc": cvc.toString()
          }
      ).then((data)async{
        var respo = json.decode(data.body);
        print("RETURN ${respo.toString()}");
        if(data.statusCode == 200 || data.statusCode == 201){
          return respo;
        }else{
          Navigator.of(context).pop(null);
          _snackbarMessage.snackbarMessage(context, message: respo['message']);
        }
      });
    }catch(e){
      Navigator.of(context).pop(null);
      print("ERROR SUBS ${e.toString()}");
    }
  }

}