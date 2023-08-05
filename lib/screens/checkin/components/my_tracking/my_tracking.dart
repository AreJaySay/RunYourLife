import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/appbar.dart';
import '../../../../models/screens/checkin/tracking.dart';
import '../../../../models/screens/home/tracking.dart';
import 'components/slider_widgets.dart';
import 'package:intl/intl.dart';

class MyTracking extends StatefulWidget {
  final DateTime initialDate;
  MyTracking({required this.initialDate});
  @override
  _MyTrackingState createState() => _MyTrackingState();
}

class _MyTrackingState extends State<MyTracking> with TickerProviderStateMixin {
  final CheckinServices _checkinServices = new CheckinServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final HomeServices _homeServices = new HomeServices();
  final AppBars _appBars = new AppBars();
  DatePickerController _datePickerController = DatePickerController();
  final Materialbutton _materialbutton = new Materialbutton();
  int itemCount = 31;
  int? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tracking.date = DateFormat("yyyy-MM-dd","fr").format(widget.initialDate).toString();
    _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(widget.initialDate)).then((value){
      print("ASDASDAD"+value.toString());
      if(value["clientTracking"].toString() != "null"){
        setState(() {
          Tracking.gramslider[0] = double.parse(value["clientTracking"]["protein"].toString());
          Tracking.gramslider[1] = double.parse(value["clientTracking"]["lipid"].toString());
          Tracking.gramslider[2] = double.parse(value["clientTracking"]["carbohydrate"].toString());
          Tracking.gramslider[3] = double.parse(value["clientTracking"]["vegetable"].toString());
        });
      }else{
        setState(() {
          Tracking.gramslider[0] = 0;
          Tracking.gramslider[1] = 0;
          Tracking.gramslider[2] = 0;
          Tracking.gramslider[3] = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.whiteappbar(context, title: "MES MACROS"),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("DATE",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                ),
                SizedBox(
                  height: 20,
                ),
                HorizontalDatePickerWidget(
                  locale: 'fr_FR',
                  startDate: DateTime(2020,01,01),
                  endDate:  DateTime(2100,01,01),
                  selectedDate: widget.initialDate,
                  widgetWidth: MediaQuery.of(context).size.width,
                  datePickerController: _datePickerController,
                  weekDayFontSize: 14,
                  monthFontSize: 14,
                  dayFontSize: 22,
                  selectedColor: AppColors.appmaincolor,
                  onValueSelected: (date)async{
                    setState(() {
                      tracking.date = DateFormat("yyyy-MM-dd","fr").format(date).toString();
                      _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(date)).then((value){
                        print("ASDASDAD"+value.toString());
                        if(value["clientTracking"].toString() != "null"){
                          setState(() {
                            Tracking.gramslider[0] = double.parse(value["clientTracking"]["protein"].toString());
                            Tracking.gramslider[1] = double.parse(value["clientTracking"]["lipid"].toString());
                            Tracking.gramslider[2] = double.parse(value["clientTracking"]["carbohydrate"].toString());
                            Tracking.gramslider[3] = double.parse(value["clientTracking"]["vegetable"].toString());
                          });
                        }else{
                          setState(() {
                            Tracking.gramslider[0] = 0;
                            Tracking.gramslider[1] = 0;
                            Tracking.gramslider[2] = 0;
                            Tracking.gramslider[3] = 0;
                          });
                        }
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? "EN GRAMMES" : subscriptionDetails.currentdata[0]["coach_macros"][0]["type"] == "portions" ? "PORTIONS" : "EN GRAMMES",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: AppColors.pinkColor,fontFamily: "AppFontStyle")),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SlideWidgets(),
                ),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 110,
                color: Colors.white,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  margin: EdgeInsets.only(top: 20),
                  child: _materialbutton.materialButton("VALIDER", (){
                    _screenLoaders.functionLoader(context);
                    _checkinServices.submit_tracking(context).then((value){
                      _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(widget.initialDate)).whenComplete((){
                        if(value != null){
                          _checkinServices.getUpdated().whenComplete((){
                            homeTracking.date = DateFormat("yyyy-MM-dd","fr_FR").format(widget.initialDate).toString();
                            HomeTracking.currentDate = DateFormat("yyyy-MM-dd","fr_FR").format(widget.initialDate).toString();
                            _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(widget.initialDate));
                            _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(widget.initialDate));
                            Navigator.of(context).pop(null);
                            Navigator.of(context).pop(null);
                            _snackbarMessage.snackbarMessage(context, message: "Mise à jour effectuée");
                          });
                        }else{
                          Navigator.of(context).pop(null);
                          _snackbarMessage.snackbarMessage(context, message: value.toString());
                        }
                      });
                    });
                  }),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
