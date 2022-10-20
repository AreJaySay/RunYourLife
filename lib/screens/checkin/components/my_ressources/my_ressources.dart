import 'dart:io';

import 'package:flutter/material.dart';
import 'package:run_your_life/screens/checkin/components/my_ressources/components/components/shimmer_loader.dart';
import 'package:run_your_life/screens/checkin/components/my_ressources/components/documents.dart';
import 'package:run_your_life/screens/checkin/components/my_ressources/components/url.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/stream_services/screens/checkin.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'components/all_ressources.dart';
import 'components/images.dart';
import 'components/videos.dart';

class MyRessources extends StatefulWidget {
  @override
  _MyRessourcesState createState() => _MyRessourcesState();
}

class _MyRessourcesState extends State<MyRessources> with SingleTickerProviderStateMixin {
  final CheckinServices _checkinServices = new CheckinServices();
  final AppBars _appBars = new AppBars();
  TabController? _controller;
  TextEditingController textController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    _checkinServices.getResources(context);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 170) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    _controller = new TabController(length: 5, vsync: this);
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
      stream: checkInStreamServices.ressources,
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
                                        Text("MES LECTURES DE LA SEMAINE",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                                      ],
                                    ),
                                    height: 80,
                                  ),
                                ),
                              )
                          ),
                          SliverPadding(
                            padding:  EdgeInsets.only(top: 10,bottom: 5,),
                            sliver: SliverList(
                              delegate: new SliverChildListDelegate([
                                TabBar(
                                  padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                                  labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "AppFontStyle"),
                                  unselectedLabelStyle:  TextStyle(fontWeight: FontWeight.normal,fontFamily: "AppFontStyle"),
                                  unselectedLabelColor: Colors.grey,
                                  indicatorColor: AppColors.appmaincolor,
                                  labelColor: AppColors.appmaincolor,
                                  indicatorWeight: 6,
                                  tabs: <Widget>[
                                    Tab(
                                      text: "Toutes",
                                    ),
                                    Tab(
                                      text: "Image",
                                    ),
                                    Tab(
                                      text: "Video",
                                    ),
                                    Tab(
                                      text: "Lien",
                                    ),
                                    Tab(
                                      text: "Document",
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        children: <Widget>[
                          !snapshot.hasData ?
                          RessourceShimmerLoader() :
                          AllRessources(ressources: snapshot.data!,),

                          !snapshot.hasData ?
                          RessourceShimmerLoader() :
                          MyRessourcesImages(images: snapshot.data!.where((s) => s["documents"]["file_type"] == "image/jpeg").toList(),),

                          !snapshot.hasData ?
                          RessourceShimmerLoader() :
                          MyRessourcesVideos(videos: snapshot.data!.where((s) => s["documents"]["file_type"] == "video/mp4").toList(),),

                          !snapshot.hasData ?
                          RessourceShimmerLoader() :
                          MyRessourcesUrl(url: snapshot.data!.where((s) => s["documents"]["file_type"] == "link/url").toList(),),

                          !snapshot.hasData ?
                          RessourceShimmerLoader() :
                          MyRessourcesDocs(docs: snapshot.data!.where((s) => s["documents"]["file_type"] == "application/pdf").toList(),),
                        ],
                      )
                  ),
                ),
              ),
            ],
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
