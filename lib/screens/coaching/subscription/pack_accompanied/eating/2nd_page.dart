import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../../../../../services/stream_services/subscriptions/subscription_details.dart';

class Eating2ndPage extends StatefulWidget {
  @override
  _Eating2ndPageState createState() => _Eating2ndPageState();
}

class _Eating2ndPageState extends State<Eating2ndPage> {
  TextEditingController _other = new TextEditingController();
  int _horizontalSelected = 10;
  String? _horizontalChoosen;
  List<String> _horizontalTitle = ["Entre 0 et 1 an","Il y'a plus de 2 ans","Il y'a 1 an / 2ans"];
  List<String> _preferences = ["Hypocalorique","type Dukan","Cétogène","Monodiète","Autre"];
  String? _verticalChoosen;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _other.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    step2subs.follow_drastic_diet = "Non";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("AS-TU SUIVI UN RÉGIME DRASTIQUE ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step2subs.follow_drastic_diet.contains("Oui") ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Transform.scale(
                        scale: 1.4,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 1,
                          groupValue: step2subs.follow_drastic_diet.contains("Oui") ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step2subs.follow_drastic_diet = "Oui";
                            });
                          }
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Oui',style: new TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step2subs.follow_drastic_diet = "Oui";
                });
              },
            ),
            SizedBox(
              width: 30,
            ),
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step2subs.follow_drastic_diet.contains("Non") ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Transform.scale(
                        scale: 1.4,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 2,
                          groupValue: step2subs.follow_drastic_diet.contains("Non") ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step2subs.follow_drastic_diet = "Non";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Non',style: new TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step2subs.follow_drastic_diet = "Non";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
      step2subs.follow_drastic_diet == "Non" ? Container() :
       Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Il y'a combien de temps".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 20,
            ),
            for(var x = 0 ;x < _horizontalTitle.length;x ++)...{
              ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _horizontalSelected == x ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                      child: Center(
                        child: Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            color: _horizontalSelected == x ? AppColors.appmaincolor : Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(_horizontalTitle[x], style: new TextStyle(fontSize: 15,
                          color: Colors.black,fontFamily: "AppFontStyle"),),
                    ),
                  ],
                ),
              ),
                onTap: (){
                  setState(() {
                    _horizontalSelected = x;
                    _horizontalChoosen = _horizontalTitle[x];
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
            },
            SizedBox(
              height: 20,
            ),
            Text(subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? "Si oui, lequel".toUpperCase() : "Si oui, lequel (possibilité de dire lequel dans autre)".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 15,
            ),
            for(var x = 0 ;x < _preferences.length;x ++)...{
              ZoomTapAnimation(end: 0.99,child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color:  _verticalChoosen == _preferences[x] ? AppColors.appmaincolor : Colors.transparent,)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 23,
                        height: 23,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                        child: Center(
                          child: Container(
                            width: 17,
                            height: 17,
                            decoration: BoxDecoration(
                              color: _verticalChoosen == _preferences[x] ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(_preferences[x], style: new TextStyle(fontSize: 15,
                            color: Colors.black,fontFamily: "AppFontStyle"),),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  setState(() {
                    _verticalChoosen = _preferences[x];
                    _other.text = "";
                    step2subs.follow_drastic_diet = "${step2subs.follow_drastic_diet},${_horizontalChoosen},${_preferences[x]}";
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
            },
            SizedBox(
              height: 10,
            ),
            _verticalChoosen == "Autre" ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                onChanged: (text){
                  setState(() {
                    step2subs.follow_drastic_diet = "${step2subs.follow_drastic_diet},${_horizontalChoosen},${text}";
                  });
                },
                style: TextStyle(fontFamily: "AppFontStyle"),
                controller: _other,
                maxLines: 4,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    border: InputBorder.none,
                    hintText: "Autres...",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ) : Container(),
          ],
        ),
      ],
    );
  }
}