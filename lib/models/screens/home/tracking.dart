import 'dart:convert';

import 'package:run_your_life/models/screens/checkin/tracking.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';

import '../../../services/stream_services/subscriptions/subscription_details.dart';

class HomeTracking{
  double stress;
  double sleep;
  double smoke;
  double alcohol;
  String medication;
  String supplements;
  String menstruation;
  double coffee;
  double water;
  String date;
  static String? currentDate;
  static int? selected;
  static bool hasTraining = true;

  HomeTracking({
    this.stress = 0,
    this.sleep = 0,
    this.smoke = 0,
    this.alcohol = 0,
    this.medication = "",
    this.supplements = "",
    this.menstruation = "",
    this.coffee = 0,
    this.water = 0,
    this.date = "",
  });

  Map<String, dynamic> toMap() => {
    "stress": stress.toString(),
    "sleep": sleep.toString(),
    "smoke": smoke.toString(),
    "coffee": coffee.toString(),
    "water": water.toString(),
    "alcohol": alcohol.toString(),
    if(hasTraining)...{
      for(int x = 0; x < step5subs.sports.length; x++)...{
        "training[$x][sport]": step5subs.sports[x].text.toString(),
        "training[$x][duration]": step5subs.duration[x].text,
        "training[$x][performance]": step5subs.performances[x].toString(),
      },
    }else...{
      "training": "No training",
    },
    "medication": medication,
    "date": date,
    "supplements": supplements,
    "menstruation": menstruation,
    "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
  };
}

HomeTracking homeTracking = new HomeTracking();