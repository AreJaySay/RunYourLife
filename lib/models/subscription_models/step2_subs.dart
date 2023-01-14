import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../services/stream_services/subscriptions/subscription_details.dart';

class Step2Subs{
    final Routes _routes = new Routes();

    String food_preference;
    String meals_per_day;
    String follow_drastic_diet = "Yes";
    String calories_today;
    String allergies;
    String intolerances;
    String cultural_adaptations_diet;
    String water_per_day;
    String drink_other_than_water;
    String coffee_per_day;
    String alcohol_per_week;
    String food_supplement;
    String subscription_id;
    String id;
    //TYPICAL FOODS
    String breakfast;
    String morning_snack;
    String lunch;
    String afternoon_snack;
    String dinner;

    Step2Subs({
      this.food_preference = "",
      this.meals_per_day = "",
      this.follow_drastic_diet = "",
      this.calories_today = "",
      this.allergies = "",
      this.intolerances = "",
      this.cultural_adaptations_diet = "",
      this.water_per_day = "",
      this.drink_other_than_water = "",
      this.coffee_per_day = "",
      this.alcohol_per_week = "",
      this.food_supplement = "",
      this.subscription_id = "",
      this.id = "",
      //TYPICAL FOODS
      this.breakfast = "",
      this.morning_snack = "",
      this.lunch = "",
      this.afternoon_snack = "",
      this.dinner = "",
  });

    Map<String, dynamic> toMap() => {
      "food_preference": food_preference,
      "meals_per_day": meals_per_day,
      "follow_drastic_diet": follow_drastic_diet,
      "calories_today": calories_today,
      "allergies": allergies,
      "intolerances": intolerances,
      "cultural_adaptations_diet": cultural_adaptations_diet,
      "water_per_day": water_per_day,
      "drink_other_than_water": drink_other_than_water,
      "coffee_per_day": coffee_per_day,
      "alcohol_per_week": alcohol_per_week,
      "food_supplement": food_supplement,
      "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
      "id": id,
      "typical_foods[breakfast]": breakfast,
      "typical_foods[morning_snack]": morning_snack,
      "typical_foods[lunch]": lunch,
      "typical_foods[afternoon_snack]": afternoon_snack,
      "typical_foods[dinner]": dinner,
    };

    Future editStep2(context,{required Map details,})async{
      if(details.toString() != "{}"){
        food_preference = details["food_preference"] == null? "" : details["food_preference"].toString();
        meals_per_day = details["meals_per_day"] == null? "" : details["meals_per_day"].toString();
        follow_drastic_diet = details["follow_drastic_diet"] == null? "" : details["follow_drastic_diet"].toString();
        calories_today = details["calories_today"] == null? "" : details["calories_today"].toString();
        allergies = details["allergies"] == null? "" : details["allergies"].toString();
        intolerances = details["intolerances"] == null? "" : details["intolerances"].toString();
        cultural_adaptations_diet = details["cultural_adaptations_diet"] == null? "" : details["cultural_adaptations_diet"].toString();
        water_per_day = details["water_per_day"] == null? "" : details["water_per_day"].toString();
        drink_other_than_water = details["drink_other_than_water"] == null? "" : details["drink_other_than_water"].toString();
        coffee_per_day = details["coffee_per_day"] == null? "" : details["coffee_per_day"].toString();
        alcohol_per_week = details["alcohol_per_week"] == null? "" : details["alcohol_per_week"].toString();
        food_supplement = details["food_supplement"] == null? "" : details["food_supplement"].toString();
        subscription_id = details["subscription_id"].toString();
        id = details["id"].toString();
        breakfast = details["typical_day_food"]["breakfast"] == null? "" : details["typical_day_food"]["breakfast"].toString();
        morning_snack = details["typical_day_food"]["morning_snack"] == null? "" : details["typical_day_food"]["morning_snack"].toString();
        lunch = details["typical_day_food"]["lunch"] == null? "" : details["typical_day_food"]["lunch"].toString();
        afternoon_snack = details["typical_day_food"]["afternoon_snack"] == null? "" : details["typical_day_food"]["afternoon_snack"].toString();
        dinner = details["typical_day_food"]["dinner"] == null? "" : details["typical_day_food"]["dinner"].toString();
      }
    }

    Widget richtext({required Map formInfo}){
      return ReadMoreText(
        subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ?
        "Préférence alimentaire: ${formInfo["food_preference"] == null ? "N/A" : formInfo["food_preference"].toString()}\n"
        "Repas par jour: ${formInfo["meals_per_day"] == null ? "N/A" : formInfo["meals_per_day"].toString()}\n"
        "Calories par jour: ${formInfo["calories_today"] == null ? "N/A" : formInfo["calories_today"].toString()}\n" :
        "Préférence alimentaire: ${formInfo["food_preference"] == null ? "N/A" : formInfo["food_preference"].toString()}\n"
        "Repas par jour: ${formInfo["meals_per_day"] == null ? "N/A" : formInfo["meals_per_day"].toString()}\n"
        "Calories par jour: ${formInfo["calories_today"] == null ? "N/A" : formInfo["calories_today"].toString()}\n"
        "Allergies: ${formInfo["allergies"] == null ? "N/A" : formInfo["allergies"].toString()}\n"
        "Intolérances: ${formInfo["intolerances"] == null ? "N/A" : formInfo["intolerances"].toString()}\n"
        "Régime particulier lié à la culture/religion: ${formInfo["cultural_adaptations_diet"] == null ? "N/A" : formInfo["cultural_adaptations_diet"].toString()}\n"
        "Eau par jour: ${formInfo["water_per_day"] == null ? "N/A" : formInfo["water_per_day"].toString()}\n"
        "Autres boissons que l’eau: ${formInfo["drink_other_than_water"] == null ? "N/A" : formInfo["drink_other_than_water"].toString()}\n"
        "Café par jour: ${formInfo["coffee_per_day"] == null ? "N/A" : formInfo["coffee_per_day"].toString()}\n"
        "Alcool par semaine: ${formInfo["alcohol_per_week"] == null ? "N/A" : formInfo["alcohol_per_week"].toString()}\n"
        "Suppléments alimentaires: ${formInfo["food_supplement"] == null ? "N/A" : formInfo["food_supplement"].toString()}",
        trimLines: 4,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: ' Voir plus',
        trimExpandedText: ' Voir moins',
        lessStyle: TextStyle(fontWeight: FontWeight.w600,color: AppColors.appmaincolor,fontSize: 14.5,fontFamily: "AppFontStyle"),
        moreStyle: TextStyle(fontWeight: FontWeight.w600,color: AppColors.appmaincolor,fontSize: 14.5,fontFamily: "AppFontStyle"),
        style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),
      );
    }
}

Step2Subs step2subs = new Step2Subs();