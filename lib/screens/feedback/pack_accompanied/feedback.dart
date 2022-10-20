import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:run_your_life/models/screens/feedback/feedback.dart';
import 'package:run_your_life/screens/feedback/components/coach/listview_widget.dart';
import 'package:run_your_life/screens/feedback/components/shimmer_loader.dart';
import 'package:run_your_life/screens/feedback/pack_accompanied/schedule_call.dart';
import 'package:run_your_life/screens/messages/messages.dart';
import 'package:run_your_life/services/apis_services/screens/feedback.dart';
import 'package:run_your_life/services/stream_services/screens/feedback.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import '../../../services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../widgets/materialbutton.dart';
import '../../../widgets/message_notifier.dart';
import '../../../widgets/notification_notifier.dart';

class PackAccompaniedFeedBack extends StatefulWidget {
  @override
  _PackAccompaniedFeedBackState createState() => _PackAccompaniedFeedBackState();
}

class _PackAccompaniedFeedBackState extends State<PackAccompaniedFeedBack> with SingleTickerProviderStateMixin {
  final Materialbutton _materialbutton = new Materialbutton();
  final FeedbackServices _feedbackServices = new FeedbackServices();
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _feedbackServices.getFeedback().then((value){
      for(int x = 0; x < value.length; x++){
        if(DateTime.now().difference(DateTime.parse(value[x]["created_at"])).inDays <= 7){
          print("WEEK 1 ${value[x].toString()}");
          if(!coachFeedBack.currentWeek.toString().contains(value[x].toString())){
            coachFeedBack.currentWeek.add(value[x]);
          }
        }else if(DateTime.now().difference(DateTime.parse(value[x]["created_at"])).inDays > 7 && DateTime.now().difference(DateTime.parse(value[x]["created_at"])).inDays <= 14){
          if(!coachFeedBack.lastWeek.toString().contains(value[x].toString())){
            print("WEEK 2 ${value[x].toString()}");
            coachFeedBack.lastWeek.add(value[x]);
          }
        }else{
          print("WEEK 3 ${value[x].toString()}");
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
                              delegate: new SliverChildListDelegate([
                                SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    width: double.infinity,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        color: AppColors.pinkColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("PROGRAMMER UN POINT HEBDO",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)),
                                  ),
                                  onTap: (){
                                    _routes.navigator_push(context, ScheduleCall());
                                  },
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
                          if(!snapshot.hasData)...{
                            FeedbackShimmerLoader()
                          }else if(snapshot.data!.isEmpty)...{
                            Container(
                              width: double.infinity,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("C'EST ",style: TextStyle(fontSize: 16,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                      Text("CALME PAR ICI...",style: TextStyle(fontSize: 16,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text("Bientôt des feedbacks de votre coach !",style: TextStyle(fontSize: 15.5,color: Colors.black,fontFamily: "AppFontStyle"),),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            )
                          }else...{
                            // CURRENT WEEK
                            if(coachFeedBack.currentWeek.isNotEmpty)...{
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("SEMAINE",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                  Text(" EN COURS",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                ],
                              ),
                              for(var x = 0; x < coachFeedBack.currentWeek.length; x++)...{
                                SizedBox(
                                    height: 10
                                ),
                                CoachListViewWidget(coachFeedBack.currentWeek[coachFeedBack.currentWeek.length - x - 1]),
                              }
                            },
                            // LAST WEEK
                            if(coachFeedBack.lastWeek.isNotEmpty)...{
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("SEMAINE",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                  Text(" DERNIERE",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                ],
                              ),
                              for(var x = 0; x < coachFeedBack.lastWeek.length; x++)...{
                                SizedBox(
                                    height: 10
                                ),
                                CoachListViewWidget(coachFeedBack.lastWeek[coachFeedBack.lastWeek.length - x - 1]),
                              }
                            },
                            if(coachFeedBack.otherWeek.isNotEmpty)...{
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("AUTRES",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                  Text(" SEMAINES PASSÉES",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                ],
                              ),
                              for(var x = 0; x < coachFeedBack.otherWeek.length; x++)...{
                                SizedBox(
                                    height: 10
                                ),
                                CoachListViewWidget(coachFeedBack.otherWeek[coachFeedBack.otherWeek.length - x - 1]),
                              }
                            },
                          },
                          SizedBox(
                            height: 20,
                          )
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
