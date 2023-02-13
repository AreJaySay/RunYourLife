import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/main.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/blog/blog.dart';
import 'package:run_your_life/screens/checkin/pack_solo/checkin.dart';
import 'package:run_your_life/screens/feedback/pack_accompanied/feedback.dart';
import 'package:run_your_life/screens/feedback/pack_solo/feedback.dart';
import 'package:run_your_life/screens/home/pack_accompanied/home.dart';
import 'package:run_your_life/screens/home/pack_solo/home.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/objective.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:workmanager/workmanager.dart';
import '../models/screens/profile/parameters.dart';
import '../services/other_services/push_notifications.dart';
import '../services/stream_services/screens/notification_notify.dart';
import '../services/stream_services/subscriptions/subscription_details.dart';
import 'checkin/pack_accompanied/checkin.dart';
import 'coaching/coaching.dart';
import 'profile/profile.dart';

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
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  List<Widget> _notSubs = [Coaching(),Blog(),Profile()];
  List<Widget> _withSubs = subscriptionDetails.currentdata.toString() == "[]" ? [] : [subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloHome() : PackAccompaniedHome(),subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloCheckIn() : PackAccompaniedCheckIn(), subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloFeedback() : PackAccompaniedFeedBack(),Blog(),Profile()];
  Timer? timer;
  bool _isDismiss = false;
  bool _isDismiss2nd = false;

  Future _reminders()async{
    if(Parameters.hour2nd != ""){
      if(DateFormat("HH:mm","fr").format(DateTime.now()).toString() == Parameters.hour2nd.toString()){
        if(!_isDismiss){
          FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
          _showNotificationWithDefaultSound(flip,text: "N'oublie pas de faire ton journal de bord journalier");
          Workmanager().cancelByUniqueName("daily");
          setState(() {
            _isDismiss = true;
          });
        }
      }
    }
    if(Parameters.hour3rd != ""){
      if(DateFormat("HH:mm","fr").format(DateTime.now()).toString() == Parameters.hour3rd.toString()){
        if(!_isDismiss2nd){
          FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
          _showNotificationWithDefaultSound(flip, text: "${Parameters.hour3rd.toString().split(",")[1].toString()} jours avant mon rendez-vous avec mon coach");
          Workmanager().cancelByUniqueName("weekly");
          setState(() {
            _isDismiss2nd = true;
          });
        }
      }
    }
  }


  Future _showNotificationWithDefaultSound(flip,{required String text}) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        playSound: true,
        priority: Priority.high
    );
    var iOSPlatformChannelSpecifics = new DarwinNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android:  androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flip.show(0, 'RAPPEL!',
        text,
        platformChannelSpecifics, payload: 'Default_Sound'
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    landingServices.updateIndex(index: widget.index);
    _isDismiss = false;
    _controller = new PageController(initialPage: widget.index);
    _parameterServices.getSetting().then((value){
      if(value.toString() != "{}"){
        if(value["notifications"].toString() != "null"){
          Parameters.notify1st = value["notifications"][0]["value"].toString() == "null" ? "" : value["notifications"][0]["value"].toString();
          Parameters.notify2nd   = value["notifications"][1]["value"].toString() == "null" ? "" : value["notifications"][1]["value"].toString();
          Parameters.notify3rd = value["notifications"][2]["value"].toString() == "null" ? "" : value["notifications"][2]["value"].toString();
          Parameters.hour1st = value["notifications"][0]["hour"].toString();
          Parameters.hour2nd = value["notifications"][1]["hour"].toString();
          Parameters.hour3rd = value["notifications"][2]["hour"].toString();
        }
        _checkinServices.subsCheckInStatus().then((value){
          print("CHECKIN IF EXISTER ${value.toString()}");
          if(value == null){
            timer = Timer.periodic(Duration(seconds: 15), (Timer t) => _reminders());
            Workmanager().registerPeriodicTask(
              "daily",
              "dailyReminder",
              frequency: Duration(hours: int.parse(Parameters.hour2nd.split(":")[0].toString()), minutes: int.parse(Parameters.hour2nd.split(":")[1].toString())),
            );
            Workmanager().registerPeriodicTask(
              "weekly",
              "weeklyReminder",
              frequency: Duration(days: int.parse(Parameters.hour3rd.toString().split(",")[1].toString()) ,hours: int.parse(Parameters.hour3rd.split(":")[0].toString()), minutes: int.parse(Parameters.hour3rd.split(":")[1].toString())),
            );
          }
        });
      }
    });
    try{
      _pushNotifications.initialize(context);
      notificationNotifyStreamServices.update(data: false);
    }catch(e){
      print("PUSH ERROR ${e.toString()}");
    }
  }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   timer?.cancel();
  // }

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
                  icon: Icon(Icons.bolt,size: 30),label: "Coaching"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.article,size: 28),label: "Blog"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,size: 30),label: "Profil"),
            ] :
            [
            // WITH SUBSCRIPTION
            BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 28),label: "Tableau de bord"),
            BottomNavigationBarItem(
                icon: Icon(Icons.verified,size: 28),label: "Journal de bord"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star,size: 30),label: "Feedback"),
            BottomNavigationBarItem(
                icon: Icon(Icons.article,size: 28),label: "Blog"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,size: 30),label: "Profil"),
          ],
            onTap: onTap,
            currentIndex: snapshot.data!,
            selectedItemColor:  AppColors.appmaincolor,
            unselectedItemColor: Colors.grey,
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
