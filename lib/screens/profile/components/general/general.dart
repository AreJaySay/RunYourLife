import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/profile/components/general/components/form_design.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../models/subscription_models/step1_subs.dart';
import '../../../../services/stream_services/subscriptions/subscription_details.dart';

class ProfileGeneral extends StatefulWidget {
  final Map formInfo;
  ProfileGeneral({required this.formInfo});
  @override
  _ProfileGeneralState createState() => _ProfileGeneralState();
}

class _ProfileGeneralState extends State<ProfileGeneral> {
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Auth.loggedUser == null ? Center(child: CircularProgressIndicator(
        color: AppColors.appmaincolor,strokeWidth: 2.5,
      )) : ListView(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
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
                      Text(widget.formInfo["client_info"].toString() == "null" ? "--" : widget.formInfo["client_info"]["gender"].toString() == "null" ? "--" : widget.formInfo["client_info"]["gender"].toString() == "Male" ? "Homme" : "Femme", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Date de naissance",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.formInfo["client_info"].toString() == "null" ? "--" : widget.formInfo["client_info"]["birth_date"].toString() == "null" ? "--" : "${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.formInfo["client_info"]["birth_date"].toString()))} (${int.parse(DateTime.now().year.toString()) - int.parse(DateFormat("yyyy").format(DateTime.parse(widget.formInfo["client_info"]["birth_date"].toString())))} ans)", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),),
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
                      Text("Phone",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),),
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
          Container(
            padding: EdgeInsets.only(left: 20,right: 20,top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                FormDesign(title: "Préférence alimentaire",formInfo: widget.formInfo["food_preference"] == null ? {} : widget.formInfo["food_preference"],),
                subscriptionDetails.currentdata[0]["plan_id"] == 1 ? Container() : FormDesign(title: "Antécédents médicaux",formInfo: widget.formInfo["medical_history"] == null ? {} : widget.formInfo["medical_history"],),
                FormDesign(title: "Objectif",formInfo: widget.formInfo["goal"] == null ? {} : widget.formInfo["goal"],),
                FormDesign(title: "Pratique de sport",formInfo: widget.formInfo["sport"] == null ? {} : widget.formInfo["sport"],),
                subscriptionDetails.currentdata[0]["plan_id"] == 1 ? Container() : FormDesign(title: "Stress",formInfo: widget.formInfo["stress"] == null ? {} : widget.formInfo["stress"],),
                subscriptionDetails.currentdata[0]["plan_id"] == 1 ? Container() : FormDesign(title: "Sommeil",formInfo: widget.formInfo["sleep"] == null ? {} : widget.formInfo["sleep"],),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
