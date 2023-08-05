import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/stream_services/screens/home.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class Menstruation extends StatefulWidget {
  final String rule,quantity;
  Menstruation({this.rule = "", this.quantity = ""});
  @override
  _MenstruationState createState() => _MenstruationState();
}

class _MenstruationState extends State<Menstruation> {
  List<String> _rules = ["Faible","Moyen","Abondant"];
  List<String> _quality = ["Blanc d’oeuf","Fluide","Crémeuse","Collante","Séche"];
  final Materialbutton _materialbutton = new Materialbutton();
  final HomeServices _homeServices = new HomeServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final AppBars _appBars = AppBars();
  String _selectedRule = "Faible";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(homeTracking.menstruation != ""){
      _selectedRule = homeStreamServices.currentTrack["menstruation"].toString();
    }
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
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Suivi de Cycle".toUpperCase(),style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
              SizedBox(
                height: 30,
              ),
              Text("Flux des règles".toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
              SizedBox(
                height: 10,
              ),
              for (int i = 0; i < _rules.length; i++)...{
                Row(
                  children: [
                    IconButton(
                      icon: _selectedRule.toLowerCase() == _rules[i].toLowerCase() ? Icon(Icons.radio_button_checked,size: 30,color: AppColors.appmaincolor,) : Icon(Icons.radio_button_off),
                      onPressed: (){
                        setState(() {
                          _selectedRule = _rules[i];
                        });
                      },
                    ),
                    Text(_rules[i].toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
                  ],
                )
              },
              SizedBox(
                height: 30,
              ),
              Text("QUALITÉ DE LA GLAIRE CERVICALE",style: TextStyle(fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
              SizedBox(
                height: 10,
              ),
              for (int i = 0; i < _quality.length; i++)...{
                Row(
                  children: [
                    IconButton(
                      icon: _selectedRule.toLowerCase() == _quality[i].toLowerCase() ? Icon(Icons.radio_button_checked,size: 30,color: AppColors.appmaincolor,) : Icon(Icons.radio_button_off),
                      onPressed: (){
                        setState(() {
                          _selectedRule = _quality[i];
                        });
                      },
                    ),
                    Text(_quality[i].toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
                  ],
                )
              },
              Spacer(),
              _materialbutton.materialButton("VALIDER", () {
                print(jsonDecode('{"opt1":"${_selectedRule}", "opt2":""}'));
                setState(() {
                  homeTracking.menstruation = _selectedRule;
                });
                _screenLoaders.functionLoader(context);
                _homeServices.submit_tracking(context).then((value){
                  if(value != null){
                    _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.parse(homeTracking.date))).then((value){
                      Navigator.of(context).pop(null);
                      Navigator.of(context).pop(null);
                    });
                  }
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