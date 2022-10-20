import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/blog/blog.dart';
import 'package:run_your_life/screens/checkin/pack_solo/checkin.dart';
import 'package:run_your_life/screens/feedback/pack_accompanied/feedback.dart';
import 'package:run_your_life/screens/feedback/pack_solo/feedback.dart';
import 'package:run_your_life/screens/home/pack_accompanied/home.dart';
import 'package:run_your_life/screens/home/pack_solo/home.dart';
import 'package:run_your_life/services/apis_services/screens/objective.dart';
import 'package:run_your_life/services/landing_page_services/objective_service.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
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
  final ObjectiveApi _objectiveApi = ObjectiveApi();
  PageController _controller = new PageController();
  final PushNotifications _pushNotifications = new PushNotifications();
  List<Widget> _notSubs = [Coaching(),Blog(),Profile()];
  List<Widget> _withSubs = subscriptionDetails.currentdata.toString() == "[]" ? [] : [ subscriptionDetails.currentdata[0]["plan_id"] == 1 ? PackSoloHome() : PackAccompaniedHome(),subscriptionDetails.currentdata[0]["plan_id"] == 1 ? PackSoloCheckIn() : PackAccompaniedCheckIn(), subscriptionDetails.currentdata[0]["plan_id"] == 1 ? PackSoloFeedback() : PackAccompaniedFeedBack(),Blog(),Profile()];

  @override
  void initState() {
    super.initState();
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
          // body: PageView(
          //   physics: NeverScrollableScrollPhysics(),
          //   children: Auth.isNotSubs!?
          //   [
          //     Coaching(),
          //     Blog(),
          //     Profile()
          //   ] :
          //   [
          //     subscriptionDetails.currentdata[0]["plan_id"] == 1 ? PackSoloHome() : PackAccompaniedHome(),
          //     subscriptionDetails.currentdata[0]["plan_id"] == 1 ? PackSoloCheckIn() : PackAccompaniedCheckIn(),
          //     subscriptionDetails.currentdata[0]["plan_id"] == 1 ? PackSoloFeedback() : PackAccompaniedFeedBack(),
          //     Blog(),
          //     Profile()
          //   ],
          //   controller: _controller,
          //   onPageChanged: (int index){
          //     setState(() {
          //       landingServices.updateIndex(index: index);
          //     });
          //   },
          // ),
          bottomNavigationBar:  !snapshot.hasData ? Container() :
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
                icon: Icon(Icons.home,size: 28),label: "Accueil"),
            BottomNavigationBarItem(
                icon: Icon(Icons.verified,size: 28),label: "Check-in"),
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
      landingServices.updateIndex(index: index);
    });
  }
}
