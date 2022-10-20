import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/checkin/tracking.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'components/slider_widgets.dart';
import 'package:intl/intl.dart';

class MyTracking extends StatefulWidget {
  @override
  _MyTrackingState createState() => _MyTrackingState();
}

class _MyTrackingState extends State<MyTracking> with TickerProviderStateMixin {
  final CheckinServices _checkinServices = new CheckinServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final AppBars _appBars = new AppBars();
  final Materialbutton _materialbutton = new Materialbutton();
  int itemCount = 31;
  int selected = DateTime.now().day;
  FixedExtentScrollController _scrollController =
  FixedExtentScrollController(initialItem: DateTime.now().day);
  DateTime _selectedDate = DateTime.now();
  bool _isGrams = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.whiteappbar(context, title: "MES MACROS"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          children: [
            SizedBox(
              height: 10,
            ),
            Text("DATE",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 10,
            ),
            Text(DateFormat('MMMM',"fr").format(_selectedDate).toUpperCase(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle",color: AppColors.appmaincolor),),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: DeviceModel.isMobile ? 110 : 160,
              child: Center(
                child: RotatedBox(
                    quarterTurns: -1,
                    child: ClickableListWheelScrollView(
                      scrollController: _scrollController,
                      itemHeight: 55,
                      itemCount: DateTime.now().day,
                      child: ListWheelScrollView(
                        onSelectedItemChanged: (x) {
                          setState(() {
                            selected = x;
                            tracking.date = DateFormat("yyyy-MM-dd","fr").format(DateTime(DateTime.now().year, DateTime.now().month,x + 1)).toString();
                            _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime(DateTime.now().year, DateTime.now().month,x + 1))).then((value){
                              print("ASDASDAD"+value.toString());
                              if(value["clientTracking"].toString() != "null"){
                                setState(() {
                                  Tracking.gramslider[0] = double.parse(value["clientTracking"]["protein"]);
                                  Tracking.gramslider[1] = double.parse(value["clientTracking"]["lipid"]);
                                  Tracking.gramslider[2] = double.parse(value["clientTracking"]["carbohydrate"]);
                                  Tracking.gramslider[3] = double.parse(value["clientTracking"]["vegetable"]);
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
                        controller: _scrollController,
                        children: List.generate(
                            DateTime.now().day,
                                (x) => RotatedBox(
                              quarterTurns: 1,
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  height: 80 ,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: x == selected ? AppColors.appmaincolor : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("${DateFormat('EEE',"fr").format(DateTime(DateTime.now().year, DateTime.now().month,x + 1))[0].toUpperCase()}${DateFormat('EEE',"fr").format(DateTime(DateTime.now().year, DateTime.now().month,x + 1)).substring(1).toLowerCase()}",style: TextStyle(color: x == selected ? Colors.white : Colors.black,fontFamily: "AppFontStyle"),),
                                      Text('${x + 1}',style: TextStyle(fontSize: 32,color: x == selected ? Colors.white : Colors.black,fontWeight:FontWeight.bold,fontFamily: "AppFontStyle"),),
                                    ],
                                  )),
                            )),
                        itemExtent: 55,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? "EN GRAMMES" : subscriptionDetails.currentdata[0]["coach_macros"][0]["type"] == "portions" ? "PORTIONS" : "EN GRAMMES",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: AppColors.pinkColor,fontFamily: "AppFontStyle")),
            SizedBox(
              height: 10,
            ),
            SlideWidgets(),
            SizedBox(
              height: 60,
            ),
            _materialbutton.materialButton("VALIDER", (){
              _screenLoaders.functionLoader(context);
              _checkinServices.submit_tracking(context).then((value){
                print("TRACKING ${value.toString()}");
                _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime.parse(_selectedDate.toString()))).whenComplete((){
                  if(value != null){
                    _checkinServices.getUpdated().whenComplete((){
                      Navigator.of(context).pop(null);
                      Navigator.of(context).pop(null);
                      _snackbarMessage.snackbarMessage(context, message: "Suivi de la date soumis avec succès");
                    });
                  }else{
                    Navigator.of(context).pop(null);
                    _snackbarMessage.snackbarMessage(context, message: value.toString());
                  }
                });
              });
            }),
            SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                height: 55,
                child: Center(
                  child: Text("ANNULER",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600),),
                ),
              ),
              onTap: (){
                Navigator.of(context).pop(null);
              },
            )
          ],
        ),
      )
    );
  }
}
