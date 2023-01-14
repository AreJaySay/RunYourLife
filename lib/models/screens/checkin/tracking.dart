import '../../../services/stream_services/subscriptions/subscription_details.dart';


class Tracking{
  double carbohydrate;
  double vegetable;
  double lipid;
  double protein;
  String date;
  static List<double> gramslider = [tracking.protein,tracking.lipid,tracking.carbohydrate,tracking.vegetable];

  Tracking({
    this.carbohydrate = 0,
    this.vegetable = 0,
    this.lipid = 0,
    this.protein = 0,
    this.date = "",
  });

  Map<String, dynamic> toMap() => {
    "type": subscriptionDetails.currentdata[0]["coach_macros"][0]["type"].toString(),
    "carbohydrate": carbohydrate.toString(),
    "vegetable": vegetable.toString(),
    "lipid": lipid.toString(),
    "protein": protein.toString(),
    "date": date,
    "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
  };
}

Tracking tracking = new Tracking();