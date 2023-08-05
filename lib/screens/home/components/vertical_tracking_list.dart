import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/home/components/components/entertainments.dart';
import 'package:run_your_life/screens/home/components/components/menstruation.dart';
import 'package:run_your_life/screens/home/components/components/supplement.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/home.dart';
import 'package:run_your_life/services/stream_services/screens/parameters.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../models/screens/home/tracking.dart';
import '../../../models/subscription_models/step5_subs.dart';
import '../../../widgets/finish_questioner_popup.dart';
import 'components/alcohol.dart';
import 'components/medications.dart';

class VerticalTrackingList extends StatefulWidget {
  @override
  _VerticalTrackingListState createState() => _VerticalTrackingListState();
}

class _VerticalTrackingListState extends State<VerticalTrackingList> {
  final Routes _routes = new Routes();
  List<String>_trackingV = ["Médicaments","Compléments alimentaires","Entraînements","Suivi de cycle"];
  List<Widget> _iconsV = [Image(image: AssetImage("assets/icons/capsole.png"),width: 17,fit: BoxFit.cover,color: AppColors.appmaincolor),Image(image: AssetImage("assets/icons/coaching.png"),width: 20,fit: BoxFit.cover,color: AppColors.appmaincolor,),Image(image: AssetImage("assets/icons/running.png"),width: 22,fit: BoxFit.cover,color: AppColors.appmaincolor),Image(image: AssetImage("assets/icons/menstruation.png"),width: 20,fit: BoxFit.cover,color: AppColors.appmaincolor)];
  List<Widget> _iconsNoComplete = [Image(image: AssetImage("assets/icons/capsole.png"),width: 17,fit: BoxFit.cover,color: Colors.grey[400],),Image(image: AssetImage("assets/icons/coaching.png"),width: 20,fit: BoxFit.cover,color: Colors.grey[400],),Image(image: AssetImage("assets/icons/running.png"),width: 22,fit: BoxFit.cover,color: Colors.grey[400],),Image(image: AssetImage("assets/icons/menstruation.png"),width: 22,fit: BoxFit.cover,color: Colors.grey[400],)];
  List<Widget> _pages = [MedicationTracking(),SupplementTracking(),EntertainmentTracking(),Menstruation()];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: homeStreamServices.tracking,
      builder: (context, snapshot) {
        return Column(
          children: [
            if(parameterStreamServices.subject.hasValue && snapshot.hasData)...{
              if(parameterStreamServices.current.toString() != "{}")...{
                parameterStreamServices.current["tracking"]["medicine"].toString() == "null" || parameterStreamServices.current["tracking"]["medicine"].toString() == "0" ?
                _widget(snapshot: snapshot, index: 0, isActive: false) : _widget(snapshot: snapshot, index: 0, isActive: true),
                parameterStreamServices.current["tracking"]["food_supplement"].toString() == "null" || parameterStreamServices.current["tracking"]["food_supplement"].toString() == "0" ?
                _widget(snapshot: snapshot, index: 1, isActive: false) : _widget(snapshot: snapshot, index: 1, isActive: true),
                parameterStreamServices.current["tracking"]["training"].toString() == "null" || parameterStreamServices.current["tracking"]["training"].toString() == '"null"' || parameterStreamServices.current["tracking"]["training"].toString() == "0" ?
                _widget(snapshot: snapshot, index: 2, isActive: false) : _widget(snapshot: snapshot, index: 2, isActive: true),
                Auth.loggedUser!["gender"].toString().toLowerCase() == "male" ?
                Container() :
                parameterStreamServices.current["tracking"]["menstruation"].toString() == "null" || parameterStreamServices.current["tracking"]["menstruation"].toString() == "0" ?
                _widget(snapshot: snapshot, index: 3, isActive: false) : _widget(snapshot: snapshot, index: 3, isActive: true) 
              }else...{
                _widget(snapshot: snapshot, index: 0, isActive: false),
                _widget(snapshot: snapshot, index: 1, isActive: false),
                _widget(snapshot: snapshot, index: 2, isActive: false),
                Auth.loggedUser!["gender"].toString().toLowerCase() == "male" ?
                Container() :
                _widget(snapshot: snapshot, index: 3, isActive: false)
              }
            }else...{
              for(int x = 0; x < 3; x++)...{
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
                  child: Column(
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
                          Text(_trackingV[x],style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle",fontSize: 15),)
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text("--",style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),)
                    ],
                  ),
                )
              }
            }
          ],
        );
      }
    );
  }
  Widget _widget({required AsyncSnapshot snapshot,required int index, required bool isActive}){
    List _trainings = [];
    if(snapshot.data["training"].toString() != '"No training"'){
      if(snapshot.data["training"].toString() != "null" && snapshot.data["training"].toString() != '"null"' && snapshot.data["training"].toString() != "no"){
        for(int x = 0; x < json.decode(snapshot.data!["training"]).length; x++){
          if(json.decode(snapshot.data!["training"])[x]["duration"].toString() == "null" || json.decode(snapshot.data!["training"])[x]["duration"].toString() == '"null"'){
            _trainings.add(json.decode(snapshot.data!["training"])[x]["sport"]);
          }else{
            _trainings.add("${json.decode(snapshot.data!["training"])[x]["sport"]} ${json.decode(snapshot.data!["training"])[x]["duration"]+"min"} (Performance: ${json.decode(snapshot.data!["training"])[x]["performance"].toString() == "null" ? "0" : json.decode(snapshot.data!["training"])[x]["performance"]})");
          }
        }
      }
    }
    // if(snapshot.data!["training"].toString().contains('"null"')){
    //   _trainings.add(snapshot.data!["training"].toString());
    // }else{
    //   if(snapshot.data["training"].toString() != "null" && snapshot.data["training"].toString() != '"null"' && snapshot.data["training"].toString() != "no" && snapshot.data["training"].toString() != '"No training"'){
    //     for(int x = 0; x < json.decode(snapshot.data!["training"]).length; x++){
    //       if(json.decode(snapshot.data!["training"])[x]["duration"].toString() == "null" || json.decode(snapshot.data!["training"])[x]["duration"].toString() == '"null"'){
    //         _trainings.add(json.decode(snapshot.data!["training"])[x]["sport"]);
    //       }else{
    //         _trainings.add("${json.decode(snapshot.data!["training"])[x]["sport"]} ${json.decode(snapshot.data!["training"])[x]["duration"]+"min"} (Performance: ${json.decode(snapshot.data!["training"])[x]["performance"].toString() == "null" ? "0" : json.decode(snapshot.data!["training"])[x]["performance"]})");
    //       }
    //     }
    //   }
    // }

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
        child: !snapshot.hasData ?
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
                Text(_trackingV[index],style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle",fontSize: 15),)
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
                subscriptionDetails.currentdata[0]["macro_status"] == false ?
                _iconsNoComplete[index] :
                !isActive ?
                _iconsNoComplete[index] :
                _iconsV[index],
                SizedBox(
                  width: 10,
                ),
                subscriptionDetails.currentdata[0]["macro_status"] == false ?
                Text(_trackingV[index],style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle",fontSize: 15),) :
                !isActive ?
                Text(_trackingV[index],style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle",fontSize: 15),) :
                Text(_trackingV[index],style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle",fontSize: 15),)
              ],
            ),
            SizedBox(
              height: 5,
            ),
            !isActive ?
            Text("Inactif",style: TextStyle(color: Colors.grey ,fontFamily: "AppFontStyle"),) :
            snapshot.data!.isEmpty ?
            Text("--",style: TextStyle(color: Colors.grey ,fontFamily: "AppFontStyle"),) :
            index == 0 ?
            Text(snapshot.data!["medication"].toString() == "null" ? "--" : snapshot.data!["medication"].toString(),style: TextStyle(color: snapshot.data!["medication"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
            index == 1 ?
            Text(snapshot.data!["supplements"].toString() == "null" ? "--" : snapshot.data!["supplements"].toString(),style: TextStyle(color: snapshot.data!["supplements"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
            index == 2 ?
            Text(snapshot.data["training"].toString() == "null" ? "--" : snapshot.data["training"].contains('"No training"')  ? "Aucun entrainement" : _trainings.toString().replaceAll("[", "").replaceAll("]", ""),style: TextStyle(color: snapshot.data["training"] == "[]" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),) :
            Text(snapshot.data!["menstruation"].toString() == "null" ? "--" : snapshot.data!["menstruation"].toString(),style: TextStyle(color: snapshot.data!["menstruation"].toString() == "null" ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),)
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
            // if(index == 2){
              print(snapshot.data!["training"]);
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
            // }
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
