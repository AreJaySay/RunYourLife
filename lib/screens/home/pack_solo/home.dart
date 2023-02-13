import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/screens/home/components/circles_tracking.dart';
import 'package:run_your_life/screens/home/components/horizontal_tracking_list.dart';
import 'package:run_your_life/screens/home/components/schedule_tracking.dart';
import 'package:run_your_life/screens/home/components/vertical_tracking_list.dart';
import 'package:run_your_life/screens/home/pack_accompanied/home.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step5subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step6subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step7subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/services/stream_services/subscriptions/update_data.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/finish_questioner_popup.dart';
import 'package:run_your_life/widgets/notification_notifier.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../models/device_model.dart';
import '../../../models/measurement.dart';
import '../../../services/apis_services/screens/coaching.dart';
import '../../../services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../services/stream_services/screens/home.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/materialbutton.dart';
import '../../../widgets/message_notifier.dart';
import '../../landing.dart';
import 'package:intl/intl.dart';

class PackSoloHome extends StatefulWidget {
  @override
  _PackSoloHomeState createState() => _PackSoloHomeState();
}

class _PackSoloHomeState extends State<PackSoloHome> {
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Materialbutton _materialbutton = new Materialbutton();
  final CoachingServices _coachingServices = new CoachingServices();
  final ParameterServices _parameterServices = new ParameterServices();
  final ProfileServices _profileServices = new ProfileServices();
  final CheckinServices _checkinServices = new CheckinServices();
  final Step5Service _step5service = new Step5Service();
  final Step6Service _step6service = new Step6Service();
  final Step7Service _step7service = new Step7Service();
  final Routes _routes = new Routes();
  final AppBars _appBars = AppBars();
  int selected = 0;
  final HomeServices _homeServices = new HomeServices();
  List _mesures = ["Cou","Epaules","Poitrine","Haut du bras","Taille","Hanches","Haut de cuisse","Mollet"];
  DateTime selectedDate = DateTime.now().toUtc().add(Duration(hours: 2));

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('fr'),
        initialDate:  DateTime.now().toUtc().add(Duration(hours: 2)),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coachingServices.getplans();
    _subscriptionServices.getInfos().then((val){
      if(val != null){
        setState(() {
          selected = int.parse(val["weight"].toString().contains(",") || val["weight"].toString().contains(".") ? val["weight"].toString().replaceAll(",", "").replaceAll(".", "") : val["weight"]+"0");
        });
        print("WEIGHT "+selected.toString());
      }else{
        selected = 1;
      }
    });
    _homeServices.getSchedule();
    _parameterServices.getSetting();
    _homeServices.getWeights();
    _homeServices.getHeights();
    _homeServices.getLatestCheckin();
    _checkinServices.subsCheckInStatus().then((value){
      print("SUBSCIRPTION CHECK IN ${value.toString()}");
      setState(() {
        if(value != null){
          CheckinServices.checkinSelected = ['MON POIDS',"MES MESURES","MES MACROS","MES PHOTOS","MES OBJECTIFS DE LA SEMAINE"];
        }else{
          CheckinServices.checkinSelected.clear();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: subStreamServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBars.bluegradient(context,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
              children: [
                Image(
                  color: Colors.white,
                  width: 85,
                  image: AssetImage("assets/important_assets/logo_new_white.png"),
                ),
                Spacer(),
                NotificationNotifier(),
                SizedBox(
                  width: 15,
                ),
                MessageNotifier()
              ],
          ),
            )),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                subscriptionDetails.currentdata[0]["macro_status"] == false ? Container() :
                Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/important_assets/heart_icon.png"),
                ),
                ListView(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  children: [
                    ZoomTapAnimation(
                      end: 0.99,
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
                          await showModalBottomSheet(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                              isScrollControlled: true,
                              context: context, builder: (context){
                            return FinishQuestionerPopup(isComplete: false,);
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: DeviceModel.isMobile ? 80 : 110,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.bottomRight,
                              child: Image(
                                image: AssetImage("assets/icons/lock.png"),
                                width: 90,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("PROCHAIN RENDEZ-VOUS",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("--",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),),
                                ],
                              ),
                            )],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ZoomTapAnimation(
                      end: 0.99,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.bottomRight,
                            child: Image(
                              image: AssetImage("assets/icons/lock.png"),
                              width: 90,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 90,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // TERMINER DE REMPLIR LE FORMULAIRE
                                Text("Mes actions de la semaine".toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),),
                                SizedBox(
                                  height: 7,
                                ),
                                Text("--",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: "AppFontStyle"),textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ],
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
                          await showModalBottomSheet(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                              isScrollControlled: true,
                              context: context, builder: (context){
                            return FinishQuestionerPopup(isComplete: false,);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("MON",style: TextStyle(fontSize: 20,color: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.grey : AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                          Text(" SUIVI JOURNALIER",style: TextStyle(fontSize: 20,color: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.grey : AppColors.appmaincolor,fontFamily: "AppFontStyle",fontWeight: FontWeight.bold),),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.calendar_month,size: 23,color: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.grey : AppColors.appmaincolor,),
                            onPressed: (){
                              if(subscriptionDetails.currentdata[0]["macro_status"] != false){
                                _selectDate(context);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    ScheduleTracking(currentDate: selectedDate,),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CirclesTracking(),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    HorizontalTrackingList(),
                    SizedBox(
                      height: 20,
                    ),
                    VerticalTrackingList(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("MON",style: TextStyle(fontSize: 19,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                          Text(" ÉVOLUTION",style: TextStyle(fontSize: 19,color: AppColors.appmaincolor,fontFamily: "AppFontStyle",fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    StreamBuilder<Map>(
                        stream: homeStreamServices.graphWeight,
                        builder: (context, snapshot) {
                          return !snapshot.hasData ?
                          Container(
                            width: double.infinity,
                            height: 200,
                            child: Center(child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            )),
                          ) : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("POIDS",style: TextStyle(fontSize: 14,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w500),),
                            ),
                            Padding(
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    placeLabelsNearAxisLine: true,
                                    labelPlacement: LabelPlacement.onTicks
                                ),
                                series: <LineSeries<SalesData, String>>[
                                  LineSeries<SalesData, String>(
                                      dataSource:  <SalesData>[
                                        if(snapshot.data!["dates"].toString() != "null")...{
                                          for(int x = 0; x < snapshot.data!["dates"].length; x++)...{
                                            SalesData('Semaine ${(x + 1).toString()}', double.parse(snapshot.data!["data"][x].toString())),
                                          }
                                        }
                                      ],
                                      xValueMapper: (SalesData sales, _) => sales.year,
                                      yValueMapper: (SalesData sales, _) => sales.sales
                                  )
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                            ),
                          ],
                        );
                      }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("MESURES",style: TextStyle(fontSize: 14,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    StreamBuilder<List<Measurement>>(
                        stream: homeStreamServices.graphHeight,
                        builder: (context, snapshot) {
                          if(snapshot.hasError || !snapshot.hasData){
                            if(!snapshot.hasData){
                              return Container(
                                width: double.infinity,
                                height: 200,
                                child: Center(child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(),
                                )),
                              );
                            }
                            return Container();
                          }
                          // print(snapshot.data!);
                          final List<Measurement> _result = snapshot.data!;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                  child: AspectRatio(
                                    aspectRatio: 16 / 13,
                                    child: Stack(
                                      children: [
                                        DChartLine(
                                          data: [
                                            for(Measurement data in _result)...{
                                              {
                                                "id" : data.name,
                                                "data" : [
                                                  for(int x = 0 ; x < data.data.length;x++)...{
                                                    {
                                                      "domain" : x,
                                                      "measure" : data.data[x],
                                                    }
                                                  }
                                                ],
                                              },
                                            },
                                          ],
                                          lineColor: (lineData, index, id) => id == "cou" ? Colors.amber : id == "epaules" ? Colors.blueGrey : id == "poitrine" ? Colors.green : id == "biceps" ? Colors.blue : id == "taille" ? Colors.brown : id == "hanche" ? Colors.grey : id == "cuisse" ? Colors.deepPurple : AppColors.appmaincolor,
                                          animate: true,
                                          includePoints: true,
                                        ),
                                        Align(
                                          child: Container(
                                            height: 15,
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.bottomCenter,
                                        )
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 20)
                              ),
                              subscriptionDetails.currentdata[0]["macro_status"] == false ?
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text("Cm",style: TextStyle(fontSize: 12.5,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                              ) : Container(),
                            ],
                          );
                        }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for(int x = 0; x < 4; x++)...{
                            Column(
                              children: [
                                Container(
                                  width: 25,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: x == 0 ? Colors.amber : x == 1 ? Colors.blueGrey : x == 2 ? Colors.green : Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(_mesures[x],style: TextStyle(fontSize: 12,color: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),)
                              ],
                            )
                          }
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for(int x = 4; x < 8; x++)...{
                            Column(
                              children: [
                                Container(
                                  width: 25,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: x == 4 ? Colors.brown : x == 5 ? Colors.grey : x == 6 ? Colors.deepPurple : AppColors.appmaincolor,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(_mesures[x],style: TextStyle(fontSize: 12,color: subscriptionDetails.currentdata[0]["macro_status"] == false ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),)
                              ],
                            )
                          }
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
