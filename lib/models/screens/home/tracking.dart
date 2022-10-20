import 'package:run_your_life/models/screens/checkin/tracking.dart';

import '../../../services/stream_services/subscriptions/subscription_details.dart';

class HomeTracking{
  String trainingChecker;
  double stress;
  double sleep;
  double smoke;
  String alcohol;
  List sports = [];
  List durations = [];
  String medication;
  String supplements;
  double coffee;
  double water;
  String date;

  HomeTracking({
    this.trainingChecker = "",
    this.stress = 0,
    this.sleep = 0,
    this.smoke = 0,
    this.alcohol = "",
    required this.sports,
    required this.durations,
    this.medication = "",
    this.supplements = "",
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
    "alcohol": alcohol,
    if(trainingChecker != "null")...{
      for(int x = 0; x < sports.length; x++)...{
        "training[$x][sport]": sports[x],
        "training[$x][duration]": durations[x],
      },
    }else...{
      "training": "null",
    },
    "medication": medication,
    "date": date,
    "supplements": supplements,
    "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
  };
}

HomeTracking homeTracking = new HomeTracking(sports: [], durations: []);