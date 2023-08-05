import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class SnackbarMessage{
  final GlobalKey flushBarKey = GlobalKey();

  Future<void> snackbarMessage(context,{String? message,bool is_error = false,bool isChat = false, bool isReminder = false})async{
    await Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      key: flushBarKey,
      messageText: Text(message!,style: TextStyle(color: Colors.white,fontSize: 14.5,fontFamily: "AppFontStyle"),),
      icon: isReminder ?
      Icon(
        Icons.notifications_active,
        size: 28.0,
        color: Colors.orangeAccent,
      ) :
      is_error ? Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white,
      ) : Icon(Icons.check_circle,color: Colors.green,),
      duration: Duration(seconds: isReminder ? 30 : isChat ? 10 : 6),
      leftBarIndicatorColor: isReminder ? Colors.orangeAccent : is_error ? Colors.red : Colors.green,
      backgroundColor: is_error ? Colors.black.withOpacity(0.9) : Colors.blueGrey,
      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
      borderRadius: BorderRadius.circular(5),
      mainButton:
      IconButton(
        icon: Icon(Icons.close,color: Colors.white,),
        onPressed: (){
          (flushBarKey.currentWidget as Flushbar).dismiss();
        },
      ),
    )..show(context);
  }
}