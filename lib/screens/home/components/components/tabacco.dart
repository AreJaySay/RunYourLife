import 'dart:convert';

import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
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

class TabaccoTracking extends StatefulWidget {
  @override
  _TabaccoTrackingState createState() => _TabaccoTrackingState();
}

class _TabaccoTrackingState extends State<TabaccoTracking> {
  final Materialbutton _materialbutton = new Materialbutton();
  final HomeServices _homeServices = new HomeServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final AppBars _appBars = AppBars();
  final TextEditingController _tobbaco = new TextEditingController()..text=homeTracking.smoke.toString() == "null" ? "" : homeTracking.smoke.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.whiteappbar(context, title: "TRACKING JOURNÉE"),
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
                  Text("TABAC",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 20,
                  ),
                  Text("As-tu fumé aujourd’hui ?",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      border: Border.all(color: Colors.grey)
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontFamily: "AppFontStyle"),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontFamily: "AppFontStyle",color: Colors.grey),
                        hintText: "Entrez le nombre de cigarettes",
                      ),
                      onChanged: (value){
                        setState(() {
                          homeTracking.smoke = double.parse(value.toString());
                        });
                      },
                    ),
                  ),
                  // Container(
                  //   height: 70,
                  //   child: FlutterSlider(
                  //     values: [homeTracking.smoke],
                  //     max: 10,
                  //     min: 0,
                  //     handlerWidth: 65,
                  //     handlerHeight: 45,
                  //     tooltip: FlutterSliderTooltip(
                  //         alwaysShowTooltip: false,
                  //         disabled: true
                  //     ),
                  //     trackBar: FlutterSliderTrackBar(
                  //       inactiveTrackBarHeight: 10,
                  //       activeTrackBarHeight: 10,
                  //       activeTrackBar: BoxDecoration(
                  //           color: homeTracking.smoke > 6 ? Colors.redAccent : AppColors.appmaincolor,
                  //           borderRadius: BorderRadius.circular(1000)
                  //       ),
                  //       inactiveTrackBar: BoxDecoration(
                  //           color: Colors.grey[200],
                  //           borderRadius: BorderRadius.circular(1000)
                  //       ),
                  //     ),
                  //     handler: FlutterSliderHandler(
                  //         decoration: BoxDecoration(
                  //             color: homeTracking.smoke > 6 ? Colors.redAccent : AppColors.appmaincolor,
                  //             borderRadius: BorderRadius.circular(10)
                  //         ),
                  //         child: Text(homeTracking.smoke.floor().toString(),style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
                  //     ),
                  //     onDragging: (handlerIndex, lowerValue, upperValue) {
                  //       setState(() {
                  //         homeTracking.smoke = lowerValue;
                  //       });
                  //     },
                  //   ),
                  // ),
                  Spacer(),
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
          ],
        ),
      ),
    );
  }
}
