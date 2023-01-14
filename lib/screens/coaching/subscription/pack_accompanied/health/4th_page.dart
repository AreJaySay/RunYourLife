import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/models/subscription_models/step3_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../../widgets/textfields.dart';

class Health4thPage extends StatefulWidget {
  @override
  _Health4thPageState createState() => _Health4thPageState();
}

class _Health4thPageState extends State<Health4thPage> {
  TextEditingController _disorderage = new TextEditingController()..text=step3subs.eating_disorder_age;
  TextEditingController _remedy = new TextEditingController()..text=step3subs.eating_disorder_remedy;
  TextEditingController _fears = new TextEditingController()..text=step3subs.fears;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    step3subs.eating_disorder = "Oui";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _disorderage.dispose();
    _remedy.dispose();
    _fears.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("TCA : as-tu souffert de troubles de comportements alimentaires (anorexie, boulimie, phobie ...)".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        // Text("Anorexie, boulimie, phobie, …",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        // SizedBox(
        //   height: 20,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step3subs.eating_disorder == "Oui" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step3subs.eating_disorder == "Oui" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step3subs.eating_disorder = "Oui";
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
                  step3subs.eating_disorder = "Oui";
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
                    border: Border.all(color: step3subs.eating_disorder == "No" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step3subs.eating_disorder == "No" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step3subs.eating_disorder = "No";
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
                  step3subs.eating_disorder = "No";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        step3subs.eating_disorder == "No" ? Container() :
       Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Si oui, à quel âge ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 15,
            ),
            TextFields(_disorderage,hintText: "Quel âge",onChanged: (text){
              setState(() {
                step3subs.eating_disorder_age = text;
              });
            },),
            SizedBox(
              height: 40,
            ),
            Text("Si oui, comment y as-tu remédier ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _remedy,
              maxLines: 4,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  border: InputBorder.none,
                  hintText: "Explications",
                  hintStyle: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appmaincolor),
                      borderRadius: BorderRadius.circular(10)
                  ),
              ),
              onChanged: (text){
                setState(() {
                  step3subs.eating_disorder_remedy = text;
                });
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text("As-tu encore certaines craintes, comportements ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _fears,
              maxLines: 4,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  border: InputBorder.none,
                  hintText: "Explications",
                  hintStyle: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appmaincolor),
                      borderRadius: BorderRadius.circular(10)
                  ),
              ),
              onChanged: (text){
                setState(() {
                  step3subs.fears = text;
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