import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step7_subs.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../../utils/palettes/app_colors.dart';

class Sleep2ndPage extends StatefulWidget {
  @override
  _Sleep2ndPageState createState() => _Sleep2ndPageState();
}

class _Sleep2ndPageState extends State<Sleep2ndPage> {
  List _isWakeUpNight = ["Oui, j'ai du mal à me rendormir","Oui, juste pour aller aux toilettes","Jamais"];
  List _isTroubleSleep = ["Oui, j'ai du mal à m'endormir","Cela peut m'arriver en période de stress","Non, je m'endors facilement "];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Je me réveille souvent la nuit".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0 ;x < _isWakeUpNight.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: step7subs.wake_up_at_night == _isWakeUpNight[x] ? AppColors.appmaincolor : Colors.transparent,)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                      child: Center(
                        child: Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                              color: step7subs.wake_up_at_night == _isWakeUpNight[x] ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        step7subs.wake_up_at_night = _isWakeUpNight[x];
                      });
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(_isWakeUpNight[x], style: new TextStyle(fontSize: 15,
                        color: Colors.black,fontFamily: "AppFontStyle"),),
                  ),
                ],
              ),
            ),
            onTap: (){
              setState(() {
                step7subs.wake_up_at_night = _isWakeUpNight[x];
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
        },
        SizedBox(
          height: 30,
        ),
        Text("As-tu des difficultés à t'endormir".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0 ;x < _isTroubleSleep.length;x ++)...{
          ZoomTapAnimation(end: 0.99,child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: step7subs.trouble_sleeping == _isTroubleSleep[x] ? AppColors.appmaincolor : Colors.transparent,)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                      child: Center(
                        child: Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                              color: step7subs.trouble_sleeping == _isTroubleSleep[x] ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        step7subs.trouble_sleeping = _isTroubleSleep[x];
                      });
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(_isTroubleSleep[x], style: new TextStyle(fontSize: 15,
                        color: Colors.black,fontFamily: "AppFontStyle"),),
                  ),
                ],
              ),
            ),
            onTap: (){
              setState(() {
                step7subs.trouble_sleeping = _isTroubleSleep[x];
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
        },
        SizedBox(
          height: 30,
        ),
        Text("Regardes-tu la télé ou téléphone dans le lit ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step7subs.bed_gadget == "Oui" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step7subs.bed_gadget == "Oui" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step7subs.bed_gadget = "Oui";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Oui',style: new TextStyle(fontSize: 14,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step7subs.bed_gadget = "Oui";
                });
              },
            ),
            SizedBox(
              width: 30,
            ),
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step7subs.bed_gadget == "Non" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step7subs.bed_gadget == "Non" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step7subs.bed_gadget = "Non";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Non',style: new TextStyle(fontSize: 14,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step7subs.bed_gadget = "Non";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}