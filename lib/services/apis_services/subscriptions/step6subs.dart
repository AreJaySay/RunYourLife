import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/models/subscription_models/step6_subs.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';


class Step6Service{
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future submit(context,{bool isFillLater = false})async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/subscriptions/stress"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
          body: step6subs.toMap()
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("STRESS ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          Navigator.of(context).pop(null);
          return null;
        }
      });
    } catch (e) {
      print(e.toString());
      Navigator.of(context).pop(null);
    }
  }
}