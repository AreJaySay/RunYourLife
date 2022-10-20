import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

import '../../services/stream_services/subscriptions/subscription_details.dart';

class NotificationMessage{
  Future<void> notificSnackbar(context,{required String message,})async{
    await Flushbar(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subscriptionDetails.currentdata[0]["coach"]["full_name"].toString(),style: TextStyle(fontSize: 15.5,fontFamily: "AppFontStyle",color: Colors.white),),
          Text("maintenant",style: TextStyle(fontFamily: "AppFontStyle",color: Colors.grey[300]),),
        ],
      ),
      isDismissible: true,
      messageText: Text(message,style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),),
      duration: Duration(seconds: 20),
      backgroundColor: Colors.blueGrey.withOpacity(0.9),
      margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      borderRadius: BorderRadius.circular(5),
      icon: Center(
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: AppColors.appmaincolor,width: 2),
              borderRadius: BorderRadius.circular(1000),
              image: subscriptionDetails.currentdata[0]["coach"]["logo"] == null ?
              DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/icons/no_profile.png")
              ) :
              DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(subscriptionDetails.currentdata[0]["coach"]["logo"])
              )
          ),
        ),
      ),
      maxWidth: double.infinity,
    )..show(context);
  }
}