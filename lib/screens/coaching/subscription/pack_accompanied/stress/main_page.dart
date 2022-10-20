import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step6_subs.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/stress/2nd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/stress/3rd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/stress/4th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/stepper.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step6subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../functions/loaders.dart';
import '../../../../../services/stream_services/subscriptions/subscription_details.dart';
import '../sleep/main_page.dart';
import '1st_page.dart';

class StressMainPage extends StatefulWidget {
  @override
  _StressMainPageState createState() => _StressMainPageState();
}

class _StressMainPageState extends State<StressMainPage> {
  List<Widget> _screens = [Container(),Stress1stPage(),Stress2ndPage(),Stress3rdPage(),Stress4thPage()];
  final Materialbutton _materialbutton = new Materialbutton();
  final Step6Service _step6service = new Step6Service();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final Routes _routes = new Routes();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
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
                MyStepper(4,range: double.parse(_currentPage.toString()),),
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
                              Text("ETAPE 6",style: TextStyle(fontSize: 29,fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                              SizedBox(
                                height: 5,
                              ),
                              Text("STRESS",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      _screens[_currentPage],
                      SizedBox(
                        height: 50,
                      ),
                      _materialbutton.materialButton("SUIVANT", () {
                        setState(() {
                          if(_currentPage > 3){
                            _screenLoaders.functionLoader(context);
                            if(subscriptionDetails.currentdata[0]["stress"] != null){
                              setState(() {
                                step6subs.id = subscriptionDetails.currentdata[0]["stress"]["id"].toString();
                              });
                            }
                            _step6service.submit(context).then((value){
                              if(value != null){
                                Navigator.of(context).pop(null);
                                _routes.navigator_push(context, SleepMainPage());
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
                          _screenLoaders.functionLoader(context);
                          if(subscriptionDetails.currentdata[0]["stress"] != null){
                            setState(() {
                              step6subs.id = subscriptionDetails.currentdata[0]["stress"]["id"].toString();
                            });
                          }
                          _step6service.submit(context).then((value){
                            if(value != null){
                              Navigator.of(context).pop(null);
                              _routes.navigator_push(context, Landing(), transitionType: PageTransitionType.fade);
                            }
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
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
