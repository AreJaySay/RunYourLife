import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/screens/home/tracking.dart';
import 'package:run_your_life/screens/home/components/components/coffee.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/home.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

import '../../../services/stream_services/screens/parameters.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import 'components/sleep.dart';
import 'components/stress.dart';
import 'components/tabacco.dart';
import 'components/water.dart';

class HorizontalTrackingList extends StatefulWidget {
  @override
  _HorizontalTrackingListState createState() => _HorizontalTrackingListState();
}

class _HorizontalTrackingListState extends State<HorizontalTrackingList> {
  final Routes _routes = new Routes();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final HomeServices _homeServices = new HomeServices();
  List<String>_trackingH = ["Stress","Sommeil","Tabac","Café","Eau"];
  List<Icon> _iconsH = [Icon(Icons.warning,color: AppColors.appmaincolor,),Icon(Icons.nightlight_round,color: AppColors.appmaincolor),Icon(Icons.smoking_rooms,color: AppColors.appmaincolor),Icon(Icons.free_breakfast,color: AppColors.appmaincolor),Icon(Icons.water_drop,color: AppColors.appmaincolor)];
  List<Icon> _iconsNoComplete = [Icon(Icons.warning,color: Colors.grey[400],),Icon(Icons.nightlight_round,color: Colors.grey[400]),Icon(Icons.smoking_rooms,color: Colors.grey[400]),Icon(Icons.free_breakfast,color: Colors.grey[400]),Icon(Icons.water_drop,color: Colors.grey[400])];
  List<Widget> _pages = [StressTracking(),SleepTracking(),TabaccoTracking(),CoffeeTracking(),WaterTracking()];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: homeStreamServices.tracking,
      builder: (context, snapshot) {
        return Container(
          width: double.infinity,
          height: 80,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            scrollDirection: Axis.horizontal,
            children: [
              if(!snapshot.hasData || !parameterStreamServices.subject.hasValue)...{
                for(int x = 0; x < 3; x++)...{
                  Container(
                    width: 110,
                      margin: EdgeInsets.only(right: x == 3 ? 0 : 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5.0, // has the effect of softening the shadow
                            spreadRadius: 0.0, // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              1.0, // vertical, move down 10
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _iconsNoComplete[x],
                            SizedBox(
                              width: 5,
                            ),
                            Text(_trackingH[x],style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),)
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text("--",style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),)
                      ],
                    )
                  ),
                }
              }else if(parameterStreamServices.current.toString() == "{}")...{
                for(var x = 0; x < _trackingH.length; x++)...{
                  x == 2 ?
                  _widget(snapshot: snapshot, index: x) :
                  x == 3 ?
                  _widget(snapshot: snapshot, index: x) :
                  x == 4 ?
                  _widget(snapshot: snapshot, index: x) :
                  _widget(snapshot: snapshot, index: x),
                }
              }else...{
                for(var x = 0; x < _trackingH.length; x++)...{
                  x == 2 ?
                  parameterStreamServices.current["tracking"]["tobacco"] == "Non" ?
                  Container() :
                  _widget(snapshot: snapshot, index: x) :
                  x == 3 ?
                  parameterStreamServices.current["tracking"]["coffee"] == "Non" ?
                  Container() :
                  _widget(snapshot: snapshot, index: x) :
                  x == 4 ?
                  parameterStreamServices.current["tracking"]["water"] == "Non" ?
                  Container() :
                  _widget(snapshot: snapshot, index: x) :
                  _widget(snapshot: snapshot, index: x),
                }
              }
            ],
          ),
        );
      }
    );
  }
  Widget _widget({required AsyncSnapshot snapshot,required int index}){
    return ZoomTapAnimation(
      end: 0.99,child:
    Container(
      width: 120,
      margin: EdgeInsets.only(right: index == 4 ? 0 : 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5.0, // has the effect of softening the shadow
              spreadRadius: 0.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                1.0, // vertical, move down 10
              ),
            )
          ],
          borderRadius: BorderRadius.circular(10)
      ),
      child: subscriptionDetails.currentdata[0]["form_status"] == false || !snapshot.hasData ?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _iconsNoComplete[index],
              SizedBox(
                width: 5,
              ),
              Text(_trackingH[index],style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),)
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Text("--",style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),)
        ],
      ) :
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _iconsH[index],
              SizedBox(
                width: 5,
              ),
              Text(_trackingH[index],style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),)
            ],
          ),
          SizedBox(
            height: 7,
          ),
          snapshot.data!.isEmpty ?
          Text("--",style: TextStyle(color: Colors.grey ,fontFamily: "AppFontStyle"),) :
          index == 0 ?
          Text(snapshot.data!["stress"].toString() == "null" ? "--" : snapshot.data!["stress"].toString() == "0.0" ? "Non" : double.parse(snapshot.data!["stress"].toString()).floor().toString()+"/10",style: TextStyle(color: snapshot.data!["stress"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
          index == 1 ?
          Text(snapshot.data!["sleep"].toString() == "null" ? "--" : snapshot.data!["sleep"].toString() == "0.0" ? "Non" : double.parse(snapshot.data!["sleep"].toString()).floor().toString()+"H",style: TextStyle(color: snapshot.data!["sleep"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
          index == 2 ?
          Text(snapshot.data!["smoke"].toString() == "null" ? "--" : snapshot.data!["smoke"].toString() == "0.0" ? "Non" : double.parse(snapshot.data!["smoke"].toString()).floor().toString()+" pièces",style: TextStyle(color: snapshot.data!["smoke"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
          index == 3 ?
          Text(snapshot.data!["coffee"].toString() == "null" ? "--" : snapshot.data!["coffee"].toString() == "0.0" ? "Non" : double.parse(snapshot.data!["coffee"].toString()).floor().toString()+" tasses: ${double.parse(snapshot.data!["coffee"].toString()).floor()*10} cl",style: TextStyle(color: snapshot.data!["coffee"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
          index == 4 ?
          Text(snapshot.data!["water"].toString() == "null" ? "--" : snapshot.data!["water"].toString() == "0.0" ? "Non" : double.parse(snapshot.data!["water"].toString()).floor().toString()+" verres: ${double.parse(snapshot.data!["water"].toString()).floor()*25} cl",style: TextStyle(color: snapshot.data!["water"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
          Container()
        ],
      ),
    ),
      onTap: (){
        if(subscriptionDetails.currentdata[0]["form_status"] != false){
          _screenLoaders.functionLoader(context);
          _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime.parse(homeTracking.date))).then((value){
            if(value != null){
              if(value["training"].toString() != "null"){
                for(int x = 0; x < json.decode(value["training"]).length; x++){
                  if(!homeTracking.sports.contains(json.decode(value["training"])[x]["sport"])){
                    homeTracking.sports.add(json.decode(value["training"])[x]["sport"]);
                    homeTracking.durations.add(json.decode(value["training"])[x]["duration"]);
                  }
                }
              }
            }
            Navigator.of(context).pop(null);
            _routes.navigator_push(context, _pages[index]);
          });
        }
      },
    );
  }
}
