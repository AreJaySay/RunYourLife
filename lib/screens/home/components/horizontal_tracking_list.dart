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
import '../../../models/subscription_models/step5_subs.dart';
import '../../../services/stream_services/screens/parameters.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/finish_questioner_popup.dart';
import 'components/alcohol.dart';
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
  List<String>_trackingH = ["Stress","Sommeil","Tabac","Café","Eau","Alcool"];
  List<Icon> _iconsH = [Icon(Icons.warning,color: AppColors.appmaincolor,size: 22,),Icon(Icons.nightlight_round,color: AppColors.appmaincolor,size: 20,),Icon(Icons.smoking_rooms,color: AppColors.appmaincolor),Icon(Icons.free_breakfast,color: AppColors.appmaincolor),Icon(Icons.water_drop,color: AppColors.appmaincolor),Icon(Icons.wine_bar,color: AppColors.appmaincolor,)];
  List<Icon> _iconsNoComplete = [Icon(Icons.warning,color: Colors.grey[400],),Icon(Icons.nightlight_round,color: Colors.grey[400],size: 20),Icon(Icons.smoking_rooms,color: Colors.grey[400]),Icon(Icons.free_breakfast,color: Colors.grey[400]),Icon(Icons.water_drop,color: Colors.grey[400]),Icon(Icons.wine_bar,color: Colors.grey[400],size: 22,)];
  List<Widget> _pages = [StressTracking(),SleepTracking(),TabaccoTracking(),CoffeeTracking(),WaterTracking(),AlcoholTracking()];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: homeStreamServices.tracking,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  if(parameterStreamServices.subject.hasValue)...{
                    if(parameterStreamServices.current.toString() != "{}")...{
                      Expanded(
                        child: parameterStreamServices.current["tracking"]["stress"].toString() == "null" || parameterStreamServices.current["tracking"]["stress"].toString() == "0" ?
                        _widget(snapshot: snapshot, index: 0, isActive: false) : _widget(snapshot: snapshot, index: 0, isActive: true),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: parameterStreamServices.current["tracking"]["sleep"].toString() == "null" || parameterStreamServices.current["tracking"]["sleep"].toString() == "0" ?
                        _widget(snapshot: snapshot, index: 1, isActive: false) : _widget(snapshot: snapshot, index: 1, isActive: true),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: parameterStreamServices.current["tracking"]["tobacco"].toString() == "null" || parameterStreamServices.current["tracking"]["tobacco"].toString() == "0" ?
                        _widget(snapshot: snapshot, index: 2, isActive: false) : _widget(snapshot: snapshot, index: 2, isActive: true),
                      ),
                    }else...{
                      for(int x = 0; x < 3; x++)...{
                        Expanded(
                          child: _widget(snapshot: snapshot, index: x, isActive: false),
                        ),
                        SizedBox(
                          width: x == 2 ? 0 : 10,
                        ),
                      }
                    }
                  }else...{
                    for(int x = 0; x < 3; x++)...{
                      Expanded(
                        child: _widget(snapshot: snapshot, index: x, isActive: false),
                      ),
                      SizedBox(
                        width:  x == 2 ? 0 : 10,
                      ),
                    }
                  }
                ],
              ),
              SizedBox(
                height: !parameterStreamServices.subject.hasValue ? 15 : parameterStreamServices.current.toString() == "{}" ? 15 : parameterStreamServices.current["tracking"]["stress"].toString() == "null" && parameterStreamServices.current["tracking"]["sleep"].toString() == "null" && parameterStreamServices.current["tracking"]["tobacco"].toString() == "null" ? 0 : 15,
              ),
              Row(
                children: [
                  if(parameterStreamServices.subject.hasValue)...{
                    if(parameterStreamServices.current.toString() != "{}")...{
                      Expanded(
                        child: parameterStreamServices.current["tracking"]["coffee"].toString() == "null" || parameterStreamServices.current["tracking"]["coffee"].toString() == "0" ?
                        _widget(snapshot: snapshot, index: 3, isActive: false) : _widget(snapshot: snapshot, index: 3, isActive: true),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: parameterStreamServices.current["tracking"]["water"].toString() == "null" || parameterStreamServices.current["tracking"]["water"].toString() == "0" ?
                        _widget(snapshot: snapshot, index: 4, isActive: false) : _widget(snapshot: snapshot, index: 4, isActive: true),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: parameterStreamServices.current["tracking"]["alcohol"].toString() == "null" || parameterStreamServices.current["tracking"]["alcohol"].toString() == "0" ?
                        _widget(snapshot: snapshot, index: 5, isActive: false) : _widget(snapshot: snapshot, index: 5, isActive: true),
                      ),
                    }else...{
                      for(int x = 3; x < 6; x++)...{
                        Expanded(
                          child: _widget(snapshot: snapshot, index: x, isActive: false),
                        ),
                        SizedBox(
                          width: x == 5 ? 0 : 10,
                        ),
                      }
                    }
                  }else...{
                    for(int x = 0; x < 3; x++)...{
                      Expanded(
                        child: _widget(snapshot: snapshot, index: x, isActive: false),
                      ),
                      SizedBox(
                        width:  x == 2 ? 0 : 10,
                      ),
                    }
                  }
                ],
              ),
            ],
          ),
        );
      }
    );
  }
  Widget _widget({required AsyncSnapshot snapshot,required int index, required bool isActive}){
    return ZoomTapAnimation(
      end: 0.99,child:
       Container(
         padding: EdgeInsets.symmetric(vertical: 13),
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
      child: !snapshot.hasData ?
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
                width: 3,
              ),
              Text(_trackingH[index],style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle",fontSize: 15),)
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
              subscriptionDetails.currentdata[0]["macro_status"] == false ?
              _iconsNoComplete[index] :
              !isActive ?
              _iconsNoComplete[index] :
              _iconsH[index],
              SizedBox(
                width: !isActive ? 0 : 3,
              ),
              subscriptionDetails.currentdata[0]["macro_status"] == false ?
              Text(_trackingH[index],style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle",fontSize: 15),) :
              !isActive ?
              Text(_trackingH[index],style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle",fontSize: 15),) :
              Text(_trackingH[index],style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle",fontSize: 15),)
            ],
          ),
          SizedBox(
            height: index == 1 ? 9 : 7,
          ),
          !isActive ?
          Text("Inactif",style: TextStyle(color: Colors.grey ,fontFamily: "AppFontStyle"),) :
          snapshot.data!.isEmpty ?
          Text("--",style: TextStyle(color: Colors.grey ,fontFamily: "AppFontStyle"),) :
          index == 0 ?
          Text(snapshot.data!["stress"].toString() == "null" ? "--" : snapshot.data!["stress"].toString() == "0.0" ? "--" : double.parse(snapshot.data!["stress"].toString()).floor().toString()+"/10",style: TextStyle(color: snapshot.data!["stress"].toString() == "null" || snapshot.data!["stress"].toString() == "0.0" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
          index == 1 ?
          Text(snapshot.data!["sleep"].toString() == "null" ? "--" : snapshot.data!["sleep"].toString() == "0.0" ? "--" : double.parse(snapshot.data!["sleep"].toString()).floor().toString()+"H",style: TextStyle(color: snapshot.data!["sleep"].toString() == "null" || snapshot.data!["sleep"].toString() == "0.0" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
          index == 2 ?
          Text(snapshot.data!["smoke"].toString() == "null" ? "--" : snapshot.data!["smoke"].toString() == "0.0" ? "--" : double.parse(snapshot.data!["smoke"].toString()).floor().toString()+" cigarett..",style: TextStyle(color: snapshot.data!["smoke"].toString() == "null" || snapshot.data!["smoke"].toString() == "0.0" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
          index == 3 ?
          Text(snapshot.data!["coffee"].toString() == "null" ? "--" : snapshot.data!["coffee"].toString() == "0.0" ? "--" : double.parse(snapshot.data!["coffee"].toString()).floor().toString()+" tasses: ${double.parse(snapshot.data!["coffee"].toString()).floor()*10} cl",style: TextStyle(color: snapshot.data!["coffee"].toString() == "null" || snapshot.data!["coffee"].toString() == "0.0" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,) :
          index == 4 ?
          Text(snapshot.data!["water"].toString() == "null" ? "--" : snapshot.data!["water"].toString() == "0.0" ? "--" : double.parse(snapshot.data!["water"].toString()).floor().toString()+" verres: ${double.parse(snapshot.data!["water"].toString()).floor()*25} cl",style: TextStyle(color: snapshot.data!["water"].toString() == "null" || snapshot.data!["water"].toString() == "0.0" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,) :
          Text(snapshot.data!["alcohol"].toString() == "null" ? "--" : snapshot.data!["alcohol"].toString() == "0.0" ? "--" : snapshot.data!["alcohol"].toString(),style: TextStyle(color: snapshot.data!["alcohol"].toString() == "null" || snapshot.data!["alcohol"].toString() == "0.0" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,)
        ],
      ),
    ),
      onTap: ()async{
        if(subscriptionDetails.currentdata[0]["macro_status"] == false){
          await showModalBottomSheet(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
            isScrollControlled: true,
            context: context, builder: (context){
            return FinishQuestionerPopup();
        });
        }else{
          if(isActive){
            // _screenLoaders.functionLoader(context);
            // _homeServices.getTracking(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.parse(homeTracking.date))).then((value){
            //   if(value != null){
            //     homeTracking.stress = snapshot.data!["stress"].toString() == "null" ? 0 : double.parse(snapshot.data!["stress"].toString());
            //     homeTracking.sleep = snapshot.data!["sleep"].toString() == "null" ? 0 : double.parse(snapshot.data!["sleep"].toString());
            //     homeTracking.smoke = snapshot.data!["smoke"].toString() == "null" ? 0 : double.parse(snapshot.data!["smoke"].toString());
            //     homeTracking.water = snapshot.data!["water"].toString() == "null" ? 0 : double.parse(snapshot.data!["water"].toString());
            //     homeTracking.coffee = snapshot.data!["coffee"].toString() == "null" ? 0 : double.parse(snapshot.data!["coffee"].toString());
            //     homeTracking.alcohol = snapshot.data!["alcohol"].toString() == "null" ? 0 : double.parse(snapshot.data!["alcohol"].toString());
            //   }
            //   Navigator.of(context).pop(null);
            //   _routes.navigator_push(context, _pages[index]);
            // });
            if(snapshot.data!["training"] != null && snapshot.data!["training"] != '"null"' && snapshot.data!["training"].toString() != '"No training"'){
              setState((){
                step5subs.sports.clear();
                step5subs.duration.clear();
                step5subs.performances.clear();
                for(int x = 0; x < json.decode(snapshot.data!["training"]).length; x++){
                  if(json.decode(snapshot.data!["training"])[x]["sport"] != null && json.decode(snapshot.data!["training"])[x]["duration"] != null && json.decode(snapshot.data!["training"])[x]["performance"] != null){
                    step5subs.performances.add(double.parse(json.decode(snapshot.data!["training"])[x]["performance"].toString()));
                    step5subs.sports.add(TextEditingController()..text=json.decode(snapshot.data!["training"])[x]["sport"]);
                    step5subs.duration.add(TextEditingController()..text=json.decode(snapshot.data!["training"])[x]["duration"]);
                  }
                }
              });
            }else{
              step5subs.sports.clear();
              step5subs.duration.clear();
              step5subs.performances.clear();
            }
            homeTracking.stress = snapshot.data!["stress"].toString() == "null" ? 0 : double.parse(snapshot.data!["stress"].toString());
            homeTracking.sleep = snapshot.data!["sleep"].toString() == "null" ? 0 : double.parse(snapshot.data!["sleep"].toString());
            homeTracking.smoke = snapshot.data!["smoke"].toString() == "null" ? 0 : double.parse(snapshot.data!["smoke"].toString());
            homeTracking.water = snapshot.data!["water"].toString() == "null" ? 0 : double.parse(snapshot.data!["water"].toString());
            homeTracking.coffee = snapshot.data!["coffee"].toString() == "null" ? 0 : double.parse(snapshot.data!["coffee"].toString());
            homeTracking.alcohol = snapshot.data!["alcohol"].toString() == "null" ? 0 : double.parse(snapshot.data!["alcohol"].toString());
            homeTracking.medication = snapshot.data!["medication"].toString() == "null" ? "" : snapshot.data!["medication"].toString();
            homeTracking.supplements = snapshot.data!["supplements"].toString() == "null" ? "" : snapshot.data!["supplements"].toString();
            homeTracking.menstruation = snapshot.data!["menstruation"].toString() == "null" ? "" : snapshot.data!["menstruation"].toString();
            _routes.navigator_push(context, _pages[index]);
          }
        }
      },
    );
  }
}
