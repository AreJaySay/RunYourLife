import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/services/stream_services/screens/parameters.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';
import '../../../models/screens/profile/parameters.dart';

class ParameterServices{
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future submit(context)async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/clients/add_settings"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
          body: parameters.toMap()
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("PARAMETERS ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      // Navigator.of(context).pop(null);
      print("ERROR SETTING${e.toString()}");
    }
  }

  Future getSetting()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/clients/settings"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("SETTING ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          parameterStreamServices.update(data: data["data"]);
          return data["data"];
        }else{
          parameterStreamServices.update(data: {});
        }
      });
    } catch (e) {
      parameterStreamServices.update(data: {});
    }
  }
}