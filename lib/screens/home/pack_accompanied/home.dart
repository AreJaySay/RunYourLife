import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/measurement.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/objective/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sleep/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sport_practice/main_page.dart';
import 'package:run_your_life/screens/home/components/circles_tracking.dart';
import 'package:run_your_life/screens/home/components/horizontal_tracking_list.dart';
import 'package:run_your_life/screens/home/components/schedule_tracking.dart';
import 'package:run_your_life/screens/home/components/vertical_tracking_list.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/screens/coaching.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/services/stream_services/subscriptions/update_data.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/notification_notifier.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../models/device_model.dart';
import '../../../models/subscription_models/step1_subs.dart';
import '../../../models/subscription_models/step2_subs.dart';
import '../../../models/subscription_models/step3_subs.dart';
import '../../../models/subscription_models/step4_subs.dart';
import '../../../models/subscription_models/step5_subs.dart';
import '../../../models/subscription_models/step6_subs.dart';
import '../../../models/subscription_models/step7_subs.dart';
import '../../../services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../services/stream_services/screens/home.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/materialbutton.dart';
import '../../../widgets/message_notifier.dart';
import '../../coaching/subscription/pack_accompanied/presentation/main_page.dart';
import '../../coaching/subscription/pack_accompanied/stress/main_page.dart';
import 'package:intl/intl.dart';

class PackAccompaniedHome extends StatefulWidget {
  @override
  _PackAccompaniedHomeState createState() => _PackAccompaniedHomeState();
}

class _PackAccompaniedHomeState extends State<PackAccompaniedHome> {
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final CoachingServices _coachingServices = new CoachingServices();
  final ParameterServices _parameterServices = new ParameterServices();
  final HomeServices _homeServices = new HomeServices();
  final AppBars _appBars = AppBars();
  int selected = 0;
  List _mesures = ["Cou","Epaules","Poitrine","Haut du bras","Taille","Hanches","Haut de cuisse","Mollet"];
  List _kg = ["500","450","400","350","300","250","200","150","100","50","0"];
  List _cm = ["1.0,","0.8","0.6","0.4","0.2","0","-0.2","-0.4","-0.6","-0.8","-1.0"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ACCESS : ${Auth.accessToken}");
    _homeServices.getSchedule();
    _coachingServices.getplans();
    _subscriptionServices.getInfos();
    _parameterServices.getSetting();
    _homeServices.getWeights();
    _homeServices.getHeights();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: subStreamServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: _appBars.bluegradient(context,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
              children: [
                Image(
                  color: Colors.white,
                  width: 85,
                  image: AssetImage("assets/important_assets/logo-white.png"),
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
                      onTap: (){
                        if( subscriptionDetails.currentdata[0]["form_status"] == true ){
                          _routes.navigator_pushreplacement(context, Landing(index: 2,), transitionType: PageTransitionType.fade);
                          landingServices.updateIndex(index: 2);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: DeviceModel.isMobile ? 80 : 110,
                        decoration: BoxDecoration(
                          color: AppColors.pinkColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: subscriptionDetails.currentdata[0]["form_status"] == false ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("PROCHAIN RENDEZ-VOUS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
                            SizedBox(
                              height: 5,
                            ),
                            Text("--",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),),
                          ],
                        ) :
                        StreamBuilder<Map>(
                          stream: homeStreamServices.meeting,
                          builder: (context, snapshot) {
                            if(snapshot.hasError || !snapshot.hasData){
                              return Container();
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("PROCHAIN RENDEZ-VOUS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                                SizedBox(
                                  height: 5,
                                ),
                                !snapshot.hasData ?
                                Text("--",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),):
                                Text(snapshot.data!.isEmpty ? "--" :
                                snapshot.data!["UpcomingSchedule"].toString() == "[]" ?
                                "--" :
                                DateFormat("EEE dd MMMM","fr").format(DateTime.parse(snapshot.data!["UpcomingSchedule"]["date"].toString())).toUpperCase()+" - "+snapshot.data!["UpcomingSchedule"]["time"][snapshot.data!["UpcomingSchedule"]["time"].length - 1].toString(),style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                              ],
                            );
                          }
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    subscriptionDetails.currentdata[0]["form_status"] == false ?
                    ZoomTapAnimation(
                      end: 0.99,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        width: double.infinity,
                        height: DeviceModel.isMobile ? 80 : 110,
                        decoration: BoxDecoration(
                            gradient: AppGradientColors.gradient,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("TERMINER DE REMPLIR LE FORMULAIRE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
                            SizedBox(
                              height: 7,
                            ),
                            Text("pour obtenir un calcul de macro",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: "AppFontStyle"),),
                          ],
                        ),
                      ),
                      onTap: (){
                        setState((){
                          print(snapshot.data!["client_info"].toString());
                          step1subs.editStep1(context, details: snapshot.data!["client_info"] == null ? {} : snapshot.data!["client_info"]);
                          step2subs.editStep2(context, details: snapshot.data!["food_preference"] == null ? {} : snapshot.data!["food_preference"]);
                          step3subs.editStep3(context, details: snapshot.data!["medical_history"] == null ? {} : snapshot.data!["medical_history"]);
                          step4subs.editStep4(context, details: snapshot.data!["goal"] == null ? {} : snapshot.data!["goal"]);
                          step5subs.editStep5(context, details: snapshot.data!["sport"] == null ? {} : snapshot.data!["sport"]);
                          step6subs.editStep6(context, details: snapshot.data!["stress"] == null ? {} : snapshot.data!["stress"]);
                          step7subs.editStep7(context, details: snapshot.data!["sleep"] == null ? {} : snapshot.data!["sleep"]);

                          //PRESENTATION
                          if(snapshot.data!["client_info"] == null){
                            _routes.navigator_push(context, PresentationMainPage());
                          }else if(snapshot.data!["client_info"]["form_status"] == false){
                            _routes.navigator_push(context, PresentationMainPage());
                          }else{
                            // ALIMENTATION
                            if(snapshot.data!["food_preference"] == null){
                              _routes.navigator_push(context, EatingMainPage());
                            }else if(snapshot.data!["food_preference"]["form_status"] == false){
                              _routes.navigator_push(context, EatingMainPage());
                            }else{
                              // HEALTH
                              if(snapshot.data!["medical_history"] == null){
                                _routes.navigator_push(context, HealthMainPage());
                              }else if(snapshot.data!["medical_history"]["form_status"] == false){
                                _routes.navigator_push(context, HealthMainPage());
                              }else{
                                // OBJECTIVE
                                if(snapshot.data!["goal"] == null){
                                  _routes.navigator_push(context, ObjectiveMainPage());
                                }else if(snapshot.data!["goal"]["form_status"] == false){
                                  _routes.navigator_push(context, ObjectiveMainPage());
                                }else{
                                  // SPORT
                                  if(snapshot.data!["sport"] == null){
                                    _routes.navigator_push(context, SportMainPage());
                                  }else if(snapshot.data!["sport"]["form_status"] == false){
                                    _routes.navigator_push(context, SportMainPage());
                                  }else{
                                    // STRESS
                                    if(snapshot.data!["stress"] == null){
                                      _routes.navigator_push(context, StressMainPage());
                                    }else if(snapshot.data!["stress"]["form_status"] == false){
                                      _routes.navigator_push(context, StressMainPage());
                                    }else{
                                      // SLEEP
                                      if(snapshot.data!["sleep"] == null){
                                        _routes.navigator_push(context, SleepMainPage());
                                      }else if(snapshot.data!["sleep"]["form_status"] == false){
                                        _routes.navigator_push(context, SleepMainPage());
                                      }else{

                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        });
                      },
                    ) : Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: DeviceModel.isMobile ? 165 : 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                      ),
                      child: Column(
                        children: [
                          StreamBuilder<Map>(
                            stream: homeStreamServices.meeting,
                            builder: (context, snapshot) {
                              return Expanded(
                                child: ZoomTapAnimation(
                                  end: 0.99,
                                  onTap: (){
                                    _routes.navigator_pushreplacement(context, Landing(index: 1,), transitionType: PageTransitionType.fade);
                                    landingServices.updateIndex(index: 1);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: AppGradientColors.gradient,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)
                                      )
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("DERNIER ENVOI DU CHECK-IN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        !snapshot.hasData ?
                                        Text("--",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),) :
                                        snapshot.data!["PastSchedule"].toString() == "[]" ?
                                        Text("--",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),) :
                                        int.parse(DateTime.parse(snapshot.data!["PastSchedule"]["date"].toString()).difference(DateTime.now()).inDays.toString()) == 0 ?
                                        Text("Aujourd'hui",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),) :
                                        int.parse(DateTime.parse(snapshot.data!["PastSchedule"]["date"].toString()).difference(DateTime.now()).inDays.toString()) == 1 ?
                                        Text("Hier",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),) :
                                        Text("Il y a ${DateTime.parse(snapshot.data!["PastSchedule"]["date"].toString()).difference(DateTime.now()).inDays.toString()} jours".toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                          Container(
                            width: double.infinity,
                            height: DeviceModel.isMobile ? 80 : 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)
                                )
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.error,size: 60,color: AppColors.appmaincolor.withOpacity(0.07),),
                                ),
                                Center(child: Text("Certains objectifs ne sont pas remplis \npour faire un check-in",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.appmaincolor),textAlign: TextAlign.center,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("MON",style: TextStyle(fontSize: 20,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                          Text(" TRACKING JOURNALIER",style: TextStyle(fontSize: 20,color: AppColors.appmaincolor,fontFamily: "AppFontStyle",fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    ScheduleTracking(),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CirclesTracking(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    HorizontalTrackingList(),
                    SizedBox(
                      height: 15,
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
                          Text(" ÉVOLUTION",style: TextStyle(fontSize:19,color: AppColors.appmaincolor,fontFamily: "AppFontStyle",fontWeight: FontWeight.bold),),
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
                        ) :
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            subscriptionDetails.currentdata[0]["form_status"] == false ?
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Poids",style: TextStyle(fontSize: 12.5,color: Colors.grey,fontFamily: "AppFontStyle"),),
                            ): Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("MON POIDS",style: TextStyle(fontSize: 14,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w500),),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                subscriptionDetails.currentdata[0]["form_status"] == false ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("kg",style: TextStyle(fontSize: 12.5,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                                ) : Container(),
                              ],
                            ),
                            SizedBox(
                              height: subscriptionDetails.currentdata[0]["form_status"] == false ? 15 : 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black)
                                        )
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text("Kg",style: TextStyle(fontSize: 14,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey[600] : AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                                        Spacer(),
                                        for(int x = 0; x < _kg.length; x++)...{
                                          Text(_kg[x],style: TextStyle(fontSize: 12.5,fontFamily: "AppFontStyle",color: Colors.blueGrey),)
                                        }
                                      ],
                                    ),
                                    padding: EdgeInsets.only(right: 5),
                                  ),
                                  Expanded(
                                    child: LineChart(
                                      width: 280,
                                      height: 200,
                                      data: [
                                        for(int x = 0; x < snapshot.data!["dates"].length; x++)...{
                                          LineChartModel(date: DateTime.parse(DateFormat("yyyy-MM-dd","fr").format(DateTime.parse("${snapshot.data!["dates"][0].toString().split("-")[2]}-${snapshot.data!["dates"][0].toString().split("-")[1]}-${snapshot.data!["dates"][0].toString().split("-")[0]}"))),amount: double.parse(snapshot.data!["data"][x].toString())),
                                        }
                                      ],
                                      linePaint: Paint()
                                        ..strokeWidth = 1.5
                                        ..style = PaintingStyle.stroke
                                        ..color = subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : AppColors.appmaincolor.withOpacity(0.4),
                                      circlePaint: Paint()..color = subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : AppColors.appmaincolor.withOpacity(0.4),
                                      showPointer: true,
                                      showCircles: true,
                                      customDraw: (Canvas canvas, Size size) {},
                                      circleRadiusValue: 5,
                                      linePointerDecoration: BoxDecoration(
                                        color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black,
                                      ),
                                      pointerDecoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : AppColors.appmaincolor.withOpacity(0.4),
                                      ),
                                      insideCirclePaint: Paint()..color = subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : AppColors.appmaincolor.withOpacity(0.3),
                                      onValuePointer: (value) {
                                        print('onValuePointer');
                                      },
                                      onDropPointer: () {
                                        print('onDropPointer');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black)
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(DateFormat.yMMMd("fr").format(DateTime.parse("${snapshot.data!["dates"][0].toString().split("-")[2]}-${snapshot.data!["dates"][0].toString().split("-")[1]}-${snapshot.data!["dates"][0].toString().split("-")[0]}")).toUpperCase(),style: TextStyle(fontSize: 13,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),),
                                  Text("  -  "),
                                  Text(DateFormat.yMMMd("fr").format(DateTime.parse("${snapshot.data!["dates"][snapshot.data!["dates"].length - 1].toString().split("-")[2]}-${snapshot.data!["dates"][snapshot.data!["dates"].length - 1].toString().split("-")[1]}-${snapshot.data!["dates"][snapshot.data!["dates"].length - 1].toString().split("-")[0]}")).toUpperCase(),style: TextStyle(fontSize: 13,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),)
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    subscriptionDetails.currentdata[0]["form_status"] == false ?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Mesures",style: TextStyle(fontSize: 12.5,color: Colors.grey,fontFamily: "AppFontStyle"),),
                    ): Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("MES MESURES",style: TextStyle(fontSize: 14,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w500),),
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
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                subscriptionDetails.currentdata[0]["form_status"] == false ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Cm",style: TextStyle(fontSize: 12.5,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                                ) : Container(),
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: DChartLine(
                                      data: [
                                        for(Measurement data in _result)...{
                                          {
                                            "id" : data.name,
                                            "data" : [
                                              for(int x = 0 ; x<data.data.length;x++)...{
                                                {
                                                  "domain" : x,
                                                  "measure" : data.data[x],
                                                }
                                              }
                                            ],
                                          },
                                        },
                                       ],
                                      lineColor: (lineData, index, id) => id == "neck" ? Colors.amber : id == "shoulder" ? Colors.blueGrey : id == "chest" ? Colors.green : id == "upper_arm" ? Colors.blue : id == "waist" ? Colors.brown : id == "hips" ? Colors.grey : id == "upper_thigh" ? Colors.deepPurple : Colors.red,
                                      animate: true,
                                      includePoints: true,
                                    ),
                                    // ),
                                  ),
                                ),
                              ],
                            );
                          }
                        )
                        ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black)
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
                                      width: 20,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1000),
                                        color: x == 0 ? Colors.amber : x == 1 ? Colors.blueGrey : x == 2 ? Colors.green : x == 3 ? Colors.blue : x == 4 ? Colors.brown : x == 5 ? Colors.grey : x == 6 ? Colors.deepPurple : Colors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(_mesures[x],style: TextStyle(fontSize: 12,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),)
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
                                  width: 20,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    color: x == 0 ? Colors.amber : x == 1 ? Colors.blueGrey : x == 2 ? Colors.green : x == 3 ? Colors.blue : x == 4 ? Colors.brown : x == 5 ? Colors.grey : x == 6 ? Colors.deepPurple : Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(_mesures[x],style: TextStyle(fontSize: 12,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),)
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
