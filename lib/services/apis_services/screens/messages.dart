import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/services/stream_services/screens/messages.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';

class MessageServices{
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future getMessages()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/chat/getChat"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          messageStreamServices.updatemessages(data: data['data']);
          messageStreamServices.updatecoach(data: data['coach_details']);
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  Future sendMessage({required String client_id, required String message, required String sender_type, required String type, required List base64Images,required List filename})async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/chat/addChat"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
        body: {
          "client_id": client_id,
          if(type == "files")...{
            for(int x = 0; x < base64Images.length;x++)...{
              "message[${x}][file]": base64Images[x],
              "message[${x}][name]": filename[x].toString(),
              "message[${x}][type]": filename[x].toString().contains(".pdf") ? "application/pdf" : filename[x].toString().contains(".mp4") ? "video/mp4" : "image/jpeg"
            }
          }else...{
            "message": message,
          },
          "sender_id": Auth.loggedUser!["id"].toString(),
          "sender_type": sender_type,
          "type": type,
        }
      ).then((respo) async {
        print(respo.body);
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          messageStreamServices.appendmessage(data: data['data']);
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  Future pinMessage(context,{required String id,required String status})async{
    try {
      return await http.put(Uri.parse("${_networkUtility.url}/user/api/chat/pinMessage/$id?to=$status"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print(data.toString());
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

  Future deleteMessage({required String id})async{
    try {
      return await http.delete(Uri.parse("${_networkUtility.url}/user/api/chat/deleteMessage/${id.toString()}"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print(data.toString());
        if (respo.statusCode == 200 || respo.statusCode == 201){
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  Future getPinnedMessages()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/chat/getPinnedMessage"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          print(data.toString());
          messageStreamServices.updatePinned(data: data);
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }
}
