import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/home/components/components/entertainments.dart';
import 'package:run_your_life/screens/home/components/components/supplement.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/home.dart';
import 'package:run_your_life/services/stream_services/screens/parameters.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../models/subscription_models/step5_subs.dart';
import 'components/alcohol.dart';
import 'components/medications.dart';

class VerticalTrackingList extends StatefulWidget {
  @override
  _VerticalTrackingListState createState() => _VerticalTrackingListState();
}

class _VerticalTrackingListState extends State<VerticalTrackingList> {
  final Routes _routes = new Routes();
  List<String>_trackingV = ["Alcool","Médicaments","Compléments alimentaires","Entrainements"];
  List<Widget> _iconsV = [Icon(Icons.wine_bar,color: AppColors.appmaincolor,),Image(image: AssetImage("assets/icons/capsole.png"),width: 17,fit: BoxFit.cover,color: AppColors.appmaincolor),Image(image: AssetImage("assets/icons/coaching.png"),width: 20,fit: BoxFit.cover,color: AppColors.appmaincolor,),Image(image: AssetImage("assets/icons/running.png"),width: 22,fit: BoxFit.cover,color: AppColors.appmaincolor)];
  List<Widget> _iconsNoComplete = [Icon(Icons.wine_bar,color: Colors.grey[400],size: 22,),Image(image: AssetImage("assets/icons/capsole.png"),width: 17,fit: BoxFit.cover,color: Colors.grey[400],),Image(image: AssetImage("assets/icons/coaching.png"),width: 20,fit: BoxFit.cover,color: Colors.grey[400],),Image(image: AssetImage("assets/icons/running.png"),width: 22,fit: BoxFit.cover,color: Colors.grey[400],)];
  List<Widget> _pages = [AlcoholTracking(),MedicationTracking(),SupplementTracking(),EntertainmentTracking()];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: homeStreamServices.tracking,
      builder: (context, snapshot) {
        return Column(
          children: [
            if(!snapshot.hasData)...{
              for(int x = 0;x < 4; x++)...{
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 15,),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 13),
                  width: double.infinity,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _iconsNoComplete[x],
                          SizedBox(
                            width: 10,
                          ),
                          Text(_trackingV[x],style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),)
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text("--",style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),)
                    ],
                  )
                )
              }
            }else...{
              if(parameterStreamServices.current.toString() == "{}")...{
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: NoDataFound(firstString: "C'EST ", secondString: "CALME PAR ICI...", thirdString: "Il n'y a encore rien à trouver ici !",),
                )
              }else if(parameterStreamServices.current["tracking"]["alcohol"] == "Non" && parameterStreamServices.current["tracking"]["food_supplement"] == "Non" && parameterStreamServices.current["tracking"]["medicine"] == "Non")...{
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: NoDataFound(firstString: "C'EST ", secondString: "CALME PAR ICI...", thirdString: "Il n'y a encore rien à trouver ici !",),
                )
              }else...{
                for(var x = 0; x < _trackingV.length; x++)...{
                  x == 0 ?
                  parameterStreamServices.current["tracking"]["alcohol"] == "Non" ?
                  Container() :
                  _widget(snapshot: snapshot, index: x) :
                  x == 1 ?
                  parameterStreamServices.current["tracking"]["medicine"] == "Non" ?
                  Container() :
                  _widget(snapshot: snapshot, index: x) :
                  x == 2 ?
                  parameterStreamServices.current["tracking"]["food_supplement"] == "Non" ?
                  Container() :
                  _widget(snapshot: snapshot, index: x) :
                  _widget(snapshot: snapshot, index: x),
                }
              }
            }
          ],
        );
      }
    );
  }
  Widget _widget({required AsyncSnapshot snapshot,required int index}){
    List _trainings = [];
    if(snapshot.data!["training"].toString().contains('"null"')){
      _trainings.add(snapshot.data!["training"].toString());
    }else{
      if(snapshot.data!["training"].toString() != "null" && snapshot.data!["training"].toString() != "no"){
        for(int x = 0; x < json.decode(snapshot.data!["training"]).length; x++){
          if(json.decode(snapshot.data!["training"])[x]["duration"].toString() == "null"){
            _trainings.add(json.decode(snapshot.data!["training"])[x]["sport"]);
          }else{
            _trainings.add(json.decode(snapshot.data!["training"])[x]["sport"]+" "+json.decode(snapshot.data!["training"])[x]["duration"]);
          }
        }
      }
    }

    return ZoomTapAnimation(
      end: 0.99,
      child: Container(
        margin: EdgeInsets.only(left: 20,right: 20,bottom: 15,),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 13),
        width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _iconsNoComplete[index],
                SizedBox(
                  width: 10,
                ),
                Text(_trackingV[index],style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),)
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _iconsV[index],
                SizedBox(
                  width: 10,
                ),
                Text(_trackingV[index],style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),)
              ],
            ),
            SizedBox(
              height: 5,
            ),
            snapshot.data!.isEmpty ?
            Text("--",style: TextStyle(color: Colors.grey ,fontFamily: "AppFontStyle"),) :
            index == 0 ?
            Text(snapshot.data!["alcohol"].toString() == "null" ? "--" : snapshot.data!["alcohol"].toString(),style: TextStyle(color: snapshot.data!["alcohol"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
            index == 1 ?
            Text(snapshot.data!["medication"].toString() == "null" ? "--" : snapshot.data!["medication"].toString(),style: TextStyle(color: snapshot.data!["medication"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
            index == 2 ?
            Text(snapshot.data!["supplements"].toString() == "null" ? "--" : snapshot.data!["supplements"].toString(),style: TextStyle(color: snapshot.data!["supplements"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
            Text(_trainings.toString() == "[]" ? "--" : _trainings.toString().contains('"null"') ? "Aucun entrainement" : _trainings.toString().replaceAll("[", "").replaceAll("]", ""),style: TextStyle(color:_trainings.toString() == "[]" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),)
          ],
        ),
      ),
      onTap: (){
        if(subscriptionDetails.currentdata[0]["form_status"] == false || !snapshot.hasData){
        }else{
          if(index == 3){
            step5subs.sports.clear();
            step5subs.duration.clear();
            if(snapshot.data!["training"].toString().contains("null") || snapshot.data!["training"].toString().contains("no")){
              print(snapshot.data!["training"].toString());
              setState(() {
                step5subs.sports.add(TextEditingController());
                step5subs.duration.add(TextEditingController());
              });
            }else{
              setState((){
                for(int x = 0; x < json.decode(snapshot.data!["training"]).length; x++){
                  print(snapshot.data!["training"].toString());
                  step5subs.sports.add(TextEditingController()..text=json.decode(snapshot.data!["training"])[x]["sport"]);
                  step5subs.duration.add(TextEditingController()..text=json.decode(snapshot.data!["training"])[x]["duration"]);
                }
              });
            }
          }
          _routes.navigator_push(context, _pages[index]);
        }
      },
    );
  }
}
