import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/models/measurement.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/services/stream_services/screens/home.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';
import 'package:intl/intl.dart';

class HomeServices{
  final NetworkUtility _networkUtility = new NetworkUtility();

  // TRACKING
  Future submit_tracking(context)async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/trackings"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: homeTracking.toMap()
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          Navigator.of(context).pop(null);
          return null;
        }
      });
    } catch (e) {
      Navigator.of(context).pop(null);
      print("ERROR GET TRACKING${e.toString()}");
    }
  }

  Future getTracking({required String date})async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/trackings/get_by_date"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
          "date": date,
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("TRACKING ${data}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          homeStreamServices.updateTrack(data: data);
          return data;
        }else{
          homeStreamServices.updateTrack(data: {});
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET TRACKING${e.toString()}");
    }
  }

  // LATEST CHECKIN
  Future getLatestCheckin()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/checkin/latestRecord/${subscriptionDetails.currentdata[0]["id"].toString()}"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          homeStreamServices.updateLatestCheckin(data: data);
          return data;
        }else{
          homeStreamServices.updateLatestCheckin(data: {});
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET CHECKL${e.toString()}");
      homeStreamServices.updateLatestCheckin(data: {});
    }
  }

  // MEETING
  Future getSchedule()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/clients/getSchedule"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("MEETING SCHEDULE ${data}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          homeStreamServices.updateMeeting(data: data);
          return data;
        }else{
          homeStreamServices.updateMeeting(data: {});
          return null;
        }
      });
    } catch (e) {
    }
  }

  // GRAPH
  Future getWeights()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/weights"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        // body: {
        //   "subs_id": subscriptionDetails.currentdata[0]["id"].toString(),
        //   // "week_request[start]": DateFormat("yyyy-MM-dd").format(DateTime.parse(subscriptionDetails.currentdata[0]["start_date"].toString()).toUtc()).toString(),
        //   "date": DateFormat("yyyy-MM-dd").format(DateTime.now().toUtc().add(Duration(hours: 2))).toString(),
        // },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("WEIGHT DATA ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          homeStreamServices.updateGraphWeight(data: data);
          return data;
        }else{
          homeStreamServices.updateGraphWeight(data: {});
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET GRAPH${e.toString()}");
    }
  }

  Future getHeights()async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/measurements/getWeekValue"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "subs_id": subscriptionDetails.currentdata[0]["id"].toString(),
          "date": DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now()),
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("HEIGHT DATA ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          List f = data[1];
          homeStreamServices.updateGraphHeight(data: f.map((e) => Measurement.fromJson(e)).toList());
          homeStreamServices.updateDateHeight(data: data[0]);
          return data;
        }else{
          homeStreamServices.updateGraphHeight(data: []);
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET GRAPH${e.toString()}");
    }
  }
}