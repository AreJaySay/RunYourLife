import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:clickable_list_wheel_view/measure_size.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../services/stream_services/subscriptions/subscription_details.dart';

class ScheduleTracking extends StatefulWidget {
  @override
  _ScheduleTrackingState createState() => _ScheduleTrackingState();
}

class _ScheduleTrackingState extends State<ScheduleTracking> {
  final CheckinServices _checkinServices = new CheckinServices();
  final HomeServices _homeServices = new HomeServices();
  DateTime currentDate = DateTime.now();
  int? selected;
  FixedExtentScrollController? _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    selected = currentDate.day;
    _scrollController = FixedExtentScrollController(initialItem: currentDate.day);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: DeviceModel.isMobile ? 15 : 0),
      height: DeviceModel.isMobile ? 120 : 160,
      child: Center(
        child: RotatedBox(
            quarterTurns: -1,
            child: ClickableListWheelScrollView(
              scrollController: _scrollController!,
              itemHeight: 55,
              itemCount: currentDate.day,
              child: ListWheelScrollView(
                physics: subscriptionDetails.currentdata[0]["form_status"] == false ? NeverScrollableScrollPhysics() : null,
                onSelectedItemChanged: (x) {
                  setState(() {
                    // print(DateTime. now(). subtract(Duration(days: 30)));
                    selected = x;
                    homeTracking.date = DateFormat("yyyy-MM-dd","fr").format(DateTime(currentDate.year, currentDate.month,x + 1)).toString();
                    _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime(currentDate.year, currentDate.month,x + 1)));
                    _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime(currentDate.year, currentDate.month,x + 1)));
                  });
                },
                controller: _scrollController,
                children: List.generate(
                    currentDate.day,
                    (x) => RotatedBox(
                    quarterTurns: 1,
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          height: 80 ,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: x == selected ? subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey[200] : AppColors.appmaincolor : Colors.transparent,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${DateFormat('EEE',"fr").format(DateTime(currentDate.year, currentDate.month,x + 1))[0].toUpperCase()}${DateFormat('EEE',"fr").format(DateTime(currentDate.year, currentDate.month,x + 1)).substring(1).toLowerCase()}",style: TextStyle(color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : x == selected ? Colors.white : Colors.black,fontFamily: "AppFontStyle"),),
                              Text('${x + 1}',style: TextStyle(fontSize: 32,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : x == selected ? Colors.white : Colors.black,fontWeight:FontWeight.bold,fontFamily: "AppFontStyle"),),
                            ],
                          )),
                    )),
                itemExtent: 55,
              ),
            )),
      ),
    );
  }
}
