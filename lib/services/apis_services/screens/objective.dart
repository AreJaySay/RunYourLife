import 'dart:convert';
import 'dart:io';

import 'package:run_your_life/extensions/string.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/objective.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/utils/network_util.dart';

import '../../../data_component/objective_vm.dart';

class ObjectiveServices {
  final NetworkUtility _netUtil = NetworkUtility();

  Future get() async {
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
          print("OBJECTIVE  ${data}");
          return data;
        }
        return null;
      });
    } catch (e) {
      print("ERROR OBJECTIVE : $e");
      return null;
    }
  }

  Future get_programmation() async {
    try {
      return await http.get(
        "${_netUtil.api}/obj_programmation".toUri,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((response) {
        if(response.statusCode == 200 || response.statusCode == 201){
          var data = json.decode(response.body);
          print("OBJECTIVE PROGRAMMATION ${data}");
          return data;
        }
        return null;
      });
    } catch (e) {
      print("ERROR PROGRAM OBJECTIVE : $e");
      return null;
    }
  }
  // OBJECTIVES STATUS
  Future objStatus({required String id, required String status, bool isProgrammation = true})async{
    try {
      return await http.post(Uri.parse(isProgrammation ? "${_netUtil.url}/user/api/obj_programmation/ChangeStatus" : "${_netUtil.url}/user/api/objective/ChangeStatus"),
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
        print("RETURN"+data.toString());
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      
    }
  }

}
