import 'dart:convert';

import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AlcoholTracking extends StatefulWidget {
  @override
  _AlcoholTrackingState createState() => _AlcoholTrackingState();
}

class _AlcoholTrackingState extends State<AlcoholTracking> {
  final Materialbutton _materialbutton = new Materialbutton();
  final HomeServices _homeServices = new HomeServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final AppBars _appBars = AppBars();

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
              Text("ALCOOL",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
              SizedBox(
                height: 20,
              ),
              Text("Combien de verre d’alcool as-tu bu aujourd’hui ?",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
              SizedBox(
                height: 10,
              ),
              Text("1 = 1 verre de vin ou 25 cl de bière",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
              SizedBox(
                height: 5,
              ),
              Text("2 = 1 verre d’alcool fort, shooter, 50 cl de bière",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                child: FlutterSlider(
                  values: [homeTracking.alcohol],
                  max: 20,
                  min: 0,
                  handlerWidth: 65,
                  handlerHeight: 45,
                  tooltip: FlutterSliderTooltip(
                      alwaysShowTooltip: false,
                      disabled: true
                  ),
                  trackBar: FlutterSliderTrackBar(
                    inactiveTrackBarHeight: 10,
                    activeTrackBarHeight: 10,
                    activeTrackBar: BoxDecoration(
                        color: AppColors.appmaincolor,
                        borderRadius: BorderRadius.circular(1000)
                    ),
                    inactiveTrackBar: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(1000)
                    ),
                  ),
                  handler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                          color: AppColors.appmaincolor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(homeTracking.alcohol.floor().toString(),style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      homeTracking.alcohol = lowerValue;
                    });
                  },
                ),
              ),
              Spacer(),
              _materialbutton.materialButton("VALIDER", () {
                _screenLoaders.functionLoader(context);
                _homeServices.submit_tracking(context).then((value){
                  if(value != null){
                    _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.parse(homeTracking.date))).then((value){
                      if(value != null){
                        Navigator.of(context).pop(null);
                        Navigator.of(context).pop(null);
                      }
                    });
                  }
                });
              }),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}