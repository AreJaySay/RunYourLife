import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/fillup_later.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/presentation/1st_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_solo/objective/main_page.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step1subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import '../../../../../../services/other_services/routes.dart';
import '../../../../../../utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../../../../../services/stream_services/subscriptions/subscription_details.dart';

class PackSoloPresentationMainPage extends StatefulWidget {
  @override
  _PackSoloPresentationMainPageState createState() => _PackSoloPresentationMainPageState();
}

class _PackSoloPresentationMainPageState extends State<PackSoloPresentationMainPage> {
  final Materialbutton _materialbutton = new Materialbutton();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Step1Service _step1service = new Step1Service();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final Routes _routes = new Routes();
  final SignLater _signLater = new SignLater();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: ListView(
              children: [
                SizedBox(
                  height: 40,
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
                            Navigator.of(context).pop(null);
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
                          Text("ETAPE 1",style: TextStyle(fontSize: 29,fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                          SizedBox(
                            height: 5,
                          ),
                          Text("PRÉSENTATION",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Presentation1stPage(),
                ),
                SizedBox(
                  height: 130,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      _materialbutton.materialButton("SUIVANT", () {
                        setState(() {
                          _screenLoaders.functionLoader(context);
                          if(subscriptionDetails.currentdata[0]["client_info"] != null){
                            setState(() {
                              step1subs.id = subscriptionDetails.currentdata[0]["client_info"]["id"].toString();
                            });
                          }
                          _step1service.submit(context).then((value){
                            if(value != null){
                              Navigator.of(context).pop(null);
                              _routes.navigator_push(context, PackSoloObjectiveMainPage());
                            }
                          });
                        });
                      }),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 20,
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
                          // setState((){
                          //   step1subs.target_weight = "";
                          //   step1subs.isMarried = "";
                          //   step1subs.haveChildren = "";
                          //   step1subs.shopforHousehold = "";
                          //   step1subs.cookforHousehold= "";
                          //   _screenLoaders.functionLoader(context);
                          //   _step1service.submit(context).then((value){
                          //     if(value != null){
                          //       _subscriptionServices.getInfos().whenComplete((){
                          //         _routes.navigator_pushreplacement(context, Landing(), transitionType: PageTransitionType.fade);
                          //       });
                          //     }
                          //   });
                          // });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}