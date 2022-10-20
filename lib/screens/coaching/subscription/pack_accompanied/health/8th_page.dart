import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step3_subs.dart';
import 'package:run_your_life/widgets/textfields.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Health8thPage extends StatefulWidget {
  @override
  _Health8thPageState createState() => _Health8thPageState();
}

class _Health8thPageState extends State<Health8thPage> {
  final TextEditingController _cycle = new TextEditingController()..text=step3subs.cycle_average;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    step3subs.observe_menstrual_cycle = "Yes";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cycle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("OBSERVES TU TON CYCLE MENSTRUEL ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ZoomTapAnimation(
              end: 0.99,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step3subs.observe_menstrual_cycle == "Yes" ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Transform.scale(
                        scale: 1.4,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 1,
                          groupValue: step3subs.observe_menstrual_cycle == "Yes" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step3subs.observe_menstrual_cycle = "Yes";
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
                  step3subs.observe_menstrual_cycle = "Yes";
                });
              },
            ),
            SizedBox(
              width: 30,
            ),
            ZoomTapAnimation(
              end: 0.99,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step3subs.observe_menstrual_cycle == "No" ? AppColors.appmaincolor : Colors.transparent,)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Transform.scale(
                        scale: 1.4,
                        child: Radio(
                          activeColor: AppColors.appmaincolor,
                          value: 2,
                          groupValue: step3subs.observe_menstrual_cycle == "No" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step3subs.observe_menstrual_cycle = "No";
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
                  step3subs.observe_menstrual_cycle = "No";
                });
              },
            ),
          ],
        ),
        step3subs.observe_menstrual_cycle  == "No" ? Container() : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text("OBSERVEZ-VOUS VOTRE CYCLE MENSTRUEL RÉGULIER ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ZoomTapAnimation(
                  end: 0.99,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: step3subs.regular_cycle == "Yes" ? AppColors.appmaincolor : Colors.transparent,)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Transform.scale(
                            scale: 1.4,
                            child: Radio(
                              activeColor: AppColors.appmaincolor,
                              value: 1,
                              groupValue: step3subs.regular_cycle == "Yes" ? 1 : 2,
                              onChanged: (val) {
                                setState(() {
                                  step3subs.regular_cycle = "Yes";
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
                      step3subs.regular_cycle = "Yes";
                    });
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                ZoomTapAnimation(
                  end: 0.99,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: step3subs.regular_cycle == "No" ? AppColors.appmaincolor : Colors.transparent,)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Transform.scale(
                            scale: 1.4,
                            child: Radio(
                              activeColor: AppColors.appmaincolor,
                              value: 2,
                              groupValue: step3subs.regular_cycle == "No" ? 2 : 1,
                              onChanged: (val) {
                                setState(() {
                                  step3subs.regular_cycle = "No";
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
                      step3subs.regular_cycle = "No";
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text("COMBIEN DE TEMPS DURENT TES CYCLES EN MOYENNE ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 20,
            ),
            TextFields(_cycle, hintText: "jours/cycle",onChanged: (text){
              setState(() {
                step3subs.cycle_average = text;
              });
            },inputType: TextInputType.number,)
          ],
        ),
        SizedBox(
          height: step3subs.regular_cycle == "No" ? 50 : 30,
        ),
      ],
    );
  }
}
