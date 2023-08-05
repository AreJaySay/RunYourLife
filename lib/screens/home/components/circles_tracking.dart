import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/checkin/tracking.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/screens/checkin/components/my_tracking/my_tracking.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/home.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../widgets/finish_questioner_popup.dart';

class CirclesTracking extends StatefulWidget {
  final bool isHome;
  CirclesTracking({this.isHome = true});
  @override
  _CirclesTrackingState createState() => _CirclesTrackingState();
}

class _CirclesTrackingState extends State<CirclesTracking> {
  final Routes _routes = new Routes();
  List _tracking = ["Protéines","Lipides","Glucides","Légumes"];


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: homeStreamServices.subject,
      builder: (context, snapshot) {
        return subscriptionDetails.currentdata[0]["macro_status"] == false ?
        ZoomTapAnimation(
          end: 0.99,
          onTap: ()async{
            await showModalBottomSheet(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
            isScrollControlled: true,
            context: context, builder: (context){
            return FinishQuestionerPopup();
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5.0, // has the effect of softening the shadow
                  spreadRadius: 0.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    1.0, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: DeviceModel.isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for(var x = 0; x < _tracking.length; x++)...{
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: DeviceModel.isMobile ? 34.0 : 40,
                        lineWidth: 7,
                        animation: true,
                        percent: 1,
                        center: Text("--",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.grey,fontSize: 20,fontFamily: "AppFontStyle"),),
                        circularStrokeCap: CircularStrokeCap.butt,
                        progressColor: Colors.grey[300],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(_tracking[x],style: TextStyle(fontSize: 13.0,fontFamily: "AppFontStyle", color: Colors.grey),)
                    ],
                  )},
              ],
            ),
          ),
        ) :
        ZoomTapAnimation(
          onTap:(){
            if(snapshot.data!["clientTracking"].toString() != "null"){
              setState(() {
                tracking.protein = double.parse(snapshot.data!["clientTracking"]["protein"].toString());
                tracking.lipid = double.parse(snapshot.data!["clientTracking"]["lipid"].toString());
                tracking.carbohydrate = double.parse(snapshot.data!["clientTracking"]["carbohydrate"].toString());
                tracking.vegetable = double.parse(snapshot.data!["clientTracking"]["vegetable"].toString());
              });
            }else{
              setState(() {
                tracking.protein = 0;
                tracking.lipid = 0;
                tracking.carbohydrate = 0;
                tracking.vegetable = 0;
              });
            }
            _routes.navigator_push(context, MyTracking(initialDate: DateTime.parse(HomeTracking.currentDate!),));
          },
          end: 0.99,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            decoration: widget.isHome ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5.0, // has the effect of softening the shadow
                    spreadRadius: 0.0, // has the effect of extending the shadow
                    offset: Offset(
                      0.0, // horizontal, move right 10
                      1.0, // vertical, move down 10
                    ),
                  )
                ],
            )  : null,
            child: Row(
              mainAxisAlignment: DeviceModel.isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(!snapshot.hasData)...{
                  for(var x = 0; x < _tracking.length; x++)...{
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: DeviceModel.isMobile ? 34.0 : 40,
                          lineWidth: 7,
                          animation: true,
                          percent: 1,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("-",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.grey,fontSize: 20,fontFamily: "AppFontStyle"),),
                              Text("-",style: TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "AppFontStyle"),),
                            ],
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          progressColor: Colors.grey[300],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(_tracking[x],style: TextStyle(fontSize: 13.0,fontFamily: "AppFontStyle", color: AppColors.appmaincolor),)
                      ],
                    )},
                }else if(snapshot.data!["clientTracking"].toString() == "null" || snapshot.data!["clientTracking"]["message"] == "no data available")...{
                  for(var x = 0; x < _tracking.length; x++)...{
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius:  DeviceModel.isMobile ? 35.0 : 40,
                          lineWidth: 7,
                          animation: true,
                          percent: 1,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("0",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.grey,fontSize: 20,fontFamily: "AppFontStyle"),),
                              Text(subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? "0" : double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0][x == 0 ? "protein" : x == 1 ? "lipid" : x == 2 ? "carbohydrate" : "vegetable"].toString()).floor().toString(),style: TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "AppFontStyle"),)
                            ],
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          progressColor: Colors.grey[300],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(_tracking[x],style: TextStyle(fontSize: 13.0,fontFamily: "AppFontStyle", color: AppColors.appmaincolor),)
                      ],
                    )}
                }else...{
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 35.0,
                        lineWidth: 7,
                        animation: true,
                        animationDuration: 600,
                        percent: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? 1.0 : double.parse(snapshot.data!["clientTracking"]["protein"].toString()) >= double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["protein"].toString()) ? 1.0 : double.parse(snapshot.data!["clientTracking"]["protein"].toString())/double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["protein"].toString()),
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(double.parse(snapshot.data!["clientTracking"]["protein"].toString()).floor().toString(),style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 20,fontFamily: "AppFontStyle"),),
                            Text(subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? "0" : double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["protein"].toString()).floor().toString(),style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        progressColor: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? AppColors.appmaincolor : double.parse(snapshot.data!["clientTracking"]["protein"].toString()).floor() > double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["protein"].toString()) ? Colors.redAccent : AppColors.appmaincolor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(_tracking[0],style: TextStyle(fontSize: 13.0,fontFamily: "AppFontStyle", color: Colors.black),)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 35.0,
                        lineWidth: 7,
                        animation: true,
                        animationDuration: 600,
                        percent: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? 1.0 : double.parse(snapshot.data!["clientTracking"]["lipid"].toString()).floor() >= double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["lipid"].toString()) ? 1.0 : double.parse(snapshot.data!["clientTracking"]["lipid"].toString())/double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["lipid"].toString()),
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(double.parse(snapshot.data!["clientTracking"]["lipid"].toString()).floor().toString(),style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 20,fontFamily: "AppFontStyle"),),
                            Text(subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? "0" : double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["lipid"].toString()).floor().toString(),style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        progressColor: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? AppColors.appmaincolor : double.parse(snapshot.data!["clientTracking"]["lipid"].toString()).floor() > double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["lipid"].toString()) ? Colors.redAccent : AppColors.appmaincolor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(_tracking[1],style: TextStyle(fontSize: 13.0,fontFamily: "AppFontStyle", color: Colors.black),)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 35.0,
                        lineWidth: 7,
                        animation: true,
                        animationDuration: 600,
                        percent: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? 1.0 : double.parse(snapshot.data!["clientTracking"]["carbohydrate"].toString()).floor() >= double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["carbohydrate"].toString()) ? 1.0 : double.parse(snapshot.data!["clientTracking"]["carbohydrate"].toString())/double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["carbohydrate"].toString()),
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(double.parse(snapshot.data!["clientTracking"]["carbohydrate"].toString()).floor().toString(),style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 20,fontFamily: "AppFontStyle"),),
                            Text(subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? "0" : double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["carbohydrate"].toString()).floor().toString(),style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        progressColor: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? AppColors.appmaincolor : double.parse(snapshot.data!["clientTracking"]["carbohydrate"].toString()).floor() > double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["carbohydrate"].toString()) ? Colors.redAccent : AppColors.appmaincolor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(_tracking[2],style: TextStyle(fontSize: 13.0,fontFamily: "AppFontStyle", color: Colors.black),)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 35.0,
                        lineWidth: 7,
                        animation: true,
                        animationDuration: 600,
                        percent: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? 1.0 : double.parse(snapshot.data!["clientTracking"]["vegetable"].toString()).floor() >= double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["vegetable"].toString()) ? 1.0 : double.parse(snapshot.data!["clientTracking"]["vegetable"].toString())/double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["vegetable"].toString()),
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(double.parse(snapshot.data!["clientTracking"]["vegetable"].toString()).floor().toString(),style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 20,fontFamily: "AppFontStyle"),),
                            Text(subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? "0" : double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["vegetable"].toString()).floor().toString(),style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        progressColor: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? AppColors.appmaincolor : double.parse(snapshot.data!["clientTracking"]["vegetable"].toString()).floor() > double.parse(subscriptionDetails.currentdata[0]["coach_macros"][0]["vegetable"].toString()) ? Colors.redAccent : AppColors.appmaincolor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(_tracking[3],style: TextStyle(fontSize: 13.0,fontFamily: "AppFontStyle", color: Colors.black),)
                    ],
                  ),
                }
              ],
            ),
          ),
        );
      }
    );
  }
}
