import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class NoDataFound extends StatefulWidget {
  final String firstString,secondString,thirdString;
  NoDataFound({required this.firstString,required this.secondString,required this.thirdString});
  @override
  State<NoDataFound> createState() => _NoDataFoundState();
}

class _NoDataFoundState extends State<NoDataFound> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                Text(widget.firstString,style: TextStyle(fontSize: 16,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                Text(widget.secondString,style: TextStyle(fontSize: 16,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Text(widget.thirdString,style: TextStyle(fontSize: 15.5,color: Colors.black,fontFamily: "AppFontStyle"),textAlign: TextAlign.center,),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
