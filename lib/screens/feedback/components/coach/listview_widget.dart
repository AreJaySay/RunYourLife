import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:readmore/readmore.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:intl/intl.dart';

class CoachListViewWidget extends StatefulWidget {
  final Map details;
  final bool isMacroSolo;
  CoachListViewWidget(this.details,{this.isMacroSolo = false});
  @override
  _CoachListViewWidgetState createState() => _CoachListViewWidgetState();
}

class _CoachListViewWidgetState extends State<CoachListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          widget.isMacroSolo ? Align(
            alignment: Alignment.bottomRight,
            child: Image(
              image: AssetImage("assets/icons/lock.png"),
              width: 110,
              filterQuality: FilterQuality.high,
              color: Colors.black.withOpacity(0.10),
            ),
          ) : Container(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateFormat.yMMMd('fr_FR').format(DateTime.parse(widget.details["created_at"].toString())) == DateFormat.yMMMd('fr_FR').format(DateTime.now().toUtc().add(Duration(hours: 2))) ?
                Text("Aujourd'hui, ${DateFormat("HH:mm",'fr_FR').format(DateTime.parse(widget.details["created_at"].toString()).toUtc().add(Duration(hours: 1)))}",style: TextStyle(color: widget.isMacroSolo ? Colors.grey[300] : Colors.grey,fontSize: 13),) :
                Text(DateFormat.yMMMd('fr_FR').format(DateTime.parse(widget.details["created_at"].toString())),style: TextStyle(color: widget.isMacroSolo ? Colors.grey[300] : Colors.grey,fontSize: 13),),
                SizedBox(
                  height: 8,
                ),
                HtmlWidget(widget.details["feedbackscol"].toString(), onTapUrl: (url)async{
                  return true;
                },textStyle: TextStyle(color: widget.isMacroSolo ? Colors.grey[400] : Colors.black,fontWeight: FontWeight.w500,fontSize: 15,fontFamily: "AppFontStyle"),),
                // ReadMoreText(
                //   widget.details["feedbackscol"].toString(),
                //   trimLines: 4,
                //   colorClickableText: Colors.pink,
                //     trimMode: TrimMode.Line,
                //   trimCollapsedText: 'Voir plus',
                //   trimExpandedText: 'Voir moins',
                //   lessStyle: TextStyle(fontWeight: FontWeight.w600,color: widget.isMacroSolo ? AppColors.appmaincolor.withOpacity(0.3) : AppColors.appmaincolor,fontSize: 14.5,fontFamily: "AppFontStyle"),
                //   moreStyle: TextStyle(fontWeight: FontWeight.w600,color: widget.isMacroSolo ? AppColors.appmaincolor.withOpacity(0.3) : AppColors.appmaincolor,fontSize: 14.5,fontFamily: "AppFontStyle"),
                //   style: TextStyle(color: widget.isMacroSolo ? Colors.grey[400] : Colors.black,fontWeight: FontWeight.w500,fontSize: 15,fontFamily: "AppFontStyle"),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
