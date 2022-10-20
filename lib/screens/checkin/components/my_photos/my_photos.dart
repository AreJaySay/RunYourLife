import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/screens/checkin/photos.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/add_photos.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/gridview_design.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/shimmer_loader.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/stream_services/screens/checkin.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:intl/intl.dart';

class MyPhotos extends StatefulWidget {
  @override
  _MyPhotosState createState() => _MyPhotosState();
}

class _MyPhotosState extends State<MyPhotos> with SingleTickerProviderStateMixin {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final Materialbutton _materialbutton = new Materialbutton();
  final CheckinServices _checkinServices = new CheckinServices();
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  TabController? _controller;
  bool isVisible = true;
  ScrollController _scrollController = new ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    _checkinServices.getPhotos(context);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 120) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    _controller = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: checkInStreamServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          body: DefaultTabController(
              length: 4,
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
                            expandedHeight: 80,
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
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: Platform.isAndroid ? Icon(Icons.arrow_back,color:AppColors.pinkColor,size: 22,) :  Icon(Icons.arrow_back_ios_sharp,color: AppColors.pinkColor,size: 22,),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(1000)
                                          ),
                                        ),
                                        onTap: (){
                                          Navigator.of(context).pop(null);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("MES PHOTOS",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                                    ],
                                  ),
                                  height: 80,
                                ),
                              ),
                            )
                        ),
                        SliverPadding(
                          padding:  EdgeInsets.only(top: 30,bottom: 5,),
                          sliver: new SliverList(
                            delegate: new SliverChildListDelegate([
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 55,
                                child: _materialbutton.materialButton("AJOUTER UNE PHOTO", () {
                                  _routes.navigator_push(context, AddPhotos(), transitionType: PageTransitionType.rightToLeftWithFade);
                                },radius: 1000, bckgrndColor: AppColors.pinkColor),
                              ),
                              TabBar(
                                padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                                isScrollable: true,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,fontFamily: "AppFontStyle"),
                                unselectedLabelStyle: TextStyle(
                                    fontWeight: FontWeight.normal,fontFamily: "AppFontStyle"),
                                unselectedLabelColor: Colors.grey,
                                controller: _controller,
                                indicatorColor: AppColors.appmaincolor,
                                labelColor: AppColors.appmaincolor,
                                labelPadding: EdgeInsets.symmetric(horizontal: 18),
                                indicatorWeight: 6,
                                tabs: <Widget>[
                                  Tab(
                                    text: "Toutes",
                                  ),
                                  Tab(
                                    text: "#Body",
                                  ),
                                  Tab(
                                    text: "#Food",
                                  ),
                                  Tab(
                                    text: "#Sport",
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        if(!snapshot.hasData)...{
                          for(int x = 0; x < 4; x++)...{
                            PhotosShimmerLoader()
                          }
                        }else...{
                          snapshot.data!.isEmpty ?
                          NoDataFound(firstString: "PAS DE PHOTO ", secondString: "TROUVÉE ICI...", thirdString: "Vous n'avez pas encore ajouté de photo.") :
                          GridViewDesign(photos: snapshot.data!,),
                          GridViewDesign(photos: snapshot.data!.where((s) => s["taggable"].toString().contains("body")).toList(),),
                          GridViewDesign(photos: snapshot.data!.where((s) => s["taggable"].toString().contains("food")).toList(),),
                          GridViewDesign(photos: snapshot.data!.where((s) => s["taggable"].toString().contains("sport")).toList(),),
                        },
                      ],
                    )
                ),
              ),
            ),
            floatingActionButton: _showBackToTopButton == false
            ? null
                : FloatingActionButton(
            backgroundColor: AppColors.appmaincolor,
            onPressed: _scrollToTop,
            child: Icon(Icons.arrow_upward),
            ),
        );
      }
    );
  }
}
