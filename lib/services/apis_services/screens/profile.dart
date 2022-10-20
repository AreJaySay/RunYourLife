import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:run_your_life/services/stream_services/screens/notifications.dart';
import 'package:run_your_life/services/stream_services/screens/profile.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';
import '../../stream_services/screens/blogs.dart';

class ProfileServices{
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future getProfile({required String clientid, String relation = "activeSubscription"})async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/clients/$clientid?relations=$relation"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("GET PROFILE ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          Auth.loggedUser = data;
          Auth.isNotSubs = data["active_subscription"].toString() == "[]" ? true : false;
          profileStreamServices.update(data: data);
          if(relation == "notifications"){
            notificationServices.update(data: data["notifications"]);
          }else{
            subscriptionDetails.updateSubs(data: data["active_subscription"]);
          }
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }
}