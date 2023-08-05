import 'dart:async';

import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/reminder_helper.dart';
import 'package:run_your_life/models/screens/profile/parameters.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';

import '../../../../services/apis_services/screens/home.dart';

class ParametersChangeHour extends StatefulWidget {
  final int index;
  ParametersChangeHour({required this.index});
  @override
  _ParametersChangeHourState createState() => _ParametersChangeHourState();
}

class _ParametersChangeHourState extends State<ParametersChangeHour> {
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ParameterServices _parameterServices = new ParameterServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();
  final NotificationService _notificationService = NotificationService();
  final HomeServices _homeServices = new HomeServices();
  final AppBars _appBars = new AppBars();
  int _hoursselected = 1;
  int? _minutesselected = 0;
  FixedExtentScrollController _hoursController =
  FixedExtentScrollController(initialItem: 1);
  FixedExtentScrollController _minutesController =
  FixedExtentScrollController(initialItem: 0);
  double _days = 1;
  // Timer? timer;
  //
  // Future _reminders({String secondTime = "",String thirdTime = "",required bool hasMeeting, required String daysLeft})async{
  //   final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  //   if(secondTime != ""){
  //     await _notificationService.scheduleNotifications(
  //         id: 1,
  //         title: "RAPPEL",
  //         body: "N'oublie pas de faire ton journal de bord journalier",
  //         time: tz.TZDateTime.from(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, int.parse(secondTime.split(":")[0].toString()), int.parse(secondTime.split(":")[1].toString())), tz.getLocation(currentTimeZone)));
  //   }
  //   if(thirdTime != ""){
  //     if(int.parse(daysLeft) >= int.parse(thirdTime.toString().split(",")[1])){
  //       await _notificationService.scheduleNotifications(
  //           id: 1,
  //           title: "RAPPEL",
  //           body: hasMeeting ? "${daysLeft} jours avant mon rendez-vous avec mon coach" : "N'oubliez pas de prendre rendez-vous avec votre coach",
  //           time: tz.TZDateTime.from(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, int.parse(thirdTime.split(":")[0].toString()), int.parse(thirdTime.split(":")[1].toString().replaceAll(",1","").replaceAll(",2","")..replaceAll(",3",""))), tz.getLocation(currentTimeZone)));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      child: Center(
                        child: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 22,),
                      ),
                      decoration: BoxDecoration(
                          gradient: AppGradientColors.gradient,
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        Navigator.of(context).pop(null);
                      });
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("CHOISIR L'HEURE DE \nLA NOTIFICATION",style: TextStyle(color: AppColors.appmaincolor,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              widget.index == 2 ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nombre de jours avant le rendez-vous",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(bottom: 20,top: 10),
                    child: FlutterSlider(
                      values: [_days],
                      max: 3,
                      min: 1,
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
                            color:  AppColors.appmaincolor,
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
                          child: Text(_days.floor().toString(),style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
                      ),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          _days = lowerValue;
                        });
                      },
                    ),
                  ),
                ],
              ) : Container(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Heures",style: TextStyle(color: AppColors.pinkColor,fontWeight: FontWeight.w600,fontSize: 17,fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 250,
                          child: ListWheelScrollView(
                            magnification: 2.0,
                            onSelectedItemChanged: (x) {
                              setState(() {
                                _hoursselected = x;
                              });
                            },
                            controller: _hoursController,
                            children: List.generate(
                                25,
                                    (x) => AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    height: 90 ,
                                    width: 70,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: x == _hoursselected ? AppColors.appmaincolor : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(x > 9 ? '$x' : "0${x.toString()}",style: TextStyle(fontSize: 30,color: x == _hoursselected ? Colors.white : Colors.black,fontWeight: x == _hoursselected ? FontWeight.bold : FontWeight.w600,fontFamily: "AppFontStyle"),))),
                            itemExtent: 90,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    child: Center(
                      child: Text(":",style: TextStyle(color: AppColors.pinkColor,fontSize: 65,fontFamily: "AppFontStyle"),),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Minutes",style: TextStyle(color: AppColors.pinkColor,fontWeight: FontWeight.w600,fontSize: 17,fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 250,
                          child: ListWheelScrollView(
                            magnification: 2.0,
                            onSelectedItemChanged: (x) {
                              setState(() {
                                _minutesselected = x;
                              });
                            },
                            controller: _minutesController,
                            children: List.generate(
                                60,
                                    (x) => AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    height: 120 ,
                                    width: 80,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: x == _minutesselected ? AppColors.appmaincolor : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(x > 9 ? '$x' : "0${x.toString()}",style: TextStyle(fontSize: 30,color: x == _minutesselected ? Colors.white : Colors.black,fontWeight: x == _minutesselected ? FontWeight.bold : FontWeight.w600,fontFamily: "AppFontStyle"),))),
                            itemExtent: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              _materialbutton.materialButton("VALIDER", () {
                setState((){
                  String _hour = _hoursselected > 9 ? '$_hoursselected' : "0${_hoursselected.toString()}";
                  String _min = _minutesselected! > 9 ? '$_minutesselected' : "0${_minutesselected.toString()}";
                  if(widget.index == 1){
                    Parameters.hour2nd = "${_hour}:${_min}";
                  }else{
                    Parameters.hour3rd = "${_hour}:${_min},${_days.floor().toString()}";
                  }
                });
                _screenLoaders.functionLoader(context);
                _parameterServices.submit(context).then((value){
                  if(value != null){
                    _parameterServices.getSetting().whenComplete((){
                      _routes.navigator_pushreplacement(context, Landing(), transitionType: PageTransitionType.leftToRightWithFade);
                      landingServices.updateIndex(index: 4);
                    });
                  }else{
                    Navigator.of(context).pop(null);
                    _snackbarMessage.snackbarMessage(context, message: "Une erreur s'est produite. Veuillez réessayer !", is_error: true);
                  }
                  // _homeServices.getSchedule().then((meeting)async{
                  //   final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
                  //   String _daysLeft = "0";
                  //   if(meeting["upcomingschedule"].isNotEmpty){
                  //     setState(() {
                  //       _daysLeft = tz.TZDateTime.parse(tz.getLocation(currentTimeZone), meeting["upcomingschedule"]["date"].toString()).difference(tz.TZDateTime.parse(tz.getLocation(currentTimeZone), DateFormat("yyyy-MM-dd").format(tz.TZDateTime.now(tz.getLocation(currentTimeZone))).toString())).inDays.toString();
                  //     });
                  //   }
                  //   timer = Timer.periodic(Duration(seconds: 1), (Timer t){
                  //     _reminders(hasMeeting: meeting["upcomingschedule"].isNotEmpty ? true : false, daysLeft: _daysLeft, secondTime: Parameters.hour2nd, thirdTime: Parameters.hour3rd);
                  //   });
                  // });
                });
              }),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
