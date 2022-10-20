import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/screens/profile/parameters.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../utils/palettes/app_colors.dart';

class UniteMeasures extends StatefulWidget {
  final Map details;
  UniteMeasures({required this.details});
  @override
  _UniteMeasuresState createState() => _UniteMeasuresState();
}

class _UniteMeasuresState extends State<UniteMeasures> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.details.toString() != "{}"){
      print("DETAILS ${widget.details}");
      parameters.id = widget.details["id"].toString();
      parameters.weight_unit = widget.details["unit"]["weight"].toString();
      parameters.height_unit = widget.details["unit"]["height"].toString();
      parameters.alcohol = widget.details["tracking"]["alcohol"].toString();
      parameters.tobacco = widget.details["tracking"]["tobacco"].toString();
      parameters.food_supplement = widget.details["tracking"]["food_supplement"].toString();
      parameters.medicine = widget.details["tracking"]["medicine"].toString();
      parameters.coffee = widget.details["tracking"]["coffee"].toString();
      parameters.water = widget.details["tracking"]["water"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Unité de mesures",style: TextStyle(color: AppColors.pinkColor,fontSize: 17,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Le poids",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
            Spacer(),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.weight_unit = "kg";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.weight_unit == "kg" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.weight_unit == "kg",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.weight_unit = "kg";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Kg",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.weight_unit = "lb";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.weight_unit == "lb" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.weight_unit == "lb",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.weight_unit = "lb";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Lb",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Distance",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
            Spacer(),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.height_unit = "Cm";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.height_unit == "Cm" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.height_unit == "Cm",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.height_unit = "Cm";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Cm",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.height_unit = "Km";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.height_unit == "Km" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.height_unit == "Km",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.height_unit = "Km";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Km",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text("Choisis les tracking journalier qui \ncorrespondent à ton profil",style: TextStyle(color: AppColors.pinkColor,fontSize: 17,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Tabac",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
            Spacer(),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.tobacco = "Oui";
                  });
                }
              },
              child: ZoomTapAnimation(
                end: 0.99,child:
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.tobacco == "Oui" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.tobacco == "Oui",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.tobacco = "Oui";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Oui",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.tobacco = "Non";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.tobacco == "Non" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.tobacco == "Non",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.tobacco = "Non";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Non",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Alcool",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
            Spacer(),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.alcohol = "Oui";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.alcohol == "Oui" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.alcohol == "Oui",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.alcohol = "Oui";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Oui",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.alcohol = "Non";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.alcohol == "Non" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.alcohol == "Non",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.alcohol = "Non";
                                  });                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Non",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Complément \nalimentaire",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
            Spacer(),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.food_supplement = "Oui";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.food_supplement == "Oui" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.food_supplement == "Oui",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.food_supplement = "Oui";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Oui",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.food_supplement = "Non";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.food_supplement == "Non" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.food_supplement == "Non",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.food_supplement = "Non";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Non",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Médicaments",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
            Spacer(),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.medicine = "Oui";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.medicine == "Oui" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.medicine == "Oui",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.medicine = "Oui";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Oui",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.medicine = "Non";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.medicine == "Non" ? AppColors.appmaincolor : Colors.transparent),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: 0.9,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              checkColor: Colors.transparent,
                              activeColor: AppColors.appmaincolor,
                              value: parameters.medicine == "Non",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.medicine = "Non";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Non",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Café",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
            Spacer(),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.coffee = "Oui";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: parameters.coffee == "Oui" ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: parameters.coffee == "Oui",
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              if(!Auth.isNotSubs!){
                                setState(() {
                                  parameters.coffee = "Oui";
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Oui",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.coffee = "Non";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: parameters.coffee == "Non" ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: parameters.coffee == "Non",
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              if(!Auth.isNotSubs!){
                                setState(() {
                                  parameters.coffee = "Non";
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Non",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Eau",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
            Spacer(),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.water = "Oui";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: parameters.water == "Oui" ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: parameters.water == "Oui",
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              if(!Auth.isNotSubs!){
                                setState(() {
                                  parameters.water = "Oui";
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Oui",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                if(!Auth.isNotSubs!){
                  setState(() {
                    parameters.water = "Non";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: parameters.water == "Non" ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: parameters.water == "Non",
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              if(!Auth.isNotSubs!){
                                setState(() {
                                  parameters.water = "Non";
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border:   Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Non",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
