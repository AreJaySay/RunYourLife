import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/eating/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/objective/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/presentation/main_page.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/sport_practice/main_page.dart';
import 'package:run_your_life/screens/profile/components/general/components/form_design.dart';
import 'package:run_your_life/screens/profile/components/parameters.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/subscriptions/update_data.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../models/screens/profile/parameters.dart';
import '../../../../models/subscription_models/step1_subs.dart';
import '../../../../models/subscription_models/step2_subs.dart';
import '../../../../models/subscription_models/step4_subs.dart';
import '../../../../models/subscription_models/step5_subs.dart';
import '../../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../coaching/subscription/form_completed.dart';
import '../../../coaching/subscription/pack_solo/eating/main_page.dart';
import '../../../coaching/subscription/pack_solo/objective/main_page.dart';
import '../../../coaching/subscription/pack_solo/presentation/main_page.dart';
import '../../../coaching/subscription/pack_solo/sport_practice/main_page.dart';

class ProfileGeneral extends StatefulWidget {
  final Map formInfo;
  ProfileGeneral({required this.formInfo});
  @override
  _ProfileGeneralState createState() => _ProfileGeneralState();
}

class _ProfileGeneralState extends State<ProfileGeneral> {
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ProfileServices _profileServices = new ProfileServices();
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return Auth.loggedUser == null ? Center(child: CircularProgressIndicator(
      color: AppColors.appmaincolor,strokeWidth: 2.5,
    )) : Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Genre", style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.formInfo["client_info"].toString() == "null" ? "--" : widget.formInfo["client_info"]["gender"].toString() == "null" ? "--" : widget.formInfo["client_info"]["gender"].toString().toLowerCase() == "Male".toLowerCase() ? "Homme" : "Femme", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Date de naissance",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.formInfo["client_info"].toString() == "null" ? "--" : widget.formInfo["client_info"]["birth_date"].toString() == "null" ? "--" : "${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.formInfo["client_info"]["birth_date"].toString()))} (${int.parse(DateTime.now().toUtc().add(Duration(hours: 2)).year.toString()) - int.parse(DateFormat("yyyy").format(DateTime.parse(widget.formInfo["client_info"]["birth_date"].toString())))} ans)", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),),
                     ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Poids",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.formInfo["client_info"].toString() == "null" ? "--" : widget.formInfo["client_info"]["weight"].toString() == "null" ? "--" : "${widget.formInfo["client_info"]["weight"].toString()} kg", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Taille",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 5,
                        ),
                        Text(widget.formInfo["client_info"].toString() == "null" ? "--" : widget.formInfo["client_info"]["height"].toString() == "null" ? "--" : "${widget.formInfo["client_info"]["height"].toString()} cm", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: 120,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Téléphone",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(Auth.loggedUser!["phone_1"].toString() == "null" ? "--" : Auth.loggedUser!["phone_1"], style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  width: 120,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      SizedBox(
                        height: 5,
                      ),
                      Text(Auth.loggedUser!["email"].toString() == "null" ? "--" : Auth.loggedUser!["email"], style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),)
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          subscriptionDetails.currentdata[0]["macro_status"] == true ? Container() : Divider(),
          subscriptionDetails.currentdata[0]["macro_status"] == true ?
          Container() :
          _materialbutton.materialButton("Compléter Le Questionnaire".toUpperCase(), () {
            _screenLoaders.functionLoader(context);
            _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString(), relation: "activeSubscription").whenComplete((){
              Navigator.of(context).pop(null);
              if(subStreamServices.currentdata["client_info"] == null){
                _routes.navigator_push(context, subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloPresentationMainPage() : PresentationMainPage());
              }else if(subStreamServices.currentdata["client_info"]["macro_status"] == false){
                _routes.navigator_push(context, subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloPresentationMainPage() : PresentationMainPage());
              }else{
                // OBJECTIVE
                if(subStreamServices.currentdata["goal"] == null){
                  _routes.navigator_push(context, subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloObjectiveMainPage() : ObjectiveMainPage());
                }else if(subStreamServices.currentdata["goal"]["macro_status"] == false){
                  _routes.navigator_push(context, subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloObjectiveMainPage() : ObjectiveMainPage());
                }else{
                  // SPORT
                  if(subStreamServices.currentdata["sport"] == null){
                    _routes.navigator_push(context, subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloSportMainPage() : SportMainPage());
                  }else if(subStreamServices.currentdata["sport"]["macro_status"] == false){
                    _routes.navigator_push(context, subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloSportMainPage() : SportMainPage());
                  }else{
                    // ALIMENTATION
                    if(subStreamServices.currentdata["food_preference"] == null){
                      _routes.navigator_push(context, subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloEatingMainPage() : EatingMainPage());
                    }else if(subStreamServices.currentdata["food_preference"]["macro_status"] == false){
                      _routes.navigator_push(context, subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? PackSoloEatingMainPage() : EatingMainPage());
                    }else{
                      _routes.navigator_push(context, FormCompleted());
                    }
                  }
                }
              }
            });
          },bckgrndColor: AppColors.appmaincolor, textColor: Colors.white,radius: 10),
          Divider(),
          SizedBox(
           height: 10,
          ),
          ParameterPage(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
