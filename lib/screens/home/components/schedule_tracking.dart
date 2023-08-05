import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../services/stream_services/subscriptions/subscription_details.dart';

class ScheduleTracking extends StatefulWidget {
  final DateTime currentDate;
  ScheduleTracking({required this.currentDate});
  @override
  _ScheduleTrackingState createState() => _ScheduleTrackingState();
}

class _ScheduleTrackingState extends State<ScheduleTracking> {
  final CheckinServices _checkinServices = new CheckinServices();
  final HomeServices _homeServices = new HomeServices();
  int? selected;
  DatePickerController _datePickerController = DatePickerController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeTracking.date = DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now()).toString();
    HomeTracking.currentDate = DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now()).toString();
    _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now()));
    _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now()));
    homeTracking.stress = 0;
    homeTracking.sleep = 0;
    homeTracking.smoke = 0;
    homeTracking.coffee = 0;
    homeTracking.water = 0;
    homeTracking.alcohol = 0;
    homeTracking.medication = "null";
    homeTracking.supplements = "null";
    homeTracking.menstruation = "null";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateTime.now().month == widget.currentDate.month && DateTime.now().year == widget.currentDate.year ?
        Container() :
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(DateFormat.yMMMM("fr_FR").format(widget.currentDate.toUtc().add(Duration(hours: 2))).toString().toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",fontWeight: FontWeight.w600,color: AppColors.pinkColor),),
        ),
        SizedBox(
          height: 15,
        ),
        HorizontalDatePickerWidget(
          locale: 'fr_FR',
          startDate: DateTime(2020,01,01),
          endDate:  DateTime(2100,01,01),
          selectedDate: DateTime.now(),
          widgetWidth: MediaQuery.of(context).size.width,
          datePickerController: _datePickerController,
          weekDayFontSize: 14,
          monthFontSize: 14,
          dayFontSize: 22,
          selectedColor: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.grey : AppColors.appmaincolor,
          disabledTextColor: Colors.grey,
          normalTextColor: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.grey : Colors.black,
          onValueSelected: (date) async{
            if(subscriptionDetails.currentdata[0]["macro_status"] == true){
              setState(() {
                homeTracking.date = DateFormat("yyyy-MM-dd","fr_FR").format(date).toString();
                HomeTracking.currentDate = DateFormat("yyyy-MM-dd","fr_FR").format(date).toString();
                _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(date));
                _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(date));
              });
            }
          },
        ),
        SizedBox(
          height: 15,
        ),
        // Container(
        //   width: double.infinity,
        //   margin: EdgeInsets.symmetric(horizontal: DeviceModel.isMobile ? 15 : 0),
        //   height: DeviceModel.isMobile ? 120 : 160,
        //   child: Center(
        //     child: ListWheelScrollView(
        //       physics: subscriptionDetails.currentdata[0]["macro_status"] == false  ? NeverScrollableScrollPhysics() : null,
        //       onSelectedItemChanged: (x) {
        //         setState(() {
        //           selected = x;
        //           homeTracking.date = DateFormat("yyyy-MM-dd","fr_FR").format(DateTime(widget.currentDate.year, widget.currentDate.month,x + 1)).toString();
        //           HomeTracking.currentDate = DateFormat("yyyy-MM-dd","fr_FR").format(DateTime(widget.currentDate.year, widget.currentDate.month,x + 1)).toString();
        //           _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime(widget.currentDate.year, widget.currentDate.month,x + 1)));
        //           _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime(widget.currentDate.year, widget.currentDate.month,x + 1)));
        //           homeTracking.stress = 0;
        //           homeTracking.sleep = 0;
        //           homeTracking.smoke = 0;
        //           homeTracking.coffee = 0;
        //           homeTracking.water = 0;
        //           homeTracking.alcohol = 0;
        //           homeTracking.medication = "null";
        //           homeTracking.supplements = "null";
        //           homeTracking.menstruation = "null";
        //         });
        //       },
        //       controller: _scrollController,
        //       children: List.generate(
        //           widget.currentDate.day,
        //               (x) => RotatedBox(
        //             quarterTurns: 1,
        //             child: AnimatedContainer(
        //                 duration: Duration(milliseconds: 400),
        //                 height: 80 ,
        //                 alignment: Alignment.center,
        //                 decoration: BoxDecoration(
        //                     color: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.grey : x == selected ? AppColors.appmaincolor : Colors.transparent,
        //                     borderRadius: BorderRadius.circular(10)
        //                 ),
        //                 child:Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: [
        //                     Text("${DateFormat('EEE',"fr_FR").format(DateTime(widget.currentDate.year, widget.currentDate.month,x + 1))[0].toUpperCase()}${DateFormat('EEE',"fr_FR").format(DateTime(widget.currentDate.year, widget.currentDate.month,x + 1)).substring(1).toLowerCase()}",style: TextStyle(color: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.white : x == selected ? Colors.white : Colors.black,fontFamily: "AppFontStyle"),),
        //                     Text('${x + 1}',style: TextStyle(fontSize: 32,color: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.white : x == selected ? Colors.white : Colors.black,fontWeight:FontWeight.bold,fontFamily: "AppFontStyle"),),
        //                   ],
        //                 )),
        //           )),
        //       itemExtent: 55,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
