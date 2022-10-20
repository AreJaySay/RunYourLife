import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import '../../../models/auths_model.dart';
import '../../../utils/network_util.dart';


class Step1Service{
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future submit(context,)async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/subscriptions/basic_info"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
          body: step1subs.toMap()
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("BASIC ${data.toString()}");
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
}