import 'dart:convert';

import 'package:another_xlider/another_xlider.dart';
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


class StressTracking extends StatefulWidget {
  @override
  _StressTrackingState createState() => _StressTrackingState();
}

class _StressTrackingState extends State<StressTracking> {
  final Materialbutton _materialbutton = new Materialbutton();
  final HomeServices _homeServices = new HomeServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Routes _routes = new Routes();
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
                  Text("STRESS",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Sur une échelle de 0 à 10, quel est ton niveau de stress de la journée ? \n0 : pas stressé(e)\n10 : très stressé(e)",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 70,
                    child: FlutterSlider(
                      values: [homeTracking.stress],
                      max: 10,
                      min: 0,
                      handlerWidth: 50,
                      handlerHeight: 40,
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
                            color:Colors.grey[200],
                            borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                      handler: FlutterSliderHandler(
                          decoration: BoxDecoration(
                              color: AppColors.appmaincolor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(homeTracking.stress.floor().toString(),style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
                      ),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          homeTracking.stress = lowerValue;
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  _materialbutton.materialButton("VALIDER", () {
                    _screenLoaders.functionLoader(context);
                    _homeServices.submit_tracking(context).then((value){
                      if(value != null){
                        _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime.parse(homeTracking.date))).then((value){
                          if(value != null){
                            Navigator.of(context).pop(null);
                            Navigator.of(context).pop(null);
                          }
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
