  import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/models/subscription_models/step3_subs.dart';
import 'package:run_your_life/models/subscription_models/step4_subs.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';
import 'package:run_your_life/models/subscription_models/step6_subs.dart';
import 'package:run_your_life/models/subscription_models/step7_subs.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class FormDesign extends StatefulWidget {
  final Map formInfo;
  final String title;
  FormDesign({required this.formInfo, required this.title});
  @override
  _FormDesignState createState() => _FormDesignState();
}

class _FormDesignState extends State<FormDesign> {
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),
        ),
        SizedBox(
          height: 10,
        ),
        widget.formInfo.toString() == "{}" ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Aucune donnée disponible", style: TextStyle(color: Colors.blueGrey.shade600, fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 3,
            ),
            Text("Quand vous remplissez le formulaire, les données s’afficheront ici.", style: TextStyle(color: Colors.blueGrey.shade300, fontFamily: "AppFontStyle",fontSize: 13.5),),
          ],
        ) :
        widget.title.toString().contains("Préférence alimentaire") ?
        step2subs.richtext(formInfo: widget.formInfo) :
        widget.title.toString().contains("Antécédents médicaux") ?
        step3subs.richtext(formInfo: widget.formInfo) :
        widget.title.toString().contains("Objectif") ?
        step4subs.richtext(formInfo: widget.formInfo) :
        widget.title.toString().contains("Pratique de sport") ?
        step5subs.richtext(formInfo: widget.formInfo) :
        widget.title.toString().contains("Stress") ?
        step6subs.richtext(formInfo: widget.formInfo) :
        step7subs.richtext(formInfo: widget.formInfo) ,
        SizedBox(
          height: 25,
        ),
        // ZoomTapAnimation(
        //   end: 0.99,
        //   child: Image(
        //     width: 23,
        //     color: AppColors.appmaincolor,
        //     image: AssetImage("assets/icons/editform.png"),
        //   ),
        //   onTap: (){
        //     if(widget.title == "Alimentation"){
        //       step2subs.editStep2(context, details: widget.formInfo);
        //     }else if(widget.title == "Antécédents médicaux"){
        //       step3subs.editStep3(context, details: widget.formInfo);
        //     }else if(widget.title == "Objectifs"){
        //       step4subs.editStep4(context, details: widget.formInfo);
        //     }else if(widget.title == "Pratique sportive"){
        //       step5subs.editStep5(context, details: widget.formInfo);
        //     }else if(widget.title == "Stress"){
        //       step6subs.editStep6(context, details: widget.formInfo);
        //     }else{
        //       step7subs.editStep7(context, details: widget.formInfo);
        //     }
        //   },
        // )
      ],
    );
  }
}
