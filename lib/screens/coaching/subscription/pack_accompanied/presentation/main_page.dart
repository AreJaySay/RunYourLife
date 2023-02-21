import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/fill_up_later.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/presentation/1st_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/presentation/2nd_page.dart';
import 'package:run_your_life/screens/coaching/subscription/stepper.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step1subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step7subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import '../../../../../../services/other_services/routes.dart';
import '../../../../../../utils/palettes/app_colors.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../../../../../services/stream_services/subscriptions/subscription_details.dart';

class PresentationMainPage extends StatefulWidget {
  @override
  _PresentationMainPageState createState() => _PresentationMainPageState();
}

class _PresentationMainPageState extends State<PresentationMainPage> {
  List<Widget> _screens = [Container(),Presentation1stPage(),Presentation2ndPage()];
  final ProfileServices _profileServices = new ProfileServices();
  final Materialbutton _materialbutton = new Materialbutton();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Step1Service _step1service = new Step1Service();
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                SizedBox(
                  height: 30,
                ),
                MyStepper(2,range: double.parse(_currentPage.toString()),),
                SizedBox(
                  height: 20,
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
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: _screens[_currentPage],
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: _materialbutton.materialButton("SUIVANT", () {
                    if(step1subs.weight == "" || step1subs.height == ""){
                      _snackbarMessage.snackbarMessage(context, message: "Le poids et la taille sont requis. Veuillez ne pas le laisser vide !", is_error: true);
                    }else{
                      setState(() {
                        step1subs.target_weight = "N/A";
                        if(_currentPage > 1){
                          // _screenLoaders.functionLoader(context);
                          if(subscriptionDetails.currentdata[0]["client_info"] != null){
                            setState(() {
                              step1subs.id = subscriptionDetails.currentdata[0]["client_info"]["id"].toString();
                            });
                          }
                          _step1service.submit(context).then((value){
                            if(value != null){
                              _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString(), relation: "activeSubscription").whenComplete((){
                                Navigator.of(context).pop(null);
                                _routes.navigator_push(context, EatingMainPage());
                              });
                            }
                          });
                        }else{
                          _currentPage++;
                        }
                      });
                    }
                  }),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: 55,
                    child: Center(
                      child: Text("PLUS TARD",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600),),
                    ),
                  ),
                  onTap: (){
                    if(step1subs.weight == "" || step1subs.height == ""){
                      _snackbarMessage.snackbarMessage(context, message: "Le poids et la taille sont requis. Veuillez ne pas le laisser vide !", is_error: true);
                    }else{
                      setState((){
                        step1subs.target_weight = "N/A";
                        _screenLoaders.functionLoader(context);
                        if(subscriptionDetails.currentdata[0]["client_info"] != null){
                          setState(() {
                            step1subs.id = subscriptionDetails.currentdata[0]["client_info"]["id"].toString();
                          });
                        }
                        _step1service.submit(context).then((value){
                          if(value != null){
                            Navigator.of(context).pop(null);
                            _routes.navigator_push(context, Landing(), transitionType: PageTransitionType.fade);
                          }
                        });
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}