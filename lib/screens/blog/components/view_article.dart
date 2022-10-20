import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:run_your_life/functions/html_parser.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/blog/blog.dart';
import 'package:run_your_life/services/apis_services/screens/blogs.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/blogs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import '../../../../../widgets/backbutton.dart';
import 'components/associate.dart';

class ViewArticle extends StatefulWidget {
  final Map articledetails;
  final bool isRelated;
  ViewArticle({required this.articledetails, this.isRelated = true});
  @override
  _ViewArticleState createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  final BlogServices _blogServices = new BlogServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final HtmlParsers _htmlParsers = new HtmlParsers();
  final Routes _routes = new Routes();
  ScrollController scrollController = new ScrollController();
  bool _showBackToTopButton = false;

  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Run Your Life Blog',
        text: widget.articledetails["title"],
        linkUrl: 'https://dev-front.runyourlife.checkmy.dev/blog/${widget.articledetails["id"].toString()}/shared_preview',
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (scrollController.offset >= 200) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: DeviceModel.isMobile ? 250 : 300,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.articledetails["image"])
                  )
              ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
              child: new Container(
                decoration: new BoxDecoration(color:Colors.black.withOpacity(0.2)),
              ),
            ),
            ),
            ListView(
              physics: new ClampingScrollPhysics(),
              controller: scrollController,
              padding: EdgeInsets.all(0),
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height:  DeviceModel.isMobile ? 240 : 280,
                  width: double.infinity,
                  child: SafeArea(
                    child: PageBackButton()
                  ),
                ),
                 Container(
                   padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.only(
                           topRight: Radius.circular(DeviceModel.isMobile ? 15 : 20),
                           topLeft: Radius.circular(DeviceModel.isMobile ? 15 : 20)
                       )
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Expanded(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(widget.articledetails["title"].toString().toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: "AppFontStyle")),
                                 SizedBox(
                                   height: 10,
                                 ),
                                 Text("${DateFormat.yMMMd("fr").format(DateTime.parse(widget.articledetails['created_at'].toString()))}  \npar ${widget.articledetails['coach']["full_name"].toString()}",style: TextStyle(fontSize: 14,fontFamily: "AppFontStyle",color: Colors.grey),),
                                 SizedBox(
                                   height: 40,
                                 ),
                                 Text(widget.articledetails['summary'].toString().toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",color: Colors.black54),),
                               ],
                             ),
                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               InkWell(
                                 child: Container(
                                   width: 55,
                                   height: 55,
                                   decoration: BoxDecoration(
                                     color: AppColors.pinkColor,
                                     borderRadius: BorderRadius.circular(1000),
                                   ),
                                   child: Center(
                                     child: blogModel.favorites.toString().contains("id: ${widget.articledetails["id"].toString()}") ? Icon(Icons.favorite,color: Colors.white,size: 30,): Icon(Icons.favorite_border_rounded,color: Colors.white,size: 30,),
                                   ),
                                 ),
                                 onTap: (){
                                   setState(() {
                                     _screenLoaders.functionLoader(context);
                                     _blogServices.add_favorite(context, id: widget.articledetails["id"].toString()).then((value){
                                       if(value != null){
                                         _blogServices.get_favorites().then((value){
                                           setState((){
                                             blogModel.favorites = value;
                                             Navigator.of(context).pop();
                                           });
                                         });
                                       }else{
                                         Navigator.of(context).pop();
                                       }
                                     });
                                   });
                                 },
                               ),
                               SizedBox(
                                 height: 10,
                               ),
                               InkWell(
                                 child: Container(
                                   width: 55,
                                   height: 55,
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(1000),
                                     border: Border.all(color: AppColors.appmaincolor)
                                   ),
                                   child: Center(
                                     child: Icon(Icons.share,color: AppColors.appmaincolor,size: 30,),
                                   ),
                                 ),
                                 onTap: ()async{
                                   await share();
                                 },
                               )
                             ],
                           )
                         ],
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       Html(
                         data: widget.articledetails['content'].toString().replaceAll("<br>", ""),
                       ),
                       // Text(_htmlParsers.parseHtmlString(widget.articledetails['content']),style: TextStyle(fontSize: 15,fontFamily: "AppFontStyle"),),
                       SizedBox(
                         height: 30,
                       ),
                     ],
                   ),
                 ),
                widget.isRelated ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Article(s) associé(s)",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontSize: 16.5,fontFamily: "AppFontStyle"),),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 280,
                      width: double.infinity,
                      child: ArticlesAssociate(related: blogStreamServices.currentdata.where((s) => s["category_id"] == widget.articledetails['category_id']).toList(),),
                    ),
                  ],
                ) : Container(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
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

}
