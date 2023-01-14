import 'dart:convert';
import 'dart:io';

import 'package:run_your_life/extensions/string.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/objective.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/utils/network_util.dart';

class ObjectiveServices {
  // final Auth auth = Auth();
  final NetworkUtility _netUtil = NetworkUtility();
  Future<List<Objective>?> get() async {
    try {
      return await http.get(
        "${_netUtil.api}/objective".toUri,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((response) {
        if(response.statusCode == 200 || response.statusCode == 201){
          var data = json.decode(response.body);
          final List dd = data["data"];

          return dd.map((e) => Objective.fromJson(e)).toList();

          return [];

        }
        return null;
      });
    } catch (e) {
      print("ERROR : $e");
      return null;
    }
  }
  // OBJECTIVES STATUS
  Future changeStatus({required String id, required String status})async{
    try {
      return await http.post(Uri.parse("${_netUtil.url}/user/api/objective/ChangeStatus"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "id": id,
          "to": status,
        }
      ).then((respo) async {
        var data = json.decode(respo.body);
        print(data.toString());
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }
  // DOCUMENTS STATUS
  // Future docStatus({required String id, required String status})async{
  //   try {
  //     return await http.post(Uri.parse("${_netUtil.url}/user/api/objective/ChangeStatus"),
  //         headers: {
  //           HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
  //           "Accept": "application/json"
  //         },
  //         body: {
  //           "id": id,
  //           "to": status,
  //         }
  //     ).then((respo) async {
  //       var data = json.decode(respo.body);
  //       print(data.toString());
  //       if (respo.statusCode == 200 || respo.statusCode == 201){
  //         return data;
  //       }else{
  //         return null;
  //       }
  //     });
  //   } catch (e) {
  //     print("ERROR GET BLOGS ${e.toString()}");
  //   }
  // }
}
