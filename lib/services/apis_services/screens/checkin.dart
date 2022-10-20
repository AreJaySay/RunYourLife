import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/models/screens/checkin/measures.dart';
import 'package:run_your_life/models/screens/checkin/photos.dart';
import 'package:run_your_life/models/screens/checkin/tracking.dart';
import 'package:run_your_life/services/stream_services/screens/checkin.dart';
import 'package:run_your_life/services/stream_services/screens/home.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';
import 'package:intl/intl.dart';

import '../../stream_services/subscriptions/subscription_details.dart';

class CheckinServices{
  static List checkinSelected = [];
  final NetworkUtility _networkUtility = new NetworkUtility();

  // WEIGHT
  Future submit_weight(context,{required String weight})async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/weights"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
          "weight": weight,
          "date": DateFormat("yyyy-MM-dd","fr").format(DateTime.now()).toString(),
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("WEIGHT ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          Navigator.of(context).pop(null);
          return null;
        }
      });
    } catch (e) {
      Navigator.of(context).pop(null);
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  // TRACKING
  Future submit_tracking(context)async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/macros"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: tracking.toMap(),
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      Navigator.of(context).pop(null);
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }
  Future getTracking({required String date})async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/macros/get_by_date"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "subscription_id":  subscriptionDetails.currentdata[0]["id"].toString(),
          "date": date,
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("GET DATE ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          homeStreamServices.update(data: data);
          return data;
        }else{
          homeStreamServices.update(data: {});
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET TRACKING${e.toString()}");
    }
  }

  //MY MEASURES
  Future submit_measures(context)async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/measurements"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: measures.toMap(),
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("MESSURE DATA ${data.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      Navigator.of(context).pop(null);
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  // MY PHOTOS
  Future getPhotos(context)async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/clients/photos"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          checkInStreamServices.update(data: data);
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET PHOTOS${e.toString()}");
    }
  }
  Future remove_photo(context,{required String id})async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/clients/remove_photo/$id"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET PHOTOS${e.toString()}");
    }
  }
  Future getPhotoTags(context)async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/tags?type=photos"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          checkInStreamServices.updateTag(data: data["data"]);
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET PHOTOS${e.toString()}");
    }
  }
  Future addPhotoTag(context,{required String name,required String desc})async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/clients/add_photos_tags"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "subscription_id": subscriptionDetails.currentdata[0]["coach_id"].toString(),
          "name": name,
          "description": desc,
        }
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          Navigator.of(context).pop(null);
          Navigator.of(context).pop(null);
          checkInStreamServices.appendTag(data: data);
        }else{
          Navigator.of(context).pop(null);
          return null;
        }
      });
    } catch (e) {
      Navigator.of(context).pop(null);
      print("ERROR GET PHOTOS${e.toString()}");
    }
  }
  Future addPhoto(context)async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/clients/add_photos"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: photos.toMap(),
      ).then((respo) async {
        var data = json.decode(respo.body);
        print(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      Navigator.of(context).pop(null);
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  // MY RESSOURCES
  Future getResources(context)async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/clients/get_shared_documents?coach_id=${subscriptionDetails.currentdata[0]["coach_id"].toString()}"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          checkInStreamServices.updateRessources(data: data);
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET PHOTOS${e.toString()}");
    }
  }

  // LAST UPDATED
  Future getUpdated()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/clients/last_updated"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          checkInStreamServices.updatelastUpdated(data: data);
        }else{
          return null;
        }
        return data;
      });
    } catch (e) {
      print("ERROR GET PHOTOS${e.toString()}");
    }
  }

  //SUBSCRIPTION CHECKIN
  Future subsCheckIn()async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/checkin"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
          "date": DateFormat("yyyy-MM-dd","fr").format(DateTime.now()).toString()
        }
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
        return data;
      });
    } catch (e) {
      print("ERROR GET PHOTOS${e.toString()}");
    }
  }

  Future subsCheckInStatus()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/checkin/${subscriptionDetails.currentdata[0]["id"].toString()}?date=${DateFormat("yyyy-MM-dd","fr").format(DateTime.now()).toString()}"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (data.toString().contains("1")){
          print("SUBSCIRPTION CHECK IN ${data.toString()}");
          CheckinServices.checkinSelected = ['MON POIDS',"MES MESURES","MES MACROS","MES PHOTOS","MES OBJECTIFS DE LA SEMAINE"];
          return data;
        }else{
          CheckinServices.checkinSelected.clear();
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET PHOTOS${e.toString()}");
    }
  }
}