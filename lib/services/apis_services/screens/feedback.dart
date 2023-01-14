import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:run_your_life/services/stream_services/screens/feedback.dart';
import 'package:run_your_life/services/stream_services/screens/messages.dart';
import '../../../models/auths_model.dart';
import '../../../utils/network_util.dart';

class FeedbackServices{
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future getFeedback()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/feedback/getFeedback"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("FEEDBACK ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          feedbackStreamServices.update(data: data);
          return data;
        }else{
          feedbackStreamServices.update(data: []);
          return null;
        }
      });
    } catch (e) {
    }
  }

  Future addFeedback({required String message})async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/feedback/addFeedback"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "feedbackscol": message,
          "client_id": Auth.loggedUser!["id"].toString(),
          "type": "client",
        }
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("ADD FEEDBACK ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
    }
  }

  Future getTime({required String date, required String coach_id})async{
    try{
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/coachschedule/getAvailtime/$date/$coach_id"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          feedbackStreamServices.updateTime(data: data);
          print("TIME ${data.toString()}");
          return data;
        }else{
          feedbackStreamServices.updateTime(data: {});
          print("ERROR TIME ${data.toString()}");
          return null;
        }
      });
    }catch(e){
      print("ERROR SCHEDULE ${e.toString()}");
    }
  }

  Future submit({required String date_id, required String time})async{
    try{
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/coachappointment"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "id": date_id,
          "time": time
        }
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("ADD SCHECDULE ${respo.body.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    }catch(e){
      print("ERROR SCHEDULE ${e.toString()}");
    }
  }
}