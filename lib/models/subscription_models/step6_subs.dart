import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';


class Step6Subs{
  final Routes _routes = new Routes();

  String job_or_study;
  double stress_meter;
  double fulfilling_meter;
  double home_stressed;
  String manage_stress;
  double plan_your_day;
  String time_outside_per_day;
  String id;
  String subscription_id;

  Step6Subs({
    this.job_or_study = "",
    this.stress_meter = 0,
    this.fulfilling_meter = 0,
    this.home_stressed = 0,
    this.manage_stress = "",
    this.plan_your_day = 0,
    this.time_outside_per_day = "",
    this.id = "",
    this.subscription_id = "",
  });

  Map<String, dynamic> toMap() => {
    "job_or_study": job_or_study,
    "stress_meter": stress_meter.toString(),
    "fulfilling_meter": fulfilling_meter.toString(),
    "home_stressed": home_stressed.toString(),
    "manage_stress": manage_stress,
    "plan_your_day": plan_your_day.toString(),
    "time_outside_per_day": time_outside_per_day,
    "id": id,
    "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
  };

  // Future editStep6(context,{required Map details,})async{
  //   if(details.toString() != "{}"){
  //     job_or_study = details["job_or_study"] == null? "" : details["job_or_study"].toString();
  //     stress_meter = double.parse( details["stress_meter"].toString());
  //     fulfilling_meter = double.parse( details["fulfilling_meter"].toString());
  //     home_stressed = double.parse( details["home_stressed"].toString());
  //     manage_stress = details["manage_stress"] == null? "" : details["manage_stress"].toString();
  //     plan_your_day = double.parse( details["plan_your_day"].toString());
  //     time_outside_per_day = details["time_outside_per_day"] == null? "" : details["time_outside_per_day"].toString();
  //   }
  // }
  //
  // Widget richtext({required Map formInfo}){
  //   return ReadMoreText(
  //       "Travail ou étude: ${formInfo["job_or_study"] == null ? "N/A" : formInfo["job_or_study"].toString()}\n"
  //       "Niveau de stress: ${formInfo["stress_meter"] == null ? "N/A" : formInfo["stress_meter"].toString()}\n"
  //       "Niveau d’épanouissement: ${formInfo["fulfilling_meter"] == null ? "N/A" : formInfo["fulfilling_meter"].toString()}\n"
  //       "Stress à la maison: ${formInfo["home_stressed"] == null ? "N/A" : formInfo["home_stressed"].toString()}\n"
  //       "Gestion du stress: ${formInfo["manage_stress"] == null ? "N/A" : formInfo["manage_stress"].toString()}\n"
  //       "Planification de la journée: ${formInfo["plan_your_day"] == null ? "N/A" : formInfo["plan_your_day"].toString()}\n"
  //       "Temps passé à l’extérieur par jour: ${formInfo["time_outside_per_day"] == null ? "N/A" : formInfo["time_outside_per_day"].toString()}\n",
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

Step6Subs step6subs = new Step6Subs();