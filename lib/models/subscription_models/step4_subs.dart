import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../services/stream_services/subscriptions/subscription_details.dart';

class Step4Subs{
  final Routes _routes = new Routes();

  String goal;
  String desired_weight;
  String date_to_reach_goal;
  double goal_importance;
  double what_to_eat;
  double how_much_to_eat;
  double plan_meals;
  double time_to_cook;
  double drink_alcohol;
  double cravings;
  double emotional_void;
  double eat_when_not_hungry;
  double always_hungry;
  double not_hungry;
  double guilty_to_eat;
  double access_to_healthy_food;
  String subscription_id;
  String id;
  
  Step4Subs({
    this.goal="",
    this.desired_weight="",
    this.date_to_reach_goal="",
    this.goal_importance = 0,
    this.what_to_eat = 0,
    this.how_much_to_eat = 0,
    this.plan_meals = 0,
    this.time_to_cook = 0,
    this.drink_alcohol = 0,
    this.cravings = 0,
    this.emotional_void = 0,
    this.eat_when_not_hungry = 0,
    this.always_hungry = 0,
    this.not_hungry = 0,
    this.guilty_to_eat = 0,
    this.access_to_healthy_food = 0,
    this.subscription_id = "",
    this.id = "",
  });

  Map<String, dynamic> toMap() => {
    "goal": goal,
    "desired_weight": desired_weight,
    "date_to_reach_goal": date_to_reach_goal,
    "goal_importance": goal_importance.toString(),
    "hindrances[what_to_eat]": what_to_eat.toString(),
    "hindrances[how_much_to_eat]": how_much_to_eat.toString(),
    "hindrances[plan_meals]": plan_meals.toString(),
    "hindrances[time_to_cook]": time_to_cook.toString(),
    "hindrances[drink_alcohol]": drink_alcohol.toString(),
    "hindrances[cravings]": cravings.toString(),
    "hindrances[emotional_void]": emotional_void.toString(),
    "hindrances[eat_when_not_hungry]": eat_when_not_hungry.toString(),
    "hindrances[always_hungry]": always_hungry.toString(),
    "hindrances[not_hungry]": not_hungry.toString(),
    "hindrances[guilty_to_eat]": guilty_to_eat.toString(),
    "hindrances[access_to_healthy_food]": access_to_healthy_food.toString(),
    "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
    "id": id,
  };

  Future editStep4(context,{required Map details,})async{
    if(details.toString() != "{}"){
      goal = details["goal"] == null? "" : details["goal"].toString();
      desired_weight = details["desired_weight"] == null? "" : details["desired_weight"].toString();
      // date_to_reach_goal = details["date_to_reach_goal"] == null? "" : details["date_to_reach_goal"].toString();
      goal_importance = double.parse(details["goal_importance"].toString());
      subscription_id = details["subscription_id"].toString();
      id = details["id"].toString();
      what_to_eat = double.parse(details["goal_hindrances"]["what_to_eat"].toString());
      how_much_to_eat = double.parse(details["goal_hindrances"]["how_much_to_eat"].toString());
      plan_meals = double.parse(details["goal_hindrances"]["plan_meals"].toString());
      time_to_cook = double.parse(details["goal_hindrances"]["time_to_cook"].toString());
      drink_alcohol = double.parse(details["goal_hindrances"]["drink_alcohol"].toString());
      cravings = double.parse(details["goal_hindrances"]["cravings"].toString());
      emotional_void = double.parse(details["goal_hindrances"]["emotional_void"].toString());
      eat_when_not_hungry = double.parse(details["goal_hindrances"]["eat_when_not_hungry"].toString());
      always_hungry = double.parse(details["goal_hindrances"]["always_hungry"].toString());
      not_hungry = double.parse(details["goal_hindrances"]["not_hungry"].toString());
      guilty_to_eat = double.parse(details["goal_hindrances"]["guilty_to_eat"].toString());
      access_to_healthy_food = double.parse(details["goal_hindrances"]["access_to_healthy_food"].toString());
    }
  }

  Widget richtext({required Map formInfo}){
    return ReadMoreText(
      subscriptionDetails.currentdata[0]["plan_id"] == 1 ?
      "Objectif: ${formInfo["goal"] == null ? "N/A" : formInfo["goal"].toString()}\n"
      "Poids désiré: ${formInfo["desired_weight"] == null ? "N/A" : formInfo["desired_weight"].toString()}\n"
      "Date pour l’objectif: ${formInfo["date_to_reach_goal"] == null ? "N/A" : formInfo["date_to_reach_goal"].toString()}\n" :
      "Objectif: ${formInfo["goal"] == null ? "N/A" : formInfo["goal"].toString()}\n"
      "Poids désiré: ${formInfo["desired_weight"] == null ? "N/A" : formInfo["desired_weight"].toString()}\n"
      "Date pour l’objectif: ${formInfo["date_to_reach_goal"] == null ? "N/A" : formInfo["date_to_reach_goal"].toString()}\n"
      "Importance de l’objectif: ${formInfo["goal_importance"].toString() == "0.0" ? "N/A" : formInfo["goal_importance"].toString()}\n"
      "Que manger: ${formInfo["goal_hindrances"]["what_to_eat"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["what_to_eat"].toString()}\n"
      "Quantité à manger: ${formInfo["goal_hindrances"]["how_much_to_eat"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["how_much_to_eat"].toString()}\n"
      "Plan alimentaire: ${formInfo["goal_hindrances"]["plan_meals"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["plan_meals"].toString()}\n"
      "Temps de préparation: ${formInfo["goal_hindrances"]["time_to_cook"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["time_to_cook"].toString()}\n"
      "Bois de l’alcool: ${formInfo["goal_hindrances"]["drink_alcohol"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["drink_alcohol"].toString()}\n"
      "Envies compulsives: ${formInfo["goal_hindrances"]["cravings"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["cravings"].toString()}\n"
      "Problème affectif: ${formInfo["goal_hindrances"]["emotional_void"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["emotional_void"].toString()}\n"
      "Manger sans avoir faim: ${formInfo["goal_hindrances"]["eat_when_not_hungry"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["eat_when_not_hungry"].toString()}\n"
      "Avoir toujours faim: ${formInfo["goal_hindrances"]["always_hungry"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["always_hungry"].toString()}\n"
      "Ne pas avoir faim: ${formInfo["goal_hindrances"]["not_hungry"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["not_hungry"].toString()}\n"
      "Culpabilité de manger: ${formInfo["goal_hindrances"]["guilty_to_eat"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["guilty_to_eat"].toString()}\n"
      "Accès à la nourriture saine: ${formInfo["goal_hindrances"]["access_to_healthy_food"].toString() == "0.0" ? "N/A" : formInfo["goal_hindrances"]["access_to_healthy_food"].toString()}\n",
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

Step4Subs step4subs = new Step4Subs();