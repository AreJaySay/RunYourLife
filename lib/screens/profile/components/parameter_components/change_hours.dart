import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/screens/profile/parameters.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';

class ParametersChangeHour extends StatefulWidget {
  @override
  _ParametersChangeHourState createState() => _ParametersChangeHourState();
}

class _ParametersChangeHourState extends State<ParametersChangeHour> {
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ParameterServices _parameterServices = new ParameterServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Materialbutton _materialbutton = new Materialbutton();
  final AppBars _appBars = new AppBars();
  int _hoursselected = 1;
  int? _minutesselected = 0;
  FixedExtentScrollController _hoursController =
  FixedExtentScrollController(initialItem: 1);
  FixedExtentScrollController _minutesController =
  FixedExtentScrollController(initialItem: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
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
                  parameters.notifhour = "${_hour}:${_min}";
                });
                _screenLoaders.functionLoader(context);
                _parameterServices.submit(context).then((value){
                  if(value != null){
                    _parameterServices.getSetting().whenComplete((){
                      Navigator.of(context).pop(null);
                      Navigator.of(context).pop(null);
                    });
                  }else{
                    Navigator.of(context).pop(null);
                    _snackbarMessage.snackbarMessage(context, message: "Une erreur s'est produite. Veuillez réessayer !", is_error: true);
                  }
                });
              }),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pop(null);
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  child: Text("ANNULER",style: TextStyle(color: AppColors.pinkColor,fontSize: 17.5,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),textAlign: TextAlign.center,),
                )
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
