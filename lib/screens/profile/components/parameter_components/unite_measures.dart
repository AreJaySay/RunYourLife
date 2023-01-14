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
  List<String> _titles = ["Stress","Sommeil","Tabac","Alcool","Complément\nalimentaire","Médicaments","Café","Eau","Entraînements","Suivi de Cycle"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.details.toString() != "{}"){
      print("DETAILS ${widget.details}");
      parameters.id = widget.details["id"].toString();
      parameters.weight_unit = widget.details["unit"]["weight"].toString();
      parameters.height_unit = widget.details["unit"]["height"].toString();
      parameters.trackings[0] = widget.details["tracking"]["stress"].toString();
      parameters.trackings[1] = widget.details["tracking"]["sleep"].toString();
      parameters.trackings[3] = widget.details["tracking"]["alcohol"].toString();
      parameters.trackings[2] = widget.details["tracking"]["tobacco"].toString();
      parameters.trackings[4] = widget.details["tracking"]["food_supplement"].toString();
      parameters.trackings[5] = widget.details["tracking"]["medicine"].toString();
      parameters.trackings[6] = widget.details["tracking"]["coffee"].toString();
      parameters.trackings[7] = widget.details["tracking"]["water"].toString();
      parameters.trackings[8] = widget.details["tracking"]["training"].toString();
      parameters.trackings[9] = widget.details["tracking"]["menstruation"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Unités de mesure",style: TextStyle(color: AppColors.pinkColor,fontSize: 17,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Poids",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
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
                      border: Border.all(color: parameters.weight_unit.toLowerCase() == "kg" ? AppColors.appmaincolor : Colors.transparent),
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
                              value: parameters.weight_unit.toLowerCase() == "kg",
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
                      border: Border.all(color: parameters.weight_unit.toLowerCase() == "lb" ? AppColors.appmaincolor : Colors.transparent),
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
                              value: parameters.weight_unit.toLowerCase() == "lb",
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
            Text("Mesure",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
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
                    parameters.height_unit = "In";
                  });
                }
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.height_unit == "In" ? AppColors.appmaincolor : Colors.transparent),
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
                              value: parameters.height_unit == "In",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.height_unit = "In";
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
                      Text("In",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
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
        Text("Choisis les trackings journaliers qui \ncorrespondent à ton profil.",style: TextStyle(color: AppColors.pinkColor,fontSize: 17,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(int x = 0; Auth.loggedUser!["gender"].toString().toLowerCase() == "male" ? x < 9 : x < 10; x++)...{
          Row(
            children: [
              Text(_titles[x],style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
              Spacer(),
              GestureDetector(
                onTap: (){
                  if(!Auth.isNotSubs!){
                    setState(() {
                      parameters.trackings[x] = "1";
                    });
                  }
                },
                child: ZoomTapAnimation(
                  end: 0.99,child:
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.trackings[x] == "1" ? AppColors.appmaincolor : Colors.transparent),
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
                              value: parameters.trackings[x] == "1",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.trackings[x] = "1";
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
                      parameters.trackings[x] = "0";
                    });
                  }
                },
                child: ZoomTapAnimation(end: 0.99,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: parameters.trackings[x] == "0" ? AppColors.appmaincolor : Colors.transparent),
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
                              value: parameters.trackings[x] == "0",
                              shape: CircleBorder(),
                              splashRadius: 20,
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent
                              ),
                              onChanged: (bool? value) {
                                if(!Auth.isNotSubs!){
                                  setState(() {
                                    parameters.trackings[x] = "0";
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
            height: 15,
          )
        }
      ],
    );
  }
}
