import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/fillup_later.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/models/subscription_models/step3_subs.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/objective/1st_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/objective/2nd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/objective/4th_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_solo/sport_practice/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/stepper.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step4subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../functions/loaders.dart';
import '../../../../../models/subscription_models/step4_subs.dart';
import '../../../../../services/stream_services/subscriptions/subscription_details.dart';

class PackSoloObjectiveMainPage extends StatefulWidget {
  @override
  _PackSoloObjectiveMainPageState createState() => _PackSoloObjectiveMainPageState();
}

class _PackSoloObjectiveMainPageState extends State<PackSoloObjectiveMainPage> {
  List<Widget> _firstScreen = [Container(),Objective1stPage(),Objective4thPage()];
  List<Widget> _secondSreen = [Container(),Objective1stPage(),Objective2ndPage(),Objective4thPage()];
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Step4Service _step4service = new Step4Service();
  final SignLater _signLater = new SignLater();
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
                MyStepper(step4subs.goal == "Perdre du poids (Tu veux perdre au moins 5 kg)" || step4subs.goal == "Construire du muscle (tu veux construire du muscle et augmenter ton poids de corps)" ? 3 : 2,range: double.parse(_currentPage.toString()),),
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
                              Text("OBJECTIF",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      step4subs.goal == "Perdre du poids (Tu veux perdre au moins 5 kg)" || step4subs.goal == "Construire du muscle (tu veux construire du muscle et augmenter ton poids de corps)" ?
                      _secondSreen[_currentPage] :
                      _firstScreen[_currentPage],
                      SizedBox(
                        height: 50,
                      ),
                      _materialbutton.materialButton("SUIVANT", () {
                        setState(() {
                          if( _currentPage > (step4subs.goal == "Perdre du poids (Tu veux perdre au moins 5 kg)" || step4subs.goal == "Construire du muscle (tu veux construire du muscle et augmenter ton poids de corps)" ? 2 : 1)){
                            _screenLoaders.functionLoader(context);
                            if(subscriptionDetails.currentdata[0]["goal"] != null){
                              setState(() {
                                step4subs.id = subscriptionDetails.currentdata[0]["goal"]["id"].toString();
                              });
                            }
                            _step4service.submit(context).then((value){
                              if(value != null){
                                Navigator.of(context).pop(null);
                                _routes.navigator_push(context, PackSoloSportMainPage());
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
                          _signLater.signLater(context);
                          // _screenLoaders.functionLoader(context);
                          // _step4service.submit(context).then((value){
                          //   if(value != null){
                          //     _subscriptionServices.getInfos().whenComplete((){
                          //       _routes.navigator_pushreplacement(context, Landing(), transitionType: PageTransitionType.fade);
                          //     });
                          //   }
                          // });
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
