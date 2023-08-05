import 'dart:convert';

import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:intl/intl.dart';

class WaterTracking extends StatefulWidget {
  @override
  _WaterTrackingState createState() => _WaterTrackingState();
}

class _WaterTrackingState extends State<WaterTracking> {
  final Materialbutton _materialbutton = new Materialbutton();
  final HomeServices _homeServices = new HomeServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final AppBars _appBars = AppBars();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.whiteappbar(context, title: "SUIVI DE LA JOURNÉE"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Image(
              width: double.infinity,
              fit: BoxFit.cover,
              image: AssetImage("assets/important_assets/heart_icon.png"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text("EAU",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Combien de verre(s) d’eau as-tu bu aujourd’hui ?",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 10,
                  ),
                  Text("1 verre d’eau = 25 cl",style: TextStyle(fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 70,
                    child: FlutterSlider(
                      values: [homeTracking.water],
                      max: 16,
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
                            color: homeTracking.water >= 5 ? AppColors.appmaincolor : Colors.redAccent,
                            borderRadius: BorderRadius.circular(1000)
                        ),
                        inactiveTrackBar: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      handler: FlutterSliderHandler(
                          decoration: BoxDecoration(
                              color: homeTracking.water >= 5 ? AppColors.appmaincolor : Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(homeTracking.water.floor().toString(),style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
                      ),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          homeTracking.water = lowerValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
