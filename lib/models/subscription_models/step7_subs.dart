import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

import '../../services/stream_services/subscriptions/subscription_details.dart';

class Step7Subs{
  final Routes _routes = new Routes();

  String hours;
  double wake_up_feelings;
  String sleeping_supplements;
  String wake_up_at_night;
  String trouble_sleeping;
  String bed_gadget;
  String id;
  String regular_times_bed;
  String regular_hours_wake_up;
  String daylight_exposure;
  String subscription_id;

  Step7Subs({
    this.hours = "",
    this.wake_up_feelings = 0,
    this.sleeping_supplements = "",
    this.wake_up_at_night = "",
    this.trouble_sleeping = "",
    this.bed_gadget = "",
    this.regular_times_bed = "",
    this.regular_hours_wake_up = "",
    this.daylight_exposure = "",
    this.id = "",
    this.subscription_id = "",
  });

  Map<String, dynamic> toMap() => {
    "hours": hours,
    "wake_up_feelings": wake_up_feelings.toString(),
    "sleeping_supplements": sleeping_supplements,
    "wake_up_at_night": wake_up_at_night,
    "trouble_sleeping": trouble_sleeping,
    "bed_gadget": bed_gadget,
    "regular_times_bed": regular_times_bed,
    "regular_hours_wake_up": regular_hours_wake_up,
    "daylight_exposure": daylight_exposure,
    "id": id,
    "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
  };

  // Future editStep7(context,{required Map details,})async{
  //   if(details.toString() != "{}"){
  //     hours = details["hours"] == null? "" : details["hours"].toString();
  //     wake_up_feelings = double.parse(details["wake_up_feelings"].toString());
  //     sleeping_supplements = details["sleeping_supplements"] == null? "" : details["sleeping_supplements"].toString();
  //     wake_up_at_night = details["wake_up_at_night"] == null? "" : details["wake_up_at_night"].toString();
  //     trouble_sleeping = details["trouble_sleeping"] == null? "" : details["trouble_sleeping"].toString();
  //     bed_gadget = details["bed_gadget"] == null? "" : details["bed_gadget"].toString();
  //     regular_times_bed = details["regular_times_bed"] == null? "" : details["regular_times_bed"].toString();
  //     regular_hours_wake_up = details["regular_hours_wake_up"] == null? "" : details["regular_hours_wake_up"].toString();
  //     daylight_exposure = details["daylight_exposure"] == null? "" : details["daylight_exposure"].toString();
  //   }
  // }
  //
  // Widget richtext({required Map formInfo}){
  //   return ReadMoreText(
  //         "Hours: ${formInfo["hours"] == null ? "N/A" : formInfo["hours"].toString()}\n"
  //         "Sentiments de réveil: ${formInfo["wake_up_feelings"] == null ? "N/A" : formInfo["wake_up_feelings"].toString()}\n"
  //         "Suppléments pour le sommeil: ${formInfo["sleeping_supplements"] == null ? "N/A" : formInfo["sleeping_supplements"].toString()}\n"
  //         "Se réveiller la nuit: ${formInfo["wake_up_at_night"] == null ? "N/A" : formInfo["wake_up_at_night"].toString()}\n"
  //         "Troubles du sommeil: ${formInfo["trouble_sleeping"] == null ? "N/A" : formInfo["trouble_sleeping"].toString()}\n"
  //         "Gadget pour le lit: ${formInfo["bed_gadget"] == null ? "N/A" : formInfo["bed_gadget"].toString()}\n"
  //         "Heures normales lit: ${formInfo["regular_times_bed"] == null ? "N/A" : formInfo["regular_times_bed"].toString()}\n"
  //         "Réveil aux heures normales: ${formInfo["regular_hours_wake_up"] == null ? "N/A" : formInfo["regular_hours_wake_up"].toString()}\n"
  //         "Exposition à la lumière du jour: ${formInfo["daylight_exposure"] == null ? "N/A" : formInfo["daylight_exposure"].toString()}\n",
  //     trimLines: 4,
  //     colorClickableText: Colors.pink,
  //     trimMode: TrimMode.Line,
  //     trimCollapsedText: ' Voir plus',
  //     trimExpandedText: ' Voir moins',
  //     lessStyle: TextStyle(fontWeight: FontWeight.w600,color: AppColors.appmaincolor,fontSize: 14.5,fontFamily: "AppFontStyle"),
  //     moreStyle: TextStyle(fontWeight: FontWeight.w600,color: AppColors.appmaincolor,fontSize: 14.5,fontFamily: "AppFontStyle"),
  //     style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),
  //   );
  // }
}

Step7Subs step7subs = new Step7Subs();