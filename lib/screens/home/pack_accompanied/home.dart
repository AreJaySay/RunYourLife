import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math';
import 'package:run_your_life/models/measurement.dart';
import 'package:run_your_life/screens/home/components/circles_tracking.dart';
import 'package:run_your_life/screens/home/components/horizontal_tracking_list.dart';
import 'package:run_your_life/screens/home/components/schedule_tracking.dart';
import 'package:run_your_life/screens/home/components/vertical_tracking_list.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/coaching.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/stream_services/screens/checkin.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/services/stream_services/subscriptions/update_data.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/notification_notifier.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../models/device_model.dart';
import '../../../services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../services/stream_services/screens/home.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/finish_questioner_popup.dart';
import '../../../widgets/materialbutton.dart';
import '../../../widgets/message_notifier.dart';
import 'package:intl/intl.dart';

class PackAccompaniedHome extends StatefulWidget {
  @override
  _PackAccompaniedHomeState createState() => _PackAccompaniedHomeState();
}

class _PackAccompaniedHomeState extends State<PackAccompaniedHome> {
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();
  final CheckinServices _checkinServices = new CheckinServices();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final CoachingServices _coachingServices = new CoachingServices();
  final ParameterServices _parameterServices = new ParameterServices();
  final HomeServices _homeServices = new HomeServices();
  List<Color> _palettes = [Colors.amber,Colors.blueGrey,Colors.green, Colors.blue, Colors.brown,Colors.grey,Colors.deepPurple,AppColors.appmaincolor];
  final AppBars _appBars = AppBars();
  int selected = 0;
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
    _homeServices.getSchedule();
    _coachingServices.getplans();
    _subscriptionServices.getInfos();
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
                Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/important_assets/heart_icon.png"),
                ),
                ListView(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  children: [
                    subscriptionDetails.currentdata[0]["macro_status"] == false ?
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
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            alignment: Alignment.bottomRight,
                            child: Image(
                              image: AssetImage("assets/icons/lock.png"),
                              width: 80,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: DeviceModel.isMobile ? 80 : 110,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)
                            ),
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
                          ),
                        ],
                      ),
                    ) :
                    ZoomTapAnimation(
                      end: 0.99,
                      onTap: (){
                        if( subscriptionDetails.currentdata[0]["macro_status"] == true ){
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
                        child: StreamBuilder<Map>(
                          stream: homeStreamServices.meeting,
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("PROCHAIN RENDEZ-VOUS",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle",fontSize: 15),),
                                SizedBox(
                                  height: 5,
                                ),
                                !homeStreamServices.meeting.hasValue ?
                                Text("--",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),) :
                                Text(homeStreamServices.currentMeeting.isEmpty ? "--" :
                                homeStreamServices.currentMeeting["upcomingschedule"].toString() == "[]" ?
                                "--" :
                                DateFormat("EEE dd MMMM","fr").format(DateTime.parse(homeStreamServices.currentMeeting["upcomingschedule"]["date"].toString())).toUpperCase()+" - "+homeStreamServices.currentMeeting["upcomingschedule"]["time"][0].toString(),style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                              ],
                            );
                          }
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    subscriptionDetails.currentdata[0]["macro_status"] == false ?
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
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            alignment: Alignment.bottomRight,
                            child: Image(
                              image: AssetImage("assets/icons/lock.png"),
                              width: 80,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: DeviceModel.isMobile ? 80 : 110,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Mes actions de la semaine".toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("--",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ) :
                    CheckinServices.checkinSelected.toString() == "[]" ?
                    ZoomTapAnimation(
                      end: 0.99,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: DeviceModel.isMobile ? 100 : 120,
                        decoration: BoxDecoration(
                            gradient: AppGradientColors.gradient,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // TERMINER DE REMPLIR LE FORMULAIRE
                            Text("Mes actions de la semaine".toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
                            SizedBox(
                              height: 7,
                            ),
                            Text("Il te reste des actions hebdomadaires. Accomplis-les avant de faire le point avec ton coach.",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: "AppFontStyle"),textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      onTap: (){
                        landingServices.updateIndex(index: 1);
                      },
                    ) :
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: DeviceModel.isMobile ? 100 : 120,
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
                            stream: homeStreamServices.latestCheckin,
                            builder: (context, latestCheckin) {
                              return Expanded(
                                child: ZoomTapAnimation(
                                  end: 0.99,
                                  onTap: (){
                                    _routes.navigator_pushreplacement(context, Landing(index: 1,), transitionType: PageTransitionType.fade);
                                    landingServices.updateIndex(index: 1);
                                  },
                                  child: !latestCheckin.hasData ?
                                  Container(
                                     padding: EdgeInsets.symmetric(horizontal: 20),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          gradient: AppGradientColors.gradient,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Mes actions de la semaine".toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text("--",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle",fontSize: 13),textAlign: TextAlign.center,)
                                        ],
                                      )
                                  ) :
                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 30),
                                      decoration: BoxDecoration(
                                         color: Colors.blueGrey,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Mes actions de la semaine".toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text("Toutes les actions de la semaine sont bien validées, tu es prêt pour le point avec ton coach.",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "AppFontStyle"),textAlign: TextAlign.center,),
                                        ],
                                      ) ,
                                  ),
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("MON",style: TextStyle(fontSize: 20,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                          Text(" SUIVI JOURNALIER",style: TextStyle(fontSize: 20,color: AppColors.appmaincolor,fontFamily: "AppFontStyle",fontWeight: FontWeight.bold),),
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
                              SizedBox(
                                height: 10,
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
                                        for(int x = 0; x < snapshot.data!["dates"].length; x++)...{
                                          SalesData('Semaine ${(x + 1).toString()}', double.parse(snapshot.data!["data"][x].toString())),
                                        }
                                      ],
                                      xValueMapper: (SalesData sales, _) => sales.year,
                                      yValueMapper: (SalesData sales, _) => sales.sales,

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
                              // SfCartesianChart(
                              //   primaryXAxis: CategoryAxis(
                              //       placeLabelsNearAxisLine: true,
                              //       labelPlacement: LabelPlacement.onTicks
                              //   ),
                              //   series: <LineSeries<SalesData, String>>[
                              //     LineSeries<SalesData, String>(
                              //       dataSource: <SalesData>[
                              //         for(int x = 0; x < _result.length; x++)...{
                              //           for(int d = 0; d < _result[x].data.length; d++)...{
                              //             SalesData('Semaine ${(d + 1).toString()}', double.parse(_result[x].data[d].toString())),
                              //           }
                              //         }
                              //       ],
                              //       xValueMapper: (SalesData sales, _) => sales.year,
                              //       yValueMapper: (SalesData sales, _) => sales.sales,
                              //       pointColorMapper: (SalesData sales, index) => index ==   ? Colors.amber : id == "epaules" ? Colors.blueGrey : id == "poitrine" ? Colors.green : id == "biceps" ? Colors.blue : id == "taille" ? Colors.brown : id == "hanche" ? Colors.grey : id == "cuisse" ? Colors.deepPurple : AppColors.appmaincolor
                              //     )
                              //   ],
                              // ),
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
                                            child: Row(
                                              children: [
                                                for(int x = 0; x < 6; x++)...{
                                                  Text("Semaine${(x + 1).toString()}",style: TextStyle(fontSize: 11.5,color: Colors.grey[700]))
                                                }
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            ),
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

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}