import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step7_subs.dart';
import 'package:run_your_life/screens/coaching/subscription/form_completed.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sleep/2nd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/stepper.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step7subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import '../../../../../../services/other_services/routes.dart';
import '../../../../../../utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '1st_page.dart';
import '3rd_page.dart';

class SleepMainPage extends StatefulWidget {
  @override
  _SleepMainPageState createState() => _SleepMainPageState();
}

class _SleepMainPageState extends State<SleepMainPage> {
  List<Widget> _screens = [Container(), Sleep1stPage(), Sleep2ndPage(), Sleep3rdPage()];
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Step7Service _step7service = new Step7Service();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Routes _routes = new Routes();
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
                MyStepper(3,range: double.parse(_currentPage.toString()),),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
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
                          Text("ETAPE 7",style: TextStyle(fontSize: 29,fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                          SizedBox(
                            height: 5,
                          ),
                          Text("SLEEP",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: _screens[_currentPage],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      _materialbutton.materialButton("SUIVANT", () {
                        setState(() {
                          if(_currentPage > 2){
                            _screenLoaders.functionLoader(context);
                            if(subscriptionDetails.currentdata[0]["sleep"] != null){
                              setState(() {
                                step7subs.id = subscriptionDetails.currentdata[0]["sleep"]["id"].toString();
                              });
                            }
                            _step7service.submit(context).then((value){
                              if(value != null){
                                Navigator.of(context).pop(null);
                                _routes.navigator_push(context, FormCompleted());
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
                          if(subscriptionDetails.currentdata[0]["sleep"] != null){
                            setState(() {
                              step7subs.id = subscriptionDetails.currentdata[0]["sleep"]["id"].toString();
                            });
                          }
                          _step7service.submit(context).then((value){
                            if(value != null){
                              Navigator.of(context).pop(null);
                              _routes.navigator_push(context, Landing(), transitionType: PageTransitionType.fade);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}