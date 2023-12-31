import 'dart:io';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/models/screens/blog/blog.dart';
import 'package:run_your_life/screens/blog/articles.dart';
import 'package:run_your_life/screens/blog/page_loader/placeholder.dart';
import 'package:run_your_life/screens/blog/page_loader/shimmer.dart';
import 'package:run_your_life/screens/messages/messages.dart';
import 'package:run_your_life/services/apis_services/screens/blogs.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/blogs.dart';
import 'package:run_your_life/services/stream_services/screens/favorites.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import '../../models/auths_model.dart';
import '../../models/device_model.dart';
import '../../services/stream_services/subscriptions/subscription_details.dart';
import '../../widgets/message_notifier.dart';
import '../../widgets/notification_notifier.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> with SingleTickerProviderStateMixin {
  final BlogServices _blogServices = new BlogServices();
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  TextEditingController _search = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  List<Tab> _tabs = [Tab(text: "Derniers articles",), Tab(text: "Recettes",), Tab(text: "Lifestyle",), Tab(text: "Nutrition",),Tab(text: "Mes favoris",)];
  bool _showBackToTopButton = false;
  String _tabartitle = "Article";
  bool _keyboardVisible = false;
  List? _searchData;
  int _total = 0;
  bool _isAllLoading = false;
  bool _isRecettesLoading = false;
  bool _isLifestyleLoading = false;
  bool _isNutritionLoading = false;

  @override
  void initState() {
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
    KeyboardVisibilityController().onChange.listen((event) {
      setState(() {
        _keyboardVisible = event;
      });
    });
    _isAllLoading = true;
    _isRecettesLoading = true;
    _isLifestyleLoading = true;
    _isNutritionLoading = true;
    _blogServices.getblogs(page: "1").then((total){
      _total = total;
      _searchData = blogStreamServices.currentdata;
      setState(() {
        _isAllLoading = false;
      });
    });
    _blogServices.getBlogCategory(category_id: "1").then((value){
      blogStreamServices.updateRecettes(data: value);
      setState(() {
        _isRecettesLoading = false;
      });
    });
    _blogServices.getBlogCategory(category_id: "2").then((value){
      blogStreamServices.updateLifestyle(data: value);
      setState(() {
        _isLifestyleLoading = false;
      });
    });
    _blogServices.getBlogCategory(category_id: "3").then((value){
      blogStreamServices.updateNutrition(data: value);
      setState(() {
        _isNutritionLoading = false;
      });
    });
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
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: StreamBuilder<List>(
        stream:  blogStreamServices.subject,
        builder: (context, snapshot) {
          return Scaffold(
            body: DefaultTabController(
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
                          expandedHeight: 60.0,
                          shadowColor: Colors.red,
                          automaticallyImplyLeading: false,
                          flexibleSpace: Container(
                            decoration: BoxDecoration(
                              gradient: AppGradientColors.gradient,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(5.0,3.5,
                                  ),
                                )
                              ],
                            ),
                            child: SafeArea(
                              child: Center(
                                  child: Auth.isNotSubs! ? Image(
                                  color: Colors.white,
                                  width: 85,
                                  image: AssetImage("assets/important_assets/logo_new_white.png"),
                                ) : Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text("BLOG", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white, fontFamily: "AppFontStyle"),),
                                      Spacer(),
                                      NotificationNotifier(),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      MessageNotifier()
                                    ],
                                  ),
                                )),
                            ),
                          )),
                        SliverPadding(
                          padding: new EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                          sliver: new SliverList(
                            delegate: new SliverChildListDelegate([
                              EasyAutocomplete(
                                controller: _search,
                                suggestions: [
                                  if(snapshot.hasData)...{
                                    for(int x = 0; x < snapshot.data!.length; x++)...{
                                      snapshot.data![x]['title'].toString()
                                    }
                                  }
                                ],
                                cursorColor: AppColors.appmaincolor,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search,color: AppColors.appmaincolor,),
                                    suffixIcon: _search.text.isEmpty ? null : IconButton(
                                      icon: Icon(Icons.close,color: AppColors.appmaincolor,),
                                      onPressed: (){
                                        setState(() {
                                          _search.text = "";
                                          blogStreamServices.updateBlogs(data: _searchData!);
                                        });
                                      },
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "Rechercher ${_tabartitle}",
                                    hintStyle: TextStyle(color: Colors.grey[400],fontFamily: "AppFontStyle",fontWeight: FontWeight.normal),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1000),
                                        borderSide: BorderSide(
                                            color: AppColors.appmaincolor,
                                            style: BorderStyle.solid
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1000),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            style: BorderStyle.solid
                                        )
                                    ),
                                ),
                                onChanged: (value){
                                  setState(() {
                                    if(_search.text.isEmpty){
                                      blogStreamServices.updateBlogs(data: _searchData!);
                                    }else{
                                      blogStreamServices.updateBlogs(data: _searchData!.where((s){
                                        return s["title"].toString().toLowerCase().contains(value.toLowerCase());
                                      }).toList());
                                    }
                                  });
                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TabBar(
                                isScrollable: DeviceModel.isMobile ? true : false,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "AppFontStyle",
                                    fontSize: 15),
                                unselectedLabelStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "AppFontStyle",
                                    fontSize: 15),
                                unselectedLabelColor: Colors.grey,
                                padding: EdgeInsets.zero,
                                indicatorColor: AppColors.appmaincolor,
                                labelColor: AppColors.appmaincolor,
                                indicatorWeight: 6,
                                tabs: <Widget>[
                                  for(int x = 0; x < _tabs.length; x++)...{
                                    _tabs[x]
                                  },
                                ],
                                onTap: (value){
                                  setState(() {
                                    if(value == 0){
                                      _tabartitle = "Article";
                                    }else{
                                      _tabartitle = _tabs[value].text.toString();
                                    }
                                  });
                                },
                              )
                            ]),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            _isAllLoading ?
                            BlogShimmerLoader() :
                            Articles(article: snapshot.data!,index: 0,total: _total,),

                            _isRecettesLoading ?
                            BlogShimmerLoader() :
                            Articles(article: blogStreamServices.currentRecettes,index: 1,total: _total),

                            _isLifestyleLoading ?
                            BlogShimmerLoader() :
                            Articles(article: blogStreamServices.currentLifestyle,index: 2,total: _total),

                            _isNutritionLoading ?
                            BlogShimmerLoader() :
                            Articles(article: blogStreamServices.currentNutrition,index: 3,total: _total),

                            !favoriteStreamServices.subject.hasValue?
                            BlogShimmerLoader() :
                            Articles(article: favoriteStreamServices.currentdata,index: 4,total: _total, isFavorite: true,),

                          ],
                        ),
                ),
              ),
            ),
            floatingActionButton: _showBackToTopButton == false ? null
                : FloatingActionButton(
                    backgroundColor: AppColors.appmaincolor,
                    onPressed: _scrollToTop,
                    child: Icon(Icons.arrow_upward),
                  ),
          );
        }
      ),
    );
  }
}
