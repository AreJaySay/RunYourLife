import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/auths_model.dart';
import '../../../../utils/snackbars/snackbar_message.dart';
import '../../other_services/http_requests.dart';

class CredentialsServices{
  final HttpRequest _request =  HttpRequest.instance;
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final NetworkUtility _networkUtility = new NetworkUtility();
  final ProfileServices _profileServices = new ProfileServices();

  Future login(context,{required String password, required String email, })async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/login"),
          headers: _request.defaultHeader,
          body: {"email": email, "password": password, "fcm_token": DeviceModel.devicefcmToken.toString()}).then((respo) async {
        var data = json.decode(respo.body);
        print(data.toString());
        if (respo.statusCode == 200 || respo.statusCode == 201){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', email.toString());
          prefs.setString('password', password.toString());
          Auth.email = email;
          Auth.pass = password;
          Auth.accessToken = data['access_token'];
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {

    }
  }
  
  Future register(context,{String? fname,String? lname,String? email,String? password, String? phone_1})async{
    try{
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/register"),
      headers: _request.defaultHeader,
      body: {
        "first_name": fname,
        "last_name": lname,
        "email": email,
        "birthday": step1subs.birthdate.toString(),
        "password": password,
        "phone_1": phone_1,
      }
    ).then((data)async{
      var respo = json.decode(data.body);
      print(respo.toString());
      if(data.statusCode == 200 || data.statusCode == 201){
        return respo;
      }else{
        return null;
      }
    });
    }catch(e){
      print("ERROR ${e.toString()}");
    }
  }

  Future editaccount(context,{required bool isPhoto})async{
    try{
      return await http.put(Uri.parse("${_networkUtility.url}/user/api/clients/${Auth.loggedUser!['id'].toString()}"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
            "Accept": "application/json"
          },
          body: auth.toMap()
      ).then((data)async{
        var respo = json.decode(data.body);
        if(data.statusCode == 200 || data.statusCode == 201){
          _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString()).whenComplete((){
            Navigator.of(context).pop(null);
            Navigator.of(context).pop(null);
          });
        }else{
          Navigator.of(context).pop(null);
        }
      });
    }catch(e){
      print("ERROR ${e.toString()}");
    }
  }
}

CredentialsServices credentialsServices = new CredentialsServices();
