import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';



class SupplementTracking extends StatefulWidget {
  @override
  _SupplementTrackingState createState() => _SupplementTrackingState();
}

class _SupplementTrackingState extends State<SupplementTracking> {
  final Materialbutton _materialbutton = new Materialbutton();
  final HomeServices _homeServices = new HomeServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final AppBars _appBars = AppBars();
  TextEditingController _supplements = new TextEditingController()..text=homeTracking.supplements.toString() == "null"? "" : homeTracking.supplements;
  bool _keyboardVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KeyboardVisibilityController().onChange.listen((event) {
      Future.delayed(Duration(milliseconds:  100), () {
        setState(() {
          _keyboardVisible = event;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: _appBars.whiteappbar(context, title: "SUIVI DE LA JOURNÉE"),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _keyboardVisible ? Container() :Text("COMPLÉMENT ALIMENTAIRE",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
              _keyboardVisible ? Container() :SizedBox(
                height: 20,
              ),
              _keyboardVisible ? Container() :Text("As-tu pris des compléments alimentaires aujourd’hui ?",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
              _keyboardVisible ? Container() : SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)
                ),
                child: TextField(
                  controller: _supplements,
                  maxLines: 5,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      border: InputBorder.none,
                      hintText: "Décris les compléments alimentaires que tu as pris aujourd’hui",
                      hintStyle: TextStyle(color: Colors.grey[400],fontFamily: "AppFontStyle")
                  ),
                  onChanged: (text){
                    setState((){
                      homeTracking.supplements = text;
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
                  margin: EdgeInsets.only(right: 40),
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
                          groupValue: homeTracking.supplements == "Aucun complément alimentaire" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              _supplements.text = "";
                              homeTracking.supplements = "Aucun complément alimentaire";
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Aucun complément alimentaire",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),)
                    ],
                  ),
                ),
                onTap: (){
                  setState(() {
                    _supplements.text = "";
                    homeTracking.supplements = "Aucun complément alimentaire";
                  });
                },
              ),
              Spacer(),
              _materialbutton.materialButton("VALIDER", () {
                _screenLoaders.functionLoader(context);
                _homeServices.submit_tracking(context).then((value){
                  if(value != null){
                    _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.parse(homeTracking.date))).then((value){
                      Navigator.of(context).pop(null);
                      Navigator.of(context).pop(null);
                    });
                  }
                });
              }),
              SizedBox(
                height: _keyboardVisible ? 10 : 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}