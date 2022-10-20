import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../services/stream_services/subscriptions/subscription_details.dart';

class Step3Subs{
  final Routes _routes = new Routes();

  String medical_history;
  String medical_treatment;
  String family_medical_history;
  String eating_disorder;
  String eating_disorder_age;
  String eating_disorder_remedy;
  String fears;
  String contraception;
  String premenstrual_syndrome;
  String gynaecological_condition;
  String observe_menstrual_cycle;
  String regular_cycle;
  String cycle_average;
  String pregnant;
  String subscription_id;
  String id;
  
  Step3Subs({
    this.medical_history="",
    this.medical_treatment="",
    this.family_medical_history="",
    this.eating_disorder="",
    this.eating_disorder_age="",
    this.eating_disorder_remedy="",
    this.fears="",
    this.contraception="",
    this.premenstrual_syndrome="",
    this.gynaecological_condition="",
    this.observe_menstrual_cycle="",
    this.regular_cycle="",
    this.cycle_average="",
    this.pregnant="",
    this.subscription_id="",
    this.id="",
  });

  Map<String, dynamic> toMap() => {
    "medical_history" : medical_history,
    "medical_treatment" : medical_treatment,
    "family_medical_history" : family_medical_history,
    "eating_disorder" : eating_disorder,
    "eating_disorder_age" : eating_disorder_age,
    "eating_disorder_remedy" : eating_disorder_remedy,
    "fears" : fears,
    "contraception" : contraception,
    "premenstrual_syndrome" : premenstrual_syndrome,
    "gynaecological_condition" : gynaecological_condition,
    "observe_menstrual_cycle": observe_menstrual_cycle,
    "regular_cycle" : regular_cycle,
    "cycle_average" : cycle_average,
    "pregnant" : pregnant,
    "subscription_id" : subscriptionDetails.currentdata[0]["id"].toString(),
    "id": id,
  };

  Future editStep3(context,{required Map details,})async{
    if(details.toString() != "{}"){
      medical_history = details["medical_history"] == null? "" : details["medical_history"].toString();
      medical_treatment = details["medical_treatment"] == null? "" : details["medical_treatment"].toString();
      family_medical_history = details["family_medical_history"] == null? "" : details["family_medical_history"].toString();
      eating_disorder = details["eating_disorder"] == null? "" : details["eating_disorder"].toString();
      eating_disorder_age = details["eating_disorder_age"] == null? "" : details["eating_disorder_age"].toString();
      eating_disorder_remedy = details["eating_disorder_remedy"] == null? "" : details["eating_disorder_remedy"].toString();
      fears = details["fears"] == null? "" : details["fears"].toString();
      contraception = details["contraception"] == null? "" : details["contraception"].toString();
      premenstrual_syndrome = details["premenstrual_syndrome"] == null? "" : details["premenstrual_syndrome"].toString();
      gynaecological_condition = details["gynaecological_condition"] == null? "" : details["gynaecological_condition"].toString();
      observe_menstrual_cycle = details["observe_menstrual_cycle"] == null? "" : details["observe_menstrual_cycle"].toString();
      regular_cycle = details["regular_cycle"] == null? "" : details["regular_cycle"].toString();
      cycle_average = details["cycle_average"] == null? "" : details["cycle_average"].toString();
      pregnant = details["pregnant"] == null? "" : details["pregnant"].toString();
      subscription_id = details["subscription_id"].toString();
      id = details["id"].toString();
    }
  }

  Widget richtext({required Map formInfo}){
    return ReadMoreText(
      step1subs.gender.toLowerCase() == "Female".toLowerCase() ? "Medical history: ${formInfo["medical_history"] == null ? "N/A" : formInfo["medical_history"].toString()}\n"
          "Traitement médical: ${formInfo["medical_treatment"] == null ? "N/A" : formInfo["medical_treatment"].toString()}\n"
          "Antécédents médicaux familiaux: ${formInfo["family_medical_history"] == null ? "N/A" : formInfo["family_medical_history"].toString()}\n"
          "Trouble de l'alimentation: ${formInfo["eating_disorder"] == null ? "N/A" : formInfo["eating_disorder"].toString()}\n"
          "Âge des troubles de l'alimentation: ${formInfo["eating_disorder_age"] == null ? "N/A" : formInfo["eating_disorder_age"].toString()}\n"
          "Remède contre les troubles de l'alimentation: ${formInfo["eating_disorder_remedy"] == null ? "N/A" : formInfo["eating_disorder_remedy"].toString()}\n"
          "Craintes: ${formInfo["fears"] == null ? "N/A" : formInfo["fears"].toString()}\n"
          "Contraception: ${formInfo["contraception"] == null ? "N/A" : formInfo["contraception"].toString()}\n"
          "Le syndrome prémenstruel: ${formInfo["premenstrual_syndrome"] == null ? "N/A" : formInfo["premenstrual_syndrome"].toString()}\n"
          "Affection gynécologique: ${formInfo["gynaecological_condition"] == null ? "N/A" : formInfo["gynaecological_condition"].toString()}\n"
          "Observer le cycle menstruel: ${formInfo["observe_menstrual_cycle"] == null ? "N/A" : formInfo["observe_menstrual_cycle"].toString()}\n"
          "Cycle régulier: ${formInfo["regular_cycle"] == null ? "N/A" : formInfo["regular_cycle"].toString()}\n"
          "Moyenne du cycle: ${formInfo["cycle_average"] == null ? "N/A" : formInfo["cycle_average"].toString()}\n"
          "Enceinte: ${formInfo["pregnant"] == null ? "N/A" : formInfo["pregnant"].toString()}\n" :

          "Antécédents médicaux: ${formInfo["medical_history"] == null ? "N/A" : formInfo["medical_history"].toString()}\n"
          "Traitement médicamenteux: ${formInfo["medical_treatment"] == null ? "N/A" : formInfo["medical_treatment"].toString()}\n"
          "Antécédents médicaux familiaux: ${formInfo["family_medical_history"] == null ? "N/A" : formInfo["family_medical_history"].toString()}\n"
          "Troubles de comportements alimentaires: ${formInfo["eating_disorder"] == null ? "N/A" : formInfo["eating_disorder"].toString()}\n"
          "Age du trouble de comportement alimentaire: ${formInfo["eating_disorder_age"] == null ? "N/A" : formInfo["eating_disorder_age"].toString()}\n"
          "Remède du trouble: ${formInfo["eating_disorder_remedy"] == null ? "N/A" : formInfo["eating_disorder_remedy"].toString()}\n"
          "Craintes: ${formInfo["fears"] == null ? "N/A" : formInfo["fears"].toString()}\n"
      ,
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

Step3Subs step3subs = new Step3Subs();