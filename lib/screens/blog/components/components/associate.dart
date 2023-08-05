import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../../../../widgets/delayed.dart';
import '../../../../services/stream_services/screens/blogs.dart';
import '../../../../widgets/cache_network_image.dart';
import '../view_article.dart';

class ArticlesAssociate extends StatefulWidget {
  final List related;
  final Map coach;
  ArticlesAssociate({required this.related, required this.coach});
  @override
  _ArticlesAssociateState createState() => _ArticlesAssociateState();
}

class _ArticlesAssociateState extends State<ArticlesAssociate> {
  final Routes _routes = new Routes();
  final CacheNetworkImages _cachedNetworkImage = new CacheNetworkImages();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      scrollDirection: Axis.horizontal,
      itemCount: widget.related.length,
      itemBuilder: (context,index){
        return InkWell(
          child: Container(
            height: 270,
            width: 160,
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
                      child: _cachedNetworkImage.cacheNetwork(image: widget.related[index]['article']["image"],radius: 10),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        height: DeviceModel.isMobile ? 150 : 200,
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.pinkColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          child: Text(widget.related[index]['article']['category']["name"].toString(),style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),),
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(widget.related[index]['article']['title'].toString(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),maxLines: DeviceModel.isMobile ? 2 : 3,overflow: TextOverflow.ellipsis,),
                Spacer(),
                Text("par ${widget.coach["full_name"].toString()}",style: TextStyle(color: Colors.grey,fontSize: 13,fontFamily: "AppFontStyle"),),
                SizedBox(
                  height: 2,
                ),
                Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.related[index]['created_at'].toString())),style: TextStyle(color: AppColors.pinkColor,fontSize: 12,fontFamily: "AppFontStyle"),),
              ],
            ),
          ),
          onTap: (){
              _routes.navigator_push(context, ViewArticle(articledetails: widget.related[index]["article"], isRelated: false,), transitionType: PageTransitionType.bottomToTop);
          },
        );
      },
    );
  }
}
