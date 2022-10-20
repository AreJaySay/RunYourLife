import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/my_photos.dart';
import 'package:run_your_life/screens/checkin/components/my_ressources/my_ressources.dart';
import 'package:run_your_life/screens/checkin/components/my_tracking/my_tracking.dart';
import 'package:run_your_life/screens/checkin/components/my_weight/my_weights.dart';
import 'package:run_your_life/screens/checkin/pack_solo/send_tracking.dart';
import 'package:run_your_life/screens/home/components/circles_tracking.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import '../../../services/stream_services/screens/checkin.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/materialbutton.dart';
import '../../../widgets/message_notifier.dart';
import 'package:intl/intl.dart';
import '../../../widgets/notification_notifier.dart';
import '../../../widgets/shimmering_loader.dart';
import '../components/my_measurements/my_measurements.dart';

class PackSoloCheckIn extends StatefulWidget {
  @override
  _PackSoloCheckInState createState() => _PackSoloCheckInState();
}

class _PackSoloCheckInState extends State<PackSoloCheckIn> {
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final AppBars _appBars = new AppBars();
  final CheckinServices _checkinServices = new CheckinServices();
  final List<Widget> _pages = [MyWeights(),MyMeasurements(),MyTracking(),MyPhotos(),Container(),MyRessources()];
  List _todos = ['MON POIDS',"MES MESURES","MES MACROS","MES PHOTOS","MES OBJECTIFS DE LA SEMAINE"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkinServices.getUpdated();
    _checkinServices.subsCheckInStatus();
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
                    Text("CHECK-IN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,fontFamily: "AppFontStyle"),),
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
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              children: [
                Row(
                  children: [
                    Text("MA",style: TextStyle(fontSize: 20,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                    Text(" TODO LIST",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Je coche puis je clique sur Check-In",style: TextStyle(fontSize: 13.5,fontFamily: "AppFontStyle"),),
                SizedBox(
                  height: 25,
                ),
                for(var x = 0 ; x < _todos.length;x++)...{
                  GestureDetector(
                    onTap: (){
                      if(subscriptionDetails.currentdata[0]["form_status"] == true){
                        if(x != 4){
                          _routes.navigator_push(context, _pages[x],);
                        }
                      }
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
                                  onChanged: (value) {
                                    setState(() {
                                      if(CheckinServices.checkinSelected.contains(_todos[x])){
                                        CheckinServices.checkinSelected.remove(_todos[x]);
                                      }else{
                                        CheckinServices.checkinSelected.add(_todos[x]);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: subscriptionDetails.currentdata[0]["form_status"] == false ? CheckinServices.checkinSelected.contains(_todos[x]) ? AppColors.pinkColor : Colors.grey : AppColors.pinkColor,width: 2),
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            padding: EdgeInsets.all(3),
                          ),
                          onTap: (){
                            setState(() {
                              if(CheckinServices.checkinSelected.contains(_todos[x])){
                                CheckinServices.checkinSelected.remove(_todos[x]);
                              }else{
                                CheckinServices.checkinSelected.add(_todos[x]);
                              }
                            });
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
                                  Text(_todos[x],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: subscriptionDetails.currentdata[0]["form_status"] == false? CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[400] : CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                                  Spacer(),
                                  subscriptionDetails.currentdata[0]["form_status"] == false? Container() : x >= 4 ? Container() :
                                  !snapshot.hasData ?
                                  Column(
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
                                  snapshot.data!["last_weight"] == null ?
                                  SizedBox() :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DateTime.parse(snapshot.data!["last_weight"]["updated_at"]).difference(DateTime.now()).inDays  == 0 ?
                                      Text("Aujourd'hui ${DateFormat("HH:mm","fr").format(DateTime.parse(snapshot.data!["last_weight"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      DateTime.parse(snapshot.data!["last_weight"]["updated_at"]).difference(DateTime.now()).inDays  == 1 ?
                                      Text("Hier ${DateFormat("HH:mm","fr").format(DateTime.parse(snapshot.data!["last_weight"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      Text(DateFormat.yMMMd("fr").format(DateTime.parse(snapshot.data!["last_weight"]["updated_at"])).toUpperCase(),style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),),
                                      Text("dernière mise à jour",style: TextStyle(fontSize: 13,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[600],fontFamily: "AppFontStyle"),),
                                    ],
                                  ) :
                                  x == 1 ?
                                  snapshot.data!["last_measure"] == null ?
                                  SizedBox() :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DateTime.parse(snapshot.data!["last_measure"]["updated_at"]).difference(DateTime.now()).inDays  == 0 ?
                                      Text("Aujourd'hui ${DateFormat("HH:mm","fr").format(DateTime.parse(snapshot.data!["last_measure"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      DateTime.parse(snapshot.data!["last_measure"]["updated_at"]).difference(DateTime.now()).inDays  == 1 ?
                                      Text("Hier ${DateFormat("HH:mm","fr").format(DateTime.parse(snapshot.data!["last_measure"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      Text(DateFormat.yMMMd("fr").format(DateTime.parse(snapshot.data!["last_measure"]["updated_at"])).toUpperCase(),style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),),
                                      Text("dernière mise à jour",style: TextStyle(fontSize: 13,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[600],fontFamily: "AppFontStyle"),),
                                    ],
                                  ) :
                                  x == 2 ?
                                  snapshot.data!["last_tracking"] == null ?
                                  SizedBox() :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DateTime.parse(snapshot.data!["last_tracking"]["updated_at"]).difference(DateTime.now()).inDays  == 0 ?
                                      Text("Aujourd'hui ${DateFormat("HH:mm","fr").format(DateTime.parse(snapshot.data!["last_tracking"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      DateTime.parse(snapshot.data!["last_tracking"]["updated_at"]).difference(DateTime.now()).inDays  == 1 ?
                                      Text("Hier ${DateFormat("HH:mm","fr").format(DateTime.parse(snapshot.data!["last_tracking"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      Text(DateFormat.yMMMd("fr").format(DateTime.parse(snapshot.data!["last_tracking"]["updated_at"])).toUpperCase(),style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),),
                                      Text("dernière mise à jour",style: TextStyle(fontSize: 13,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[600],fontFamily: "AppFontStyle"),),
                                    ],
                                  ) :
                                  snapshot.data!["last_photos"] == null ?
                                  SizedBox() :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DateTime.parse(snapshot.data!["last_photos"]["updated_at"]).difference(DateTime.now()).inDays  == 0 ?
                                      Text("Aujourd'hui ${DateFormat("HH:mm","fr").format(DateTime.parse(snapshot.data!["last_photos"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      DateTime.parse(snapshot.data!["last_photos"]["updated_at"]).difference(DateTime.now()).inDays  == 1 ?
                                      Text("Hier ${DateFormat("HH:mm","fr").format(DateTime.parse(snapshot.data!["last_photos"]["updated_at"]))}",style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),) :
                                      Text(DateFormat.yMMMd("fr").format(DateTime.parse(snapshot.data!["last_photos"]["updated_at"])).toUpperCase(),style: TextStyle(fontSize: 15,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[800],fontFamily: "AppFontStyle"),),
                                      Text("dernière mise à jour",style: TextStyle(fontSize: 13,color: CheckinServices.checkinSelected.contains(_todos[x]) ? Colors.white : Colors.grey[600],fontFamily: "AppFontStyle"),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  )
                },
                SizedBox(
                  height: 60,
                ),
                _materialbutton.materialButton("DEMANDER L'AVIS D'UN COACH", () {
                  if(CheckinServices.checkinSelected.length == 5){
                    print(subscriptionDetails.currentdata[0]["id"].toString());
                    _screenLoaders.functionLoader(context);
                    _checkinServices.subsCheckIn().then((value){
                      Navigator.of(context).pop(null);
                      _snackbarMessage.snackbarMessage(context, message: "Vous avez mis à jour votre suivi quotidien.");
                    });
                  }
                  // _routes.navigator_push(context, SendTracking());
                },bckgrndColor: CheckinServices.checkinSelected.length == 5 ? AppColors.appmaincolor : Colors.grey, textColor: Colors.white),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
