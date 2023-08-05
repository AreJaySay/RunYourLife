import 'package:run_your_life/models/auths_model.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import 'package:intl/intl.dart';

class Measures{
  String neck;
  String shoulder;
  String chest;
  String upper_arm;
  String waist;
  String hips;
  String upper_thigh;
  String calf;

  Measures({
   this.neck = "",
   this.shoulder = "",
   this.chest = "",
   this.upper_arm = "",
   this.waist = "",
   this.hips = "",
   this.upper_thigh = "",
   this.calf = ""
  });

  Map<String, dynamic> toMap() => {
    "neck": neck,
    "shoulder": shoulder,
    "chest": chest,
    "upper_arm": upper_arm,
    "waist": waist,
    "hips": hips,
    "upper_thigh": upper_thigh,
    "calf": calf,
    "date": DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now().toUtc().add(Duration(hours: 2))).toString(),
    "client_id": Auth.loggedUser!["id"].toString(),
    "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
  };
}

Measures measures = new Measures();