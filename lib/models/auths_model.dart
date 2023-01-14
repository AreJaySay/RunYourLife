import 'dart:io';

import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';

class Auth {
  static Map? loggedUser;
  static String? pass;
  static String? email;
  static String? accessToken;
  static bool? isNotSubs;

  // REGISTER
  String first_name;
  String last_name;
  String email2;
  String phone_1;
  String address_1;
  String base64Image;

  Auth({
    this.first_name = "",
    this.last_name = "",
    this.email2 = "",
    this.phone_1 = "",
    this.address_1 = "",
    this.base64Image = "",
  });

  Map<String, dynamic> toMap() => {
    "first_name": first_name,
    "last_name": last_name,
    "email": email2,
    "birthday": step1subs.birthdate.toString(),
    "phone_1": phone_1,
    "address_1": address_1,
    "logo": base64Image,
  };
}

Auth auth = new Auth();