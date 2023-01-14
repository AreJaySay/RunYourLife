   import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/services/stream_services/screens/blogs.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:run_your_life/screens/blog/components/view_article.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../widgets/cache_network_image.dart';
import 'package:intl/intl.dart';

import '../../functions/loaders.dart';
import '../../models/screens/blog/blog.dart';
import '../../services/apis_services/screens/blogs.dart';
import '../../services/stream_services/screens/favorites.dart';

class Articles extends StatefulWidget {
  final List article;
  final int index,total;
  Articles({required this.article, required this.index, required this.total});
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final CacheNetworkImages _cachedNetworkImage = new CacheNetworkImages();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Routes _routes = new Routes();
  final BlogServices _blogServices = new BlogServices();
  int _page = 1;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blogServices.get_favorites();
  }

  @override
  Widget build(BuildContext context) {
    return widget.article.isEmpty ?
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      child: NoDataFound(firstString: "C'EST ", secondString: "CALME PAR ICI...", thirdString: "Il n'y a encore rien à trouver ici !",),
    ) :
    NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification){
        if(scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent){
          setState(() {
            if(widget.article.length < widget.total){
              _isLoading = true;
              _page += 1 ;
              _blogServices.getblogs(page: _page.toString(), isPaginate: true).whenComplete((){
                setState(() {
                  _isLoading = false;
                });
              });
            }
          });
        }
        return true;
      },
      child: Stack(
        children: [
          GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: DeviceModel.isMobile ? 2 : 3,
                childAspectRatio: DeviceModel.isMobile ? (1 / 1.45) : (1 / 1.23),
              ),
              itemCount: widget.article.length,
              itemBuilder: (BuildContext context, int index) {
                return ZoomTapAnimation(end: 0.99,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: DeviceModel.isMobile ? 150 : 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: _cachedNetworkImage.cacheNetwork(image: widget.article[index]['image'],radius: 10),
                            ),
                            widget.index == 4 ?
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  child: Padding(
                                    padding: EdgeInsets.all(3),
                                    child:  Icon(Icons.highlight_remove,color: AppColors.pinkColor,size: 30,),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      // _screenLoaders.functionLoader(context);
                                      _blogServices.add_favorite(context, id: widget.article[index]["id"].toString()).whenComplete((){
                                        _blogServices.get_favorites();
                                      });
                                      widget.article.removeWhere((s) => s["id"].toString() == widget.article[index]["id"].toString());
                                    });
                                  },
                                )
                              )
                              : Container(
                              padding: EdgeInsets.all(10),
                              height: DeviceModel.isMobile ? 150 : 200,
                              alignment: Alignment.topLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.pinkColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                child: Text(widget.article[index]['category']["name"].toString(),style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),),
                              )
                            ),
                            widget.index != 4 ? Container() :
                            Container(
                              height: DeviceModel.isMobile ? 150 : 200,
                              width: double.infinity,
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                decoration: BoxDecoration(
                                    color: AppColors.pinkColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text(widget.article[index]['category']["name"].toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: "AppFontStyle"),),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        widget.index != 4 ? Container() : SizedBox(
                          height: 5,
                        ),
                        Text(widget.article[index]['title'].toString().toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        Spacer(),
                        Text("par ${widget.article[index]['coach']["full_name"].toString()}",style: TextStyle(color: Colors.grey,fontSize: 13,fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 2,
                        ),
                        Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.article[index]['created_at'].toString())),style: TextStyle(color: AppColors.pinkColor,fontSize: 12,fontFamily: "AppFontStyle"),),
                        // Text("0 commentaires",style: TextStyle(color: Colors.grey,fontSize: 12,fontFamily: "AppFontStyle"),),
                      ],
                    ),
                  ),
                  onTap: (){
                    _routes.navigator_push(context, ViewArticle(articledetails: widget.article[index],), transitionType: PageTransitionType.bottomToTop);
                  },
                );
              }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.only(bottom: 10),
              height: _isLoading ? 50 : 0,
              width: double.infinity,
              alignment: Alignment.center,
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(color: AppColors.appmaincolor,strokeWidth: 3,),
              )
              // child: Align(
              //   alignment: Alignment.bottomCenter,
              //   child: SizedBox(
              //     width: 30,
              //     height: _isLoading ? 30 : 0,
              //     child: CircularProgressIndicator(color: AppColors.appmaincolor,),
              //   )
              // ),
            ),
          )
        ],
      ),
    );
  }
}
