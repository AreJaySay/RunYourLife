import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:run_your_life/services/stream_services/screens/coaching.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';

class CoachingServices{
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future getplans()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/plans?relations=prices"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          coachingStreamServices.updatePlans(data: data['data']);
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET PLAN ${e.toString()}");
    }
  }


}