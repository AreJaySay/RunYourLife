import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/10th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/11th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/12th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/2nd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/3rd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/4th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/5th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/6th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/7th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/8th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/9th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/health/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/stepper.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step2subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import '../../../../../../functions/loaders.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../models/subscription_models/step2_subs.dart';
import '1st_page.dart';

class EatingMainPage extends StatefulWidget {
  @override
  _EatingMainPageState createState() => _EatingMainPageState();
}

class _EatingMainPageState extends State<EatingMainPage> {
  List<Widget> _screens = [Container(),Eating1stPage(),Eating2ndPage(),Eating3rdPage(),Eating4thPage(),Eating5thPage(),Eating6thPage(),Eating7thPage(),Eating8thPage(),Eating9thPage(),Eating10thPage(),Eating11thPage(),Eating12thPage()];
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Step2Service _step2service = new Step2Service();
  final ProfileServices _profileServices = new ProfileServices();
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
                MyStepper(12,range: double.parse(_currentPage.toString()),),
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
                              Text("ETAPE 2",style: TextStyle(fontSize: 29,fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                              SizedBox(
                                height: 5,
                              ),
                              Text("ALIMENTATION",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
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
                          if(_currentPage > 11){
                            _screenLoaders.functionLoader(context);
                            if(subscriptionDetails.currentdata[0]["food_preference"] != null){
                              setState(() {
                                step2subs.id = subscriptionDetails.currentdata[0]["food_preference"]["id"].toString();
                              });
                            }
                            _step2service.submit(context).then((value){
                              if(value != null){
                                _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString(), relation: "activeSubscription").whenComplete((){
                                  // _subscriptionServices.getInfos().whenComplete((){
                                  Navigator.of(context).pop(null);
                                  _routes.navigator_pushreplacement(context, HealthMainPage());
                                  // });
                                });
                              }
                            });
                          }else{
                            if(step2subs.meals_per_day == ""){
                              _snackbarMessage.snackbarMessage(context, message: "Le nombre de repas par jour est requis!", is_error: true);
                            }else{
                              _currentPage++;
                            }
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
                          if(subscriptionDetails.currentdata[0]["food_preference"] != null){
                            setState(() {
                              step2subs.id = subscriptionDetails.currentdata[0]["food_preference"]["id"].toString();
                            });
                          }
                          _step2service.submit(context).then((value){
                            if(value != null){
                              _subscriptionServices.getInfos().whenComplete((){
                                _routes.navigator_pushreplacement(context, Landing(), transitionType: PageTransitionType.fade);
                              });
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
