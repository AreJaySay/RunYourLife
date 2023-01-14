import 'dart:io';
import 'package:flutter/material.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../functions/loaders.dart';
import '../../../models/device_model.dart';
import '../../../services/apis_services/subscriptions/choose_plan.dart';
import '../../../services/stream_services/screens/coaching.dart';
import '../../coaching/components/enter_card.dart';
import '../../coaching/components/view_details.dart';

class WeeklyUpdate extends StatefulWidget {
  @override
  State<WeeklyUpdate> createState() => _WeeklyUpdateState();
}

class _WeeklyUpdateState extends State<WeeklyUpdate> {
  final Routes _routes = new Routes();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ChoosePlanService _choosePlanService = new ChoosePlanService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 150),
              child: Image(
                color: Colors.grey.withOpacity(0.1),
                width: 150,
                image: AssetImage("assets/icons/lock_half.png",),
                alignment: Alignment.centerLeft,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: Center(
                            child:  Platform.isAndroid ? Icon(Icons.arrow_back,color: Colors.white,size: 22,) :  Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 22,),
                          ),
                          decoration: BoxDecoration(
                            gradient: AppGradientColors.gradient,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                        onTap: (){
                          Navigator.of(context).pop(null);
                        },
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("PROGRAMMER UN \nPOINT HEBDOMADAIRE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text("Vous souhaitez avoir un \néchange avec votre coach ?",style: TextStyle(fontSize: 21,color: Colors.black,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 50,
                  ),
                  ZoomTapAnimation(
                    end: 0.99,
                    onTap: (){
                      // _screenLoaders.functionLoader(context);
                      // _choosePlanService.choosePlan(context, planDetails: coachingStreamServices.currentdata[1], code: "", card_number: "4242424242424242", expiration_date_month: "11", expiration_date_year: "2023", cvc: "314").then((value){
                      //   if(value != null){
                      //     _routes.navigator_pushreplacement(context, ViewCoachingDetails(planDetails: coachingStreamServices.currentdata[1],choosePlan: value,));
                      //   }
                      // });
                    },
                    child: Container(
                      width: double.infinity,
                      height: DeviceModel.isMobile ? 130 : 160,
                      decoration: BoxDecoration(
                          gradient: AppGradientColors.gradient,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Stack(
                        children: [
                          Image(
                            color: Colors.white.withOpacity(0.1),
                            width: double.infinity,
                            image: AssetImage("assets/icons/coaching.png",),
                            fit: BoxFit.contain,
                            alignment: Alignment.centerRight,
                            filterQuality: FilterQuality.high,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("UPGRADER",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "AppFontStyle"),),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text("PACK",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: "AppFontStyle"),),
                                    Text(" 100% ACCOMPAGNÉ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "AppFontStyle"),),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("Laissez-vous porter !",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
