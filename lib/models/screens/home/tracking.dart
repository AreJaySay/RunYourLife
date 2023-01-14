import 'dart:convert';

import 'package:run_your_life/models/screens/checkin/tracking.dart';

import '../../../services/stream_services/subscriptions/subscription_details.dart';

class HomeTracking{
  String trainingChecker;
  double stress;
  double sleep;
  double smoke;
  double alcohol;
  List performances = [];
  List sports = [];
  List durations = [];
  String medication;
  String supplements;
  String menstruation;
  double coffee;
  double water;
  String date;

  HomeTracking({
    this.trainingChecker = "",
    this.stress = 0,
    this.sleep = 0,
    this.smoke = 0,
    this.alcohol = 0,
    required this.performances,
    required this.sports,
    required this.durations,
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
    if(trainingChecker != "null" && trainingChecker != "")...{
      for(int x = 0; x < sports.length; x++)...{
        "training[$x][sport]": sports[x].toString(),
        "training[$x][duration]": durations[x].toString(),
        "training[$x][performance]": performances[x].toString(),
      },
    }else...{
      "training": "null",
    },
    "medication": medication,
    "date": date,
    "supplements": supplements,
    "menstruation": menstruation,
    "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
  };
}

HomeTracking homeTracking = new HomeTracking(sports: [], durations: [], performances: []);