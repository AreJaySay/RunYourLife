import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/screens/checkin/components/my_objectives/my_objectives.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/my_photos.dart';
import 'package:run_your_life/screens/checkin/components/my_ressources/my_ressources.dart';
import 'package:run_your_life/screens/checkin/components/my_tracking/my_tracking.dart';
import 'package:run_your_life/screens/checkin/components/my_weight/my_weights.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/checkin.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/notification_notifier.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/finish_questioner_popup.dart';
import '../../../widgets/materialbutton.dart';
import '../../../widgets/message_notifier.dart';
import '../components/my_measurements/my_measurements.dart';
import 'package:intl/intl.dart';

class PackAccompaniedCheckIn extends StatefulWidget {
  @override
  _PackAccompaniedCheckInState createState() => _PackAccompaniedCheckInState();
}

class _PackAccompaniedCheckInState extends State<PackAccompaniedCheckIn> {
  final Materialbutton _materialbutton = new Materialbutton();
  final CheckinServices _checkinServices = new CheckinServices();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final HomeServices _homeServices = new HomeServices();
  final Routes _routes = new Routes();
  final AppBars _appBars = new AppBars();
  final List<Widget> _pages = [MyWeights(),MyMeasurements(),MyPhotos(),MyObjectives()];
  List _todos = ['MON POIDS',"MES MESURES","MES PHOTOS","MES OBJECTIFS DE LA SEMAINE"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkinServices.getUpdated();
    _checkinServices.subsCheckInStatus();
    _checkinServices.getPhotoTags(context);
    // _checkinServices.getUpdated().then((value){
    //   print("WEIGHT ${value["last_photos"].toString()}");
    //   if(value["last_weight"] == "" || value["last_weight"].toString() == "null"){
    //   }else{
    //     // if(DateTime.parse(DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now().toUtc().add(Duration(hours: 2))).toString()).difference(DateTime.parse(DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.parse(value["last_weight"]["updated_at"]).toUtc().add(Duration(hours: 2))))).inDays < 7){
    //       setState(() {
    //         CheckinServices.checkinSelected.add('MON POIDS');
    //       });
    //     // }
    //   }
    //   if(value["last_photos"].toString() != "null"){
    //     // if(DateTime.parse(DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now().toUtc().add(Duration(hours: 2))).toString()).difference(DateTime.parse(DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.parse(value["last_photos"]["updated_at"]).toUtc().add(Duration(hours: 2))))).inDays > 7){
    //       setState(() {
    //         CheckinServices.checkinSelected.add('MES PHOTOS');
    //       });
    //     // }
    //   }
    //   if(value["last_measure"].toString() != "null"){
    //     // if(DateTime.parse(DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now().toUtc().add(Duration(hours: 2))).toString()).difference(DateTime.parse(DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.parse(value["last_measure"]["updated_at"]).toUtc().add(Duration(hours: 2))))).inDays > 7){
    //       setState(() {
    //         CheckinServices.checkinSelected.add('MES MESURES');
    //       });
    //     // }
    //   }
    //   if(value["last_weight"].toString() != "null" && value["last_measure"].toString() != "null" && value["last_photos"].toString() != "null"){
    //     setState(() {
    //       CheckinServices.checkinSelected.add('MES OBJECTIFS DE LA SEMAINE');
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: checkInStreamServices.lastUpdated,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: _appBars.bluegradient(context,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("JOURNAL DE BORD",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,fontFamily: "AppFontStyle"),),
                    Spacer(),
                    NotificationNotifier(),
                    SizedBox(
                      width: 15,
                    ),
                    MessageNotifier()
                  ],
                ),
              )
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("MA",style: TextStyle(fontSize: 20,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                    Text(" TO DO LIST",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Afin de vous aider dans vos objectifs hebdomadaires, votre coach vous prépare cette todo list afin de faciliter votre échange.",style: TextStyle(fontSize: 13.5,fontFamily: "AppFontStyle"),),
                SizedBox(
                  height: 25,
                ),
                for(var x = 0 ; x < _todos.length;x++)...{
                  if(subscriptionDetails.currentdata[0]["macro_status"] == false)...{
                    Row(
                      children: [
                        Container(
                          child: Transform.scale(
                            scale: 1,
                            child: SizedBox(
                              width: 23,
                              height: 23,
                              child: Checkbox(
                                checkColor: AppColors.pinkColor,
                                activeColor: Colors.white,
                                value: false,
                                shape: CircleBorder(
                                    side: BorderSide.none
                                ),
                                splashRadius: 20,
                                side: BorderSide(
                                    width: 0,
                                    color: Colors.transparent,
                                    style: BorderStyle.none
                                ),
                                onChanged: (value) {
                                },
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.pinkColor,width: 2),
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          padding: EdgeInsets.all(3),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: ZoomTapAnimation(
                            end: 0.99,
                            onTap: ()async{
                              await showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                                  isScrollControlled: true,
                                  context: context, builder: (context){
                                return FinishQuestionerPopup();
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 65,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 4.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(
                                        0.0,
                                        1
                                    ),
                                  )
                                ],
                              ),
                              child: Text(_todos[x],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey,fontFamily: "AppFontStyle"),),
                            ),
                          ),
                        ),
                      ],
                    )
                  }else...{
                    GestureDetector(
                      onTap: (){
                        _routes.navigator_push(context, _pages[x],);
                      },
                      child: Row(
                        children: [
                          InkWell(
                            child: Container(
                              child: Transform.scale(
                                scale: 1,
                                child: SizedBox(
                                  width: 23,
                                  height: 23,
                                  child: Checkbox(
                                    checkColor: AppColors.pinkColor,
                                    activeColor: Colors.white,
                                    value: CheckinServices.checkinSelected.contains(_todos[x]),
                                    shape: CircleBorder(
                                        side: BorderSide.none
                                    ),
                                    splashRadius: 20,
                                    side: BorderSide(
                                        width: 0,
                                        color: Colors.transparent,
                                        style: BorderStyle.none
                                    ),
                                    onChanged: (value)async{
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      setState(() {
                                        if(CheckinServices.checkinSelected.contains(_todos[x])){
                                          CheckinServices.checkinSelected.remove(_todos[x]);
                                          prefs.remove(_todos[x]);
                                        }else{
                                          CheckinServices.checkinSelected.add(_todos[x]);
                                          prefs.setString(_todos[x], _todos[x]);
                                        }
                                      });
                                      if(x == 0){
                                        prefs.setString("poid_date", DateTime.now().toUtc().add(Duration(hours: 2)).next(DateTime.monday).toString());
                                      }else{
                                        prefs.setString("other_date", DateTime.now().toUtc().add(Duration(hours: 2)).toString());
                                      }
                                      prefs.setStringList("checkin", CheckinServices.checkinSelected.cast<String>());
                                    },
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.pinkColor,width: 2),
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              padding: EdgeInsets.all(3),
                            ),
                            onTap: ()async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              setState(() {
                                if(CheckinServices.checkinSelected.contains(_todos[x])){
                                  CheckinServices.checkinSelected.remove(_todos[x]);
                                  prefs.remove(_todos[x]);
                                }else{
                                  CheckinServices.checkinSelected.add(_todos[x]);
                                  prefs.setString(_todos[x], _todos[x]);
                                }
                              });
                              if(x == 0){
                                prefs.setString("poid_date", DateTime.now().toUtc().add(Duration(hours: 2)).next(DateTime.monday).toString());
                              }else{
                                prefs.setString("other_date", DateTime.now().toUtc().add(Duration(hours: 2)).toString());
                              }
                              prefs.setStringList("checkin", CheckinServices.checkinSelected.cast<String>());
                            },
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 65,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                gradient: CheckinServices.checkinSelected.contains(_todos[x]) ? LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: <Color>[AppColors.appmaincolor, Color.fromRGBO(87, 177, 200, 0.9)]) : null,
                                boxShadow: [
                                  if(!CheckinServices.checkinSelected.contains(_todos[x]))...{
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 4.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(
                                          0.0,
                                          1
                                      ),
                                    )
                                  }
                                ],
                              ),
                              child: Row(
                                children: [
                                  Text(_todos[x],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                                  Spacer(),
                                  x >= 4 ? Container() :
                                  !snapshot.hasData ?
                                  x == 3 ? Container() : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      _shimmeringLoader.pageLoader(radius: 5, width: 100, height: 15),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: _shimmeringLoader.pageLoader(radius: 5, width: 80, height: 15),
                                      )
                                    ],
                                  ) :
                                  x == 0 ?
                                  snapshot.data!["last_weight"].toString() == "" ?
                                  SizedBox() :
                                  snapshot.data!["last_weight"].toString() == "null" ?
                                  SizedBox() :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(DateFormat.yMMMd("fr_FR").format(DateTime.parse(DateTime.now().toUtc().add(Duration(hours: 2)).next(DateTime.monday).toString())).toString().toUpperCase(),style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),),
                                      Text("Mesure à entrer le",style: TextStyle(fontSize: 13,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[600],fontFamily: "AppFontStyle"),),
                                    ],
                                  ) :
                                  x == 1 ?
                                  snapshot.data!["last_measure"].toString() == "null" ?
                                  SizedBox() :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DateTime.parse(snapshot.data!["last_measure"]["updated_at"]).difference(DateTime.now().toUtc().add(Duration(hours: 2))).inDays  == 0 ?
                                      Text("Aujourd'hui ${DateFormat("HH:mm","fr_FR").format(DateTime.parse(snapshot.data!["last_measure"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      DateTime.parse(snapshot.data!["last_measure"]["updated_at"]).difference(DateTime.now().toUtc().add(Duration(hours: 2))).inDays  == 1 ?
                                      Text("Hier ${DateFormat("HH:mm","fr_FR").format(DateTime.parse(snapshot.data!["last_measure"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      Text(DateFormat.yMMMd("fr_FR").format(DateTime.parse(snapshot.data!["last_measure"]["updated_at"])).toUpperCase(),style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),),
                                      Text("dernière entrée",style: TextStyle(fontSize: 13,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[600],fontFamily: "AppFontStyle"),),
                                    ],
                                  ) :
                                  x == 2 ?
                                  snapshot.data!["last_photos"].toString() == "null" ?
                                  SizedBox() :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DateTime.parse(snapshot.data!["last_photos"]["updated_at"]).difference(DateTime.now().toUtc().add(Duration(hours: 2))).inDays  == 0 ?
                                      Text("Aujourd'hui ${DateFormat("HH:mm","fr_FR").format(DateTime.parse(snapshot.data!["last_photos"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      DateTime.parse(snapshot.data!["last_photos"]["updated_at"]).difference(DateTime.now().toUtc().add(Duration(hours: 2))).inDays  == 1 ?
                                      Text("Hier ${DateFormat("HH:mm","fr_FR").format(DateTime.parse(snapshot.data!["last_photos"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      Text(DateFormat.yMMMd("fr_FR").format(DateTime.parse(snapshot.data!["last_photos"]["updated_at"])).toUpperCase(),style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),),
                                      Text("dernière entrée",style: TextStyle(fontSize: 13,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[600],fontFamily: "AppFontStyle"),),
                                    ],
                                  ) : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  },
                  SizedBox(
                    height: 17,
                  )
                },
                Spacer(),
                _materialbutton.materialButton("Actions de la semaine effectuées".toUpperCase(), () {
                  if(subscriptionDetails.currentdata[0]["macro_status"] == true){
                    if(CheckinServices.checkinSelected.length > 3){
                      _screenLoaders.functionLoader(context);
                      _checkinServices.subsCheckIn().then((value){
                        Navigator.of(context).pop(null);
                        _snackbarMessage.snackbarMessage(context, message: "Vous avez mis à jour votre suivi quotidien.");
                      });
                    }
                  }
                },bckgrndColor: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.grey : CheckinServices.checkinSelected.contains("MON POIDS") && CheckinServices.checkinSelected.contains("MES MESURES") && CheckinServices.checkinSelected.contains("MES PHOTOS") && CheckinServices.checkinSelected.contains("MES OBJECTIFS DE LA SEMAINE") ? AppColors.appmaincolor : Colors.grey, textColor: Colors.white),
                // SizedBox(
                //   height: 10,
                // ),
                // Center(child: Text("Demander l’avis or valider les actions ?",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),)),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
