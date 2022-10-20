import 'package:flutter/material.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/coaching/subscription/form_completed.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_solo/objective/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_solo/sport_practice/main_page.dart';
import 'package:run_your_life/screens/feedback/pack_solo/weekly_update.dart';
import 'package:run_your_life/screens/home/components/circles_tracking.dart';
import 'package:run_your_life/screens/home/components/horizontal_tracking_list.dart';
import 'package:run_your_life/screens/home/components/schedule_tracking.dart';
import 'package:run_your_life/screens/home/components/vertical_tracking_list.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/services/stream_services/subscriptions/update_data.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/notification_notifier.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../models/device_model.dart';
import '../../../models/subscription_models/step1_subs.dart';
import '../../../models/subscription_models/step2_subs.dart';
import '../../../models/subscription_models/step3_subs.dart';
import '../../../models/subscription_models/step4_subs.dart';
import '../../../models/subscription_models/step5_subs.dart';
import '../../../models/subscription_models/step6_subs.dart';
import '../../../models/subscription_models/step7_subs.dart';
import '../../../services/apis_services/screens/coaching.dart';
import '../../../services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../services/stream_services/screens/home.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/materialbutton.dart';
import '../../../widgets/message_notifier.dart';
import '../../coaching/subscription/pack_accompanied/eating/main_page.dart';
import '../../coaching/subscription/pack_accompanied/presentation/main_page.dart';
import '../../coaching/subscription/pack_solo/eating/main_page.dart';
import '../../coaching/subscription/pack_solo/presentation/main_page.dart';
import '../../landing.dart';
import 'package:intl/intl.dart';

class PackSoloHome extends StatefulWidget {
  @override
  _PackSoloHomeState createState() => _PackSoloHomeState();
}

class _PackSoloHomeState extends State<PackSoloHome> {
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final Materialbutton _materialbutton = new Materialbutton();
  final CoachingServices _coachingServices = new CoachingServices();
  final ParameterServices _parameterServices = new ParameterServices();
  final Routes _routes = new Routes();
  final AppBars _appBars = AppBars();
  int selected = 0;
  final HomeServices _homeServices = new HomeServices();

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
                subscriptionDetails.currentdata[0]["form_status"] == false ? Container() : Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/important_assets/heart_icon.png"),
                ),
                ListView(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  children: [
                    ZoomTapAnimation(
                      end: 0.99,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: DeviceModel.isMobile ? 80 : 110,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.30),
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
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("PROCHAIN RENDEZ-VOUS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("--",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        if(subscriptionDetails.currentdata[0]["form_status"] == false){
                          _routes.navigator_pushreplacement(context, Landing(index: 2,));
                        }else{
                          _routes.navigator_push(context, WeeklyUpdate());
                        }
                      },
                    ),
                    subscriptionDetails.currentdata[0]["form_status"] == false ?
                    ZoomTapAnimation(
                      end: 0.99,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20,top: 15),
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
                              height: 5,
                            ),
                            Text("pour obtenir un calcul de macro",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: "AppFontStyle"),),
                          ],
                        ),
                      ),
                      onTap: (){
                        step1subs.editStep1(context, details: snapshot.data!["client_info"] == null  ? {} : snapshot.data!["client_info"]);
                        step2subs.editStep2(context, details: snapshot.data!["food_preference"] == null ? {} : snapshot.data!["food_preference"]);
                        step4subs.editStep4(context, details: snapshot.data!["goal"] == null ? {} : snapshot.data!["goal"]);
                        step5subs.editStep5(context, details: snapshot.data!["sport"] == null ? {} : snapshot.data!["sport"]);

                        // PRESENTATION
                        if(snapshot.data!["client_info"] == null){
                          _routes.navigator_push(context,  PackSoloPresentationMainPage());
                        }else if(snapshot.data!["client_info"]["form_status"] == false){
                          _routes.navigator_push(context, PackSoloPresentationMainPage());
                        }else{
                          // OBJECTIVE
                          if(snapshot.data!["goal"] == null){
                            _routes.navigator_push(context, PackSoloObjectiveMainPage());
                          }else if(snapshot.data!["goal"]["form_status"] == false){
                            _routes.navigator_push(context, PackSoloObjectiveMainPage());
                          }else{
                            // SPORT
                            if(snapshot.data!["sport"] == null){
                              _routes.navigator_push(context, PackSoloSportMainPage());
                            }else if(snapshot.data!["sport"]["form_status"] == false){
                              _routes.navigator_push(context, PackSoloSportMainPage());
                            }else{
                              // ALIMENTATION
                              if(snapshot.data!["food_preference"] == null){
                                _routes.navigator_push(context, PackSoloEatingMainPage());
                              }else if(snapshot.data!["food_preference"]["form_status"] == false){
                                _routes.navigator_push(context, PackSoloEatingMainPage());
                              }else{
                                _routes.navigator_push(context, FormCompleted());
                              }
                            }
                          }
                        }
                      },
                    ) : Container(),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("MON",style: TextStyle(fontSize: 20,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                          Text(" TRACKING JOURNALIER",style: TextStyle(fontSize: 20,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : AppColors.appmaincolor,fontFamily: "AppFontStyle",fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    ScheduleTracking(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CirclesTracking(isMacroSolo: true,),
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
                          Text("MON",style: TextStyle(fontSize: 19,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                          Text(" ÉVOLUTION",style: TextStyle(fontSize: 19,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : AppColors.appmaincolor,fontFamily: "AppFontStyle",fontWeight: FontWeight.bold),),
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
                              child: Text("Poids",style: TextStyle(fontSize: 12.5,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black)
                                        )
                                    ),
                                    child: Text(subscriptionDetails.currentdata[0]["form_status"] == false ? "kg" : "cm",style: TextStyle(fontSize: 12.5,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey[600] : AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                                  ),
                                  Expanded(
                                    child: LineChart(
                                      width: 280,
                                      height: 150,
                                      data: [
                                        for(int x = 0; x < snapshot.data!["dates"].length; x++)...{
                                          LineChartModel(date: DateTime.parse(snapshot.data!["dates"][x]),amount: double.parse(snapshot.data!["data"][x].toString())),
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
                                  Text(DateFormat.yMMMd("fr").format(DateTime.parse(snapshot.data!["dates"][0])).toUpperCase(),style: TextStyle(fontSize: 13,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),),
                                  Text("  -  "),
                                  Text(DateFormat.yMMMd("fr").format(DateTime.parse(snapshot.data!["dates"][snapshot.data!["dates"].length - 1])).toUpperCase(),style: TextStyle(fontSize: 13,color: subscriptionDetails.currentdata[0]["form_status"] == false ? Colors.grey : Colors.black,fontFamily: "AppFontStyle"),)
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                    SizedBox(
                      height: 15,
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
