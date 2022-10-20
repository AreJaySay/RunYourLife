import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/coaching/components/enter_card.dart';
import 'package:run_your_life/screens/coaching/page_loader/shimmer.dart';
import 'package:run_your_life/services/apis_services/screens/coaching.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/coaching.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/delayed.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../checkin/components/my_photos/components/add_photo_components/components/add_tag.dart';
import 'components/view_details.dart';

class Coaching extends StatefulWidget {
  @override
  _CoachingState createState() => _CoachingState();
}

class _CoachingState extends State<Coaching> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  final CoachingServices _coachingServices = new CoachingServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coachingServices.getplans();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: coachingStreamServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          appBar:  _appBars.preferredSize(height: 70,logowidth: 95),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: !snapshot.hasData ?
            CoachingShimmerLoader() :
            ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child: Text("LES ABONNEMENTS",style: TextStyle(color: AppColors.appmaincolor,fontSize: 22,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                ),
                ZoomTapAnimation(end: 0.99,
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20,bottom: 25),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 3.0, // has the effect of softening the shadow
                          spreadRadius: 1.0, // has the effect of extending the shadow
                          offset: Offset(
                            0.0, // horizontal, move right 10
                            1.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                           width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text("PACK",style: TextStyle(color: AppColors.pinkColor,fontSize: 17.5,fontFamily: "AppFontStyle"),),
                                Expanded(child: Text(" ${snapshot.data![0]["name"]}".toString().toUpperCase(),style: TextStyle(color: AppColors.pinkColor,fontSize: 17.5,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            padding: EdgeInsets.only(left: 20,right: 20,top: 30)
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                          child: Text(snapshot.data![0]["description"].toString(),maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.pinkColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(10)
                                )
                            ),
                            child: snapshot.data![snapshot.data!.length - 1]["prices"].toString() == "[]" ? Container() : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(snapshot.data![snapshot.data!.length - 1]["prices"][snapshot.data![snapshot.data!.length - 1]["prices"].length - 1]['price'].toString()+"€",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                                Text("/mois",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                        isScrollControlled: true,
                        context: context, builder: (context){
                      return EnterCreditCard(title: "S'ABONNER À MACRO SOLO",details: snapshot.data![0],);
                    });
                  },
                ),
                ZoomTapAnimation(end: 0.99,
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: AppGradientColors.gradient,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 3.0, // has the effect of softening the shadow
                          spreadRadius: 1.0, // has the effect of extending the shadow
                          offset: Offset(
                            0.0, // horizontal, move right 10
                            1.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        Image(
                          color: Colors.white,
                          width: double.infinity,
                          alignment: Alignment.topRight,
                          image: AssetImage("assets/important_assets/coaching_back.png"),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text("PACK",style: TextStyle(color: Colors.white,fontSize: 17.5,fontFamily: "AppFontStyle"),),
                                    Expanded(child: Text(" ${snapshot.data![1]["name"]}".toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 17.5,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"))),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                padding: EdgeInsets.only(left: 20,right: 20,top: 30)
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                              child: Text(snapshot.data![1]["description"].toString(),style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: double.infinity,
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(10)
                                    )
                                ),
                                child: snapshot.data![1]["prices"].toString() == "[]" ? Container() : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(snapshot.data![1]["prices"][snapshot.data![1]["prices"].length - 1]['price'].toString()+"€",style: TextStyle(color: AppColors.appmaincolor,fontSize: 19,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                                    Text("/mois",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                        isScrollControlled: true,
                        context: context, builder: (context){
                      return EnterCreditCard(title: "S'ABONNER À 100% D'ACCOMPAGNEMENT",details: snapshot.data![1],);
                    });
                    // _routes.navigator_push(context, ViewCoachingDetails(snapshot.data![1]));
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Pas de minimum d'engagement",style: TextStyle(color: Colors.grey[500],fontFamily: "AppFontStyle",fontSize: 15),),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Prix préferentiel via le site internet",style: TextStyle(color: Colors.grey[500],fontFamily: "AppFontStyle",fontSize: 15),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
