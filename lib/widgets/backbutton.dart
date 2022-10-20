import 'package:flutter/material.dart';
import 'dart:io';

import '../services/stream_services/screens/notification_notify.dart';

class PageBackButton extends StatefulWidget {
  final Color iconColor,bckground;
  final double margin;
  final bool isMessage;
  PageBackButton({this.iconColor = Colors.pinkAccent,this.bckground = Colors.white, this.margin = 20, this.isMessage = false});
  @override
  _PageBackButtonState createState() => _PageBackButtonState();
}

class _PageBackButtonState extends State<PageBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(widget.margin),
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Center(
          child:  Platform.isAndroid ? Icon(Icons.arrow_back,color: widget.iconColor,size: 22,) :  Icon(Icons.arrow_back_ios_sharp,color: widget.iconColor,size: 22,),
        ),
        decoration: BoxDecoration(
          color: widget.bckground,
          borderRadius: BorderRadius.circular(1000),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5.0, // has the effect of softening the shadow
              spreadRadius: 0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                2.0, // vertical, move down 10
              ),
            )
          ],
        ),
      ),
      onTap: (){
        setState(() {
          if(widget.isMessage){
            notificationNotifyStreamServices.update(data: false);
          }
          Navigator.of(context).pop(null);
        });
      },
    );
  }
}
