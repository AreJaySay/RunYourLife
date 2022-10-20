import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';
import 'package:run_your_life/services/stream_services/subscriptions/step5.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

class SportMakeChoices extends StatefulWidget {
  @override
  _SportMakeChoicesState createState() => _SportMakeChoicesState();
}

class _SportMakeChoicesState extends State<SportMakeChoices> {
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    step5subs.practice_sport = "Yes";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("PRATIQUES-TU UN SPORT ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step5streamService.current ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Transform.scale(
                        scale: 1.4,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 1,
                          groupValue: step5streamService.current ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step5streamService.update(data: true);
                              step5subs.practice_sport = "Yes";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Oui',style: new TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step5streamService.update(data: true);
                  step5subs.practice_sport = "Yes";
                });
              },
            ),
            SizedBox(
              width: 15,
            ),
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: !step5streamService.current ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Transform.scale(
                        scale: 1.4,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 2,
                          groupValue: !step5streamService.current ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step5streamService.update(data: false);
                              step5subs.practice_sport = "No";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Non',style: new TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step5streamService.update(data: false);
                  step5subs.practice_sport = "No";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}