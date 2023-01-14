import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/textfields.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../functions/loaders.dart';
import '../../../../models/screens/home/tracking.dart';
import '../../../../models/subscription_models/step5_subs.dart';
import '../../../../services/apis_services/screens/home.dart';
import '../../../../utils/snackbars/snackbar_message.dart';

class EntertainmentTracking extends StatefulWidget {
  @override
  _EntertainmentTrackingState createState() => _EntertainmentTrackingState();
}

class _EntertainmentTrackingState extends State<EntertainmentTracking> {
  final Materialbutton _materialbutton = new Materialbutton();
  final AppBars _appBars = AppBars();
  final HomeServices _homeServices = new HomeServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  int? _selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeTracking.trainingChecker = "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: _appBars.whiteappbar(context, title: "SUIVI DE LA JOURNÉE"),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
            children: [
              Text("Entraînements".toUpperCase(),style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
              SizedBox(
                height: 10,
              ),
              Text("Entre le sport effectué et sa durée en minutes",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
              SizedBox(
                height: 20,
              ),
              for(var x = 0; x < step5subs.sports.length; x++)...{
                SizedBox(
                  height: x == 0 ? 0 : 20,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFields(step5subs.sports[x],hintText: "Nom du sport",onChanged: (text){
                          setState(() {
                            homeTracking.trainingChecker = "no null";
                            _selected = 1;
                          });
                        },),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100,
                        child: TextFields(step5subs.duration[x],hintText: "Durée",),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Décris le type de sport que tu as effectué \nDonne l’effort que tu as perçu",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
                SizedBox(
                  height: 5,
                ),
                Text("0 : léger / 5 : modéré / 8 : Difficile / 10 : Très intense",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
                SizedBox(
                  height: 15,
                ),
                Text("EFFORT PERÇU",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,fontWeight: FontWeight.w600),),
                Container(
                  height: 70,
                  child: FlutterSlider(
                    values: [step5subs.performances[x]],
                    max: 10,
                    min: 0,
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
                        child: Text(step5subs.performances[x].floor().toString(),style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
                    ),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        step5subs.performances[x] = lowerValue;
                      });
                    },
                  ),
                ),
              },
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  height: 45,
                  width: double.infinity,
                  child: Center(
                      child: Icon(Icons.add,color: Colors.white,)
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.pinkColor,
                      borderRadius: BorderRadius.circular(1000)
                  ),
                ),
                onTap: (){
                  setState(() {
                    step5subs.sports.add(TextEditingController());
                    step5subs.duration.add(TextEditingController());
                    step5subs.performances.add(0);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              ZoomTapAnimation(
                end: 0.99,
                onTap: (){
                  setState(() {
                    _selected = 2;
                    step5subs.sports.clear();
                    step5subs.duration.clear();
                    homeTracking.trainingChecker = "null";
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 2,
                          groupValue: _selected,
                          onChanged: (val) {
                            setState(() {
                              _selected = 2;
                              step5subs.sports.clear();
                              step5subs.duration.clear();
                              homeTracking.trainingChecker = "null";
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Aucun entrainement",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              _materialbutton.materialButton("VALIDER", () {
                homeTracking.sports.remove("null");
                homeTracking.sports.remove("");
                homeTracking.durations.remove("null");
                homeTracking.durations.remove("");
                for(int x = 0;x < step5subs.sports.length; x++){
                  setState((){
                    if(!homeTracking.sports.contains(step5subs.sports[x].text.toString())){
                      homeTracking.sports.add(step5subs.sports[x].text.toString());
                      homeTracking.durations.add(step5subs.duration[x].text.toString());
                      homeTracking.performances.add(step5subs.performances[x].floor().toString());
                    }
                  });
                  print(homeTracking.sports.toString());
                }
                if(homeTracking.trainingChecker != ""){
                  _screenLoaders.functionLoader(context);
                  _homeServices.submit_tracking(context).then((value){
                    if(value != null){
                      _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime.parse(homeTracking.date))).then((value){
                        Navigator.of(context).pop(null);
                        Navigator.of(context).pop(null);
                      });
                    }
                  });
                }else{
                  _snackbarMessage.snackbarMessage(context, message: "Ajoutez des données pour continuer !",is_error: true);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
