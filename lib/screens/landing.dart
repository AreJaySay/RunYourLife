import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/reminder_helper.dart';
import 'package:run_your_life/screens/blog/blog.dart';
import 'package:run_your_life/screens/checkin/pack_solo/checkin.dart';
import 'package:run_your_life/screens/feedback/pack_accompanied/feedback.dart';
import 'package:run_your_life/screens/feedback/pack_solo/feedback.dart';
import 'package:run_your_life/screens/home/pack_accompanied/home.dart';
import 'package:run_your_life/screens/home/pack_solo/home.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/apis_services/screens/objective.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import '../models/screens/profile/parameters.dart';
import '../services/other_services/push_notifications.dart';
import '../services/stream_services/screens/notification_notify.dart';
import '../services/stream_services/subscriptions/subscription_details.dart';
import 'checkin/pack_accompanied/checkin.dart';
import 'coaching/coaching.dart';
import 'profile/profile.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Landing extends StatefulWidget {
  final int index;
  Landing({this.index = 0});
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> with WidgetsBindingObserver{
  final ObjectiveServices _objectiveApi = ObjectiveServices();
  PageController _controller = new PageController();
  final CheckinServices _checkinServices = new CheckinServices();
  final ParameterServices _parameterServices = new ParameterServices();
  final PushNotifications _pushNotifications = new PushNotifications();
  final NotificationService _notificationService = NotificationService();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final HomeServices _homeServices = new HomeServices();
  List<Widget> _notSubs = [Coaching(),Blog(),Profile()];
  List<Widget> _withSubs = subscriptionDetails.currentdata.toString() == "[]" ? [] : [subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloHome() : PackAccompaniedHome(),subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloCheckIn() : PackAccompaniedCheckIn(), subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloFeedback() : PackAccompaniedFeedBack(),Blog(),Profile()];
  @override
  void initState() {
    super.initState();
    _homeServices.getSchedule().then((meeting){
      _parameterServices.getSetting().then((value){
        if(value != null){
          if(value["notifications"] != null){
            if(value["notifications"][1]["value"] != null){
              setState(() {
                Parameters.hour2nd = value["notifications"][1]["hour"];
                Parameters.notify2nd = value["notifications"][1]["value"];
              });
            }
            if(value["notifications"][2]["value"] != null){
              setState(() {
                Parameters.hour3rd = value["notifications"][2]["hour"];
                Parameters.notify3rd = value["notifications"][2]["value"];
              });
            }
          }
        }
      });
    });
    WidgetsBinding.instance.addObserver(this);
    landingServices.updateIndex(index: widget.index);
    _controller = new PageController(initialPage: widget.index);
    try{
      _pushNotifications.initialize(context);
      notificationNotifyStreamServices.update(data: false);
    }catch(e){
      print("PUSH ERROR ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: landingServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          body: !snapshot.hasData ? Container() : Auth.isNotSubs!? _notSubs[snapshot.data!] : _withSubs[snapshot.data!],
          bottomNavigationBar: !snapshot.hasData ? Container() :
          BottomNavigationBar(
            items: Auth.isNotSubs! ?
            [
              // NO SUBSCRIPTION
              BottomNavigationBarItem(
                  icon: Icon(Icons.bolt,size: DeviceModel.isMobile ? 30 : 40),label: "Coaching"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.article,size: DeviceModel.isMobile ? 30 : 40),label: "Blog"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,size: DeviceModel.isMobile ? 30 : 40),label: "Profil"),
            ] :
            [
            // WITH SUBSCRIPTION
            BottomNavigationBarItem(
                icon: Icon(Icons.home,size: DeviceModel.isMobile ? 30 : 40),label: "Tableau de bord"),
            BottomNavigationBarItem(
                icon: Icon(Icons.verified,size: DeviceModel.isMobile ? 30 : 40),label: "Journal de bord"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star,size: DeviceModel.isMobile ? 30 : 40),label: "Feedback"),
            BottomNavigationBarItem(
                icon: Icon(Icons.article,size: DeviceModel.isMobile ? 30 : 40),label: "Blog"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,size: DeviceModel.isMobile ? 30 : 40),label: "Profil"),
          ],
            onTap: onTap,
            currentIndex: snapshot.data!,
            selectedItemColor:  AppColors.appmaincolor,
            unselectedItemColor: Colors.grey,
            selectedFontSize: DeviceModel.isMobile ? 13 : 16 ,
            unselectedFontSize: DeviceModel.isMobile ? 13 : 16,
          ),
        );
      }
    );
  }
  void onTap(int index) {
    setState(() {
      print(Parameters.hour2nd.split(":")[0]);
      landingServices.updateIndex(index: index);
    });
  }
}
