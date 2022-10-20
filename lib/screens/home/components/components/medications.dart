import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class MedicationTracking extends StatefulWidget {
  @override
  _MedicationTrackingState createState() => _MedicationTrackingState();
}

class _MedicationTrackingState extends State<MedicationTracking> {
  final Materialbutton _materialbutton = new Materialbutton();
  final HomeServices _homeServices = new HomeServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final AppBars _appBars = AppBars();
  TextEditingController _medication = new TextEditingController()..text=homeTracking.medication.toString() == "null"? "" : homeTracking.medication;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _medication.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: _appBars.whiteappbar(context, title: "TRACKING JOURNÉE"),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
            children: [
              Text("MÉDICAMENTS",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
              SizedBox(
                height: 20,
              ),
              Text("As-tu pris des médicaments aujourd’hui ?",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)
                ),
                child: TextField(
                  controller: _medication,
                  maxLines: 5,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      border: InputBorder.none,
                      hintText: "Décrivez les compléments alimentaires que vous avez pris aujourd’hui",
                      hintStyle: TextStyle(color: Colors.grey[400],fontFamily: "AppFontStyle")
                  ),
                  onChanged: (text){
                    setState((){
                      homeTracking.medication = text;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ZoomTapAnimation(
                end: 0.99,
                child: Container(
                  margin: EdgeInsets.only(right: 130),
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Colors.white
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 2,
                          groupValue: homeTracking.medication == "Aucun médicament" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              _medication.text = "";
                              homeTracking.medication = "Aucun médicament";
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Aucun médicament",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),)
                    ],
                  ),
                ),
                onTap: (){
                  setState(() {
                    _medication.text = "";
                    homeTracking.medication = "Aucun médicament";
                  });
                },
              ),
              SizedBox(
                height: 140,
              ),
              _materialbutton.materialButton("VALIDER", () {
                _screenLoaders.functionLoader(context);
                _homeServices.submit_tracking(context).then((value){
                  if(value != null){
                    _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime.parse(homeTracking.date))).then((value){
                      Navigator.of(context).pop(null);
                      Navigator.of(context).pop(null);
                    });
                  }
                });
              }),
              SizedBox(
                height: 15,
              ),
              InkWell(
                child: Container(
                  width: double.infinity,
                  height: 55,
                  child: Center(
                    child: Text("ANNULER",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600),),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pop(null);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}