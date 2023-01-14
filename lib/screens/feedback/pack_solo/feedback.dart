import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/screens/feedback/pack_solo/weekly_update.dart';
import 'package:run_your_life/screens/messages/messages.dart';
import 'package:run_your_life/services/apis_services/screens/feedback.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/notification_notifier.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../models/screens/feedback/feedback.dart';
import '../../../services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../services/stream_services/screens/feedback.dart';

import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/message_notifier.dart';
import '../components/coach/listview_widget.dart';
import '../components/shimmer_loader.dart';

class PackSoloFeedback extends StatefulWidget {
  @override
  State<PackSoloFeedback> createState() => _PackSoloFeedbackState();
}

class _PackSoloFeedbackState extends State<PackSoloFeedback> {
  final List<String> _firstchar = ["CETTE","LA","LA"];
  final List<String> _secondchar = ["SEMAINE","DERNIÈRE","SEMAINE DY 11/04"];
  final FeedbackServices _feedbackServices = new FeedbackServices();
  final Routes _routes = new Routes();
  final HomeServices _homeServices = new HomeServices();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _homeServices.getSchedule();
    _feedbackServices.getTime(date: DateFormat("yyyy-MM-dd","fr").format(DateTime.now().toUtc().add(Duration(hours: 2))), coach_id: subscriptionDetails.currentdata[0]['coach_id'].toString());
    _feedbackServices.getFeedback().then((value){
      for(int x = 0; x < value.length; x++){
        if(DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays <= 7){
          if(!coachFeedBack.currentWeek.toString().contains(value[x].toString())){
            coachFeedBack.currentWeek.add(value[x]);
          }
        }else if(DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays > 7 && DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays <= 14){
          if(!coachFeedBack.lastWeek.toString().contains(value[x].toString())){
            coachFeedBack.lastWeek.add(value[x]);
          }
        }else{
          if(!coachFeedBack.otherWeek.toString().contains(value[x].toString())){
            coachFeedBack.otherWeek.add(value[x]);
          }
        }
      }
    });
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: feedbackStreamServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          body: Stack(
            children: [
              Image(
                width: double.infinity,
                fit: BoxFit.cover,
                image: AssetImage("assets/important_assets/heart_icon.png"),
              ),
              DefaultTabController(
                length: 5,
                child: AbsorbPointer(
                  absorbing: false,
                  child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                              pinned: false,
                              backgroundColor: AppColors.appmaincolor,
                              snap: false,
                              floating: true,
                              expandedHeight: 56.0,
                              automaticallyImplyLeading: false,
                              flexibleSpace: Container(
                                decoration: BoxDecoration(
                                  gradient: AppGradientColors.gradient,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 3.0, // has the effect of softening the shadow
                                      spreadRadius: 1.0, // has the effect of extending the shadow
                                      offset: Offset(
                                        5.0, // horizontal, move right 10
                                        3.5, // vertical, move down 10
                                      ),
                                    )
                                  ],
                                ),
                                child: SafeArea(
                                  child: Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          children: [
                                            Text("FEEDBACK",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,fontFamily: "AppFontStyle"),),
                                            Spacer(),
                                            NotificationNotifier(),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            MessageNotifier()
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              )
                          ),
                          SliverPadding(
                            padding:  EdgeInsets.only(bottom: 5,),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                SizedBox(
                                  height: 30,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      width: double.infinity,
                                      alignment: Alignment.bottomRight,
                                      child: Image(
                                        image: AssetImage("assets/icons/lock.png"),
                                        width: 50,
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      width: double.infinity,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("PROCHAIN RENDEZ-VOUS",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                            ),
                          ),
                        ];
                      },
                      body: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          if(!snapshot.hasData)...{
                            FeedbackShimmerLoader()
                          }else if(snapshot.data!.isEmpty)...{
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text("Cet abonnement ne vous permet pas d'obtenir un feedback de votre coach. Cependant, vous pouvez vous rendre sur la page de votre profil en bas de page et mettre à niveau votre abonnement pour que le mois prochain vous puissiez bénéficier d'un suivi 100% personnalisé et d'un contact permanent avec un coach !",style: TextStyle(fontSize: 15.5,color: Colors.black,fontFamily: "AppFontStyle"),textAlign: TextAlign.center,)),
                            ),
                          }else...{
                            // CURRENT WEEK
                            if(coachFeedBack.currentWeek.isNotEmpty)...{
                              Row(
                                children: [
                                  Text("SEMAINE",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                  Text(" EN COURS",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                ],
                              ),
                              for(var x = 0; x < coachFeedBack.currentWeek.length; x++)...{
                                SizedBox(
                                    height: 17
                                ),
                                CoachListViewWidget(coachFeedBack.currentWeek[x],isMacroSolo: true,),
                              }
                            },
                            // LAST WEEK
                            if(coachFeedBack.lastWeek.isNotEmpty)...{
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                children: [
                                  Text("SEMAINE",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                  Text(" DERNIERE",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                ],
                              ),
                              for(var x = 0; x < coachFeedBack.lastWeek.length; x++)...{
                                SizedBox(
                                    height: 17
                                ),
                                CoachListViewWidget(coachFeedBack.lastWeek[x],isMacroSolo: true,),
                              }
                            },
                            if(coachFeedBack.otherWeek.isNotEmpty)...{
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                children: [
                                  Text("AUTRES",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                  Text(" SEMAINES PASSÉES",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                ],
                              ),
                              for(var x = 0; x < coachFeedBack.otherWeek.length; x++)...{
                                SizedBox(
                                    height: 17
                                ),
                                CoachListViewWidget(coachFeedBack.otherWeek[x],isMacroSolo: true,),
                              }
                            },
                          }
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}