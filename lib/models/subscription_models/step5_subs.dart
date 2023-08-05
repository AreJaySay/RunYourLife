import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/subscriptions/step5.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../services/stream_services/subscriptions/subscription_details.dart';

class Step5Subs{
  final Routes _routes = new Routes();

  // PREGNANT
  List<double> performances = [];
  List<TextEditingController> sports = [];
  List<TextEditingController> duration = [];
  String practice_sport;
  String sporting_activity_level;
  String activity_outside_sport_level;
  double training_recovery;
  double no_training_day;
  String pain;
  String id;
  // NOT PREGNANT
  double confident_on_athletic_ability;
  double comfortable_place;
  double place_to_practice;
  double energy_to_practice;
  double time;
  double motivation;
  String subscription_id;

  Step5Subs({
    this.practice_sport = "",
    this.sporting_activity_level = "",
    this.activity_outside_sport_level = "",
    this.training_recovery = 0,
    this.no_training_day = 0,
    this.pain = "",
    this.id = "",
    this.confident_on_athletic_ability = 0,
    this.comfortable_place = 0,
    this.place_to_practice = 0,
    this.energy_to_practice = 0,
    this.time = 0,
    this.motivation = 0,
    this.subscription_id = "",
  });

  Map<String, dynamic> toMap() => {
    "practice_sport" : practice_sport,
    if(step5streamService.current)...{
      "sporting_activity_level" : sporting_activity_level,
      "activity_outside_sport_level" : activity_outside_sport_level,
      "training_recovery" : training_recovery.toString(),
      "no_training_day" : no_training_day.toString(),
      "pain" : pain,
      for(int x = 0; x < sports.length; x++)...{
        "sport_types[$x][name]": sports[x].text.toString(),
        "sport_types[$x][duration]": duration[x].text.toString(),
      },
      // for(int x = 0; x < sports.length; x++)...{
      //   "name": sports[x].text,
      //   "duration": duration[x].text
      // },
    }else...{
      "no_sports[confident_on_athletic_ability]": confident_on_athletic_ability.floor().toString(),
      "no_sports[comfortable_place]": comfortable_place.floor().toString(),
      "no_sports[place_to_practice]": place_to_practice.floor().toString(),
      "no_sports[energy_to_practice]": energy_to_practice.floor().toString(),
      "no_sports[time]": time.floor().toString(),
      "no_sports[motivation]": motivation.floor().toString(),
    },
    "id": id,
    "subscription_id" : subscriptionDetails.currentdata[0]["id"].toString(),
  };

  //
  // Future editStep5(context,{required Map details,})async{
  //   if(details.toString() != "{}"){
  //     practice_sport = details["practice_sport"] == null? "" : details["practice_sport"].toString();
  //     sporting_activity_level = details["sporting_activity_level"] == null? "" : details["sporting_activity_level"].toString();
  //     activity_outside_sport_level = details["activity_outside_sport_level"] == null? "" : details["activity_outside_sport_level"].toString();
  //     training_recovery = details["training_recovery"] == null ? 0 : double.parse(details["training_recovery"].toString());
  //     no_training_day = details["no_training_day"] == null ? 0 : double.parse(details["no_training_day"].toString());
  //     pain = details["pain"] == null? "" : details["pain"].toString();
  //     subscription_id = details["subscription_id"].toString();
  //     confident_on_athletic_ability = details["confident_on_athletic_ability"] == null ? 0 : double.parse(details["confident_on_athletic_ability"].toString());
  //     comfortable_place = details["comfortable_place"] == null ? 0 : double.parse(details["comfortable_place"].toString());
  //     place_to_practice = details["place_to_practice"] == null ? 0 : double.parse(details["place_to_practice"].toString());
  //     energy_to_practice = details["energy_to_practice"] == null ? 0 : double.parse(details["energy_to_practice"].toString());
  //     time = details["time"] == null ? 0 : double.parse(details["time"].toString());
  //     motivation = details["motivation"] == null ? 0 : double.parse(details["motivation"].toString());
  //   }
  // }
  //
  // Widget richtext({required Map formInfo}){
  //   return ReadMoreText(
  //      subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ?
  //      "Pratique de sport: ${formInfo["practice_sport"] == null ? "N/A" : formInfo["practice_sport"].toString()}\n"
  //      "Types de sport: ${formInfo["sport_types"] == null ? "N/A" : formInfo["sport_types"].toString()}\n"
  //      "Niveau de pratique de sport: ${formInfo["sporting_activity_level"] == null ? "N/A" : formInfo["sporting_activity_level"].toString()}\n" :
  //      "Pratique de sport: ${formInfo["practice_sport"] == null ? "N/A" : formInfo["practice_sport"].toString()}\n"
  //      "Types de sport: ${formInfo["sport_types"] == null ? "N/A" : formInfo["sport_types"].toString()}\n"
  //      "Niveau de pratique de sport: ${formInfo["sporting_activity_level"] == null ? "N/A" : formInfo["sporting_activity_level"].toString()}\n"
  //      "Activité en dehors du niveau sportif: ${formInfo["activity_outside_sport_level"] == null ? "N/A" : formInfo["activity_outside_sport_level"].toString()}\n"
  //      "Récupération après entraînement: ${formInfo["training_recovery"] == null ? "N/A" : formInfo["training_recovery"].toString()}\n"
  //      "Jours sans entraînement: ${formInfo["no_training_day"] == null ? "N/A" : formInfo["no_training_day"].toString()}\n"
  //      "Douleur: ${formInfo["pain"] == null ? "N/A" : formInfo["pain"].toString()}\n",
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

Step5Subs step5subs = new Step5Subs();