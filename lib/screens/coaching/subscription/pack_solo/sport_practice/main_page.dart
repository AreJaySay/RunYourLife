import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';
import 'package:run_your_life/screens/coaching/subscription/form_completed.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sport_practice/make_choices.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sport_practice/not_pregnant/1st_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sport_practice/pregnant/1st_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sport_practice/pregnant/2nd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sport_practice/pregnant/3rd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sport_practice/pregnant/5th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sport_practice/pregnant/6th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_solo/eating/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/stepper.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step5subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/stream_services/subscriptions/step5.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../functions/loaders.dart';

class PackSoloSportMainPage extends StatefulWidget {
  @override
  _PackSoloSportMainPageState createState() => _PackSoloSportMainPageState();
}

class _PackSoloSportMainPageState extends State<PackSoloSportMainPage> {
  List<Widget> _firstscreen = [Container(),SportMakeChoices(),Pregnant1stPage(),Pregnant2ndPage(),Pregnant3rdPage(),Pregnant6thPage()];
  List<Widget> _secondscreen = [Container(),SportMakeChoices(),NotPregnant1stPage()];
  final Materialbutton _materialbutton = new Materialbutton();
  final Step5Service _step5service = new Step5Service();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Routes _routes = new Routes();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  int _currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    step5streamService.update(data: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: step5streamService.stream,
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                children: [
                  MyStepper( step5subs.practice_sport == "Non" ? 2 : 5,range: double.parse(_currentPage.toString()),),
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
                                Text("PRATIQUE SPORTIVE",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        step5subs.practice_sport == "Non" ?
                        _secondscreen[_currentPage] :
                        _firstscreen[_currentPage],
                        SizedBox(
                          height: 50,
                        ),
                        _materialbutton.materialButton("SUIVANT", () {
                          setState(() {
                            if(step5subs.practice_sport == "Non" ? _currentPage > 1 : _currentPage > 4){
                              step5subs.activity_outside_sport_level = "N/A";
                              step5subs.pain = "N/A";
                              step5subs.confident_on_athletic_ability = 0.0;
                              step5subs.comfortable_place = 0.0;
                              step5subs.place_to_practice = 0.0;
                              step5subs.energy_to_practice = 0.0;
                              step5subs.time = 0.0;
                              step5subs.motivation = 0.0;
                              print(step5subs.toMap());
                              _screenLoaders.functionLoader(context);
                              _step5service.submit(context).then((value){
                                if(value != null){
                                  Navigator.of(context).pop(null);
                                  _routes.navigator_push(context, PackSoloEatingMainPage());
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
                              step5subs.activity_outside_sport_level = "N/A";
                              step5subs.pain = "N/A";
                              step5subs.confident_on_athletic_ability = 0.0;
                              step5subs.comfortable_place = 0.0;
                              step5subs.place_to_practice = 0.0;
                              step5subs.energy_to_practice = 0.0;
                              step5subs.time = 0.0;
                              step5subs.motivation = 0.0;
                              _screenLoaders.functionLoader(context);
                              _step5service.submit(context).then((value){
                                if(value != null){
                                  _subscriptionServices.getInfos().whenComplete((){
                                    _routes.navigator_pushreplacement(context, Landing(), transitionType: PageTransitionType.fade);
                                  });
                                }
                              });
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
        );
      }
    );
  }
}
