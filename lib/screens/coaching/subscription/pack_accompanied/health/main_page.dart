import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/models/subscription_models/step3_subs.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/2nd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/3rd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/4th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/5th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/6th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/7th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/8th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/9th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/objective/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/stepper.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step3subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../services/stream_services/subscriptions/subscription_details.dart';
import '1st_page.dart';

class HealthMainPage extends StatefulWidget {
  @override
  _HealthMainPageState createState() => _HealthMainPageState();
}

class _HealthMainPageState extends State<HealthMainPage> {
  List<Widget> screens = [Container(),Health1stPage(),Health2ndPage(),Health3rdPage(),Health4thPage(),Health5thPage(),Health6thPage(),Health7thPage(),Health8thPage(),Health9thPage()];
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final Step3Service _step3service = new Step3Service();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Routes _routes = new Routes();
  final AppBars _appBars = AppBars();
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
              children: [
                MyStepper( step1subs.gender == "Female" ? 9 : 4,range: double.parse(_currentPage.toString()),),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.all(0),
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              child: Center(
                                child: Platform.isAndroid ? Icon(Icons.arrow_back,color:AppColors.pinkColor,size: 22,) :  Icon(Icons.arrow_back_ios_sharp,color: AppColors.pinkColor,size: 22,),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1000),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5.0, // has the effect of softening the shadow
                                    spreadRadius: 0, // has the effect of extending the shadow
                                    offset: Offset(
                                      0.0, // horizontal, move right 10
                                      2.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                if(_currentPage <= 1){
                                  Navigator.of(context).pop(null);
                                }else{
                                  _currentPage--;
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ETAPE 3",style: TextStyle(fontSize: 29,fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                              SizedBox(
                                height: 5,
                              ),
                              Text("SANTÉ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      screens[_currentPage],
                      SizedBox(
                        height: 50,
                      ),
                      _materialbutton.materialButton("SUIVANT", () {
                        setState(() {
                          if(_currentPage > (step1subs.gender == "Female" ? 8 : 3)){
                            if(step1subs.gender != "Female"){
                              step3subs.contraception = "N/A";
                              step3subs.premenstrual_syndrome = "N/A";
                              step3subs.gynaecological_condition = "N/A";
                              step3subs.observe_menstrual_cycle = "N/A";
                              step3subs.observe_menstrual_cycle = "N/A";
                              step3subs.regular_cycle = "N/A";
                              step3subs.cycle_average = "N/A";
                              step3subs.pregnant = "N/A";
                            }
                            _screenLoaders.functionLoader(context);
                            if(subscriptionDetails.currentdata[0]["medical_history"] != null){
                              setState(() {
                                step3subs.id = subscriptionDetails.currentdata[0]["medical_history"]["id"].toString();
                              });
                            }
                            _step3service.submit(context).then((value){
                              if(value != null){
                                Navigator.of(context).pop(null);
                                _routes.navigator_push(context, ObjectiveMainPage());
                              }
                            });
                          }else{
                            _currentPage++;
                          }
                        });
                      }),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          child: Center(
                            child: Text("PLUS TARD",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600),),
                          ),
                        ),
                        onTap: (){
                          setState((){
                            if(step1subs.gender != "Female"){
                              step3subs.contraception = "N/A";
                              step3subs.premenstrual_syndrome = "N/A";
                              step3subs.gynaecological_condition = "N/A";
                              step3subs.observe_menstrual_cycle = "N/A";
                              step3subs.observe_menstrual_cycle = "N/A";
                              step3subs.regular_cycle = "N/A";
                              step3subs.cycle_average = "N/A";
                              step3subs.pregnant = "N/A";
                            }
                            _screenLoaders.functionLoader(context);
                            if(subscriptionDetails.currentdata[0]["medical_history"] != null){
                              setState(() {
                                step3subs.id = subscriptionDetails.currentdata[0]["medical_history"]["id"].toString();
                              });
                            }
                            _step3service.submit(context).then((value){
                              if(value != null){
                                _subscriptionServices.getInfos().whenComplete((){
                                  _routes.navigator_pushreplacement(context, Landing(), transitionType: PageTransitionType.fade);
                                });
                              }
                            });
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
