import 'dart:io';
import 'package:flutter/material.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../models/device_model.dart';
import '../../../services/stream_services/screens/coaching.dart';
import '../../../utils/palettes/app_colors.dart';
import '../../../utils/palettes/app_gradient_colors.dart';
import '../../coaching/components/enter_card.dart';
import '../../coaching/components/view_details.dart';

class SendTracking extends StatefulWidget {
  @override
  State<SendTracking> createState() => _SendTrackingState();
}

class _SendTrackingState extends State<SendTracking> {
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 180),
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
                      Text("ENVOYER VOS \nTRACKING",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text("Vous souhaitez avoir un \nsuivi hebdomadaire ?",style: TextStyle(fontSize: 21,color: Colors.black,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 50,
                  ),
                  ZoomTapAnimation(
                    end: 0.99,
                    onTap: (){
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                          isScrollControlled: true,
                          context: context, builder: (context){
                        return EnterCreditCard(title: "SUBSCRIBE TO MACRO SOLO",details:coachingStreamServices.currentdata[1],);
                      });
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
                                Text("Voir des  conseils vipersonnalisés !",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),),
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
