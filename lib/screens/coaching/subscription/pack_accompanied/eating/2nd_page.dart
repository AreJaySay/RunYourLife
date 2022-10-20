import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

class Eating2ndPage extends StatefulWidget {
  @override
  _Eating2ndPageState createState() => _Eating2ndPageState();
}

class _Eating2ndPageState extends State<Eating2ndPage> {
  TextEditingController _other = new TextEditingController();
  int _horizontalSelected = 10;
  String? _horizontalChoosen;
  List<String> _horizontalTitle = ["0-1 an","1-2 an(s)",">2 ans"];
  List<String> _preferences = ["Méditerranéenne","Paleo","Cétogène","Non aucun"];
  int? _verticalMenu;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _other.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("AS-TU SUIVI UN RÉGIME DRASTIQUE ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
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
                    border: Border.all(color: step2subs.follow_drastic_diet.contains("Yes") ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step2subs.follow_drastic_diet.contains("Yes") ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step2subs.follow_drastic_diet = "Yes";
                            });
                          }
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
                  step2subs.follow_drastic_diet = "Yes";
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
                    border: Border.all(color: step2subs.follow_drastic_diet.contains("No") ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step2subs.follow_drastic_diet.contains("No") ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step2subs.follow_drastic_diet = "No";
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
                  step2subs.follow_drastic_diet = "No";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
      step2subs.follow_drastic_diet == "No" ? Container() :
       Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("AS-TU SUIVI UN RÉGIME DRASTIQUE ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                for(var x = 0; x < _horizontalTitle.length; x++)...{
                  Expanded(
                    child: ZoomTapAnimation(end: 0.99,child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color:  _horizontalSelected == x ? AppColors.appmaincolor : Colors.transparent,)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Transform.scale(
                                scale: 1.4,
                                child: Radio(
                                  activeColor: AppColors.appmaincolor,
                                  value: _horizontalSelected,
                                  groupValue: x,
                                  onChanged: (val) {
                                    setState(() {
                                      _horizontalSelected = x;
                                      _horizontalChoosen = _horizontalTitle[x];
                                    });
                                  },
                                ),
                              ),
                            ),
                            Text(_horizontalTitle[x], style: new TextStyle(fontSize: 15,
                                color: Colors.black, fontFamily: "AppFontStyle"),),
                          ],
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          _horizontalSelected = x;
                          _horizontalChoosen = _horizontalTitle[x];
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: x == 2 ? 0 : 15,
                  )
                }
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text("AS-TU SUIVI UN RÉGIME DRASTIQUE ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 15,
            ),
            for(var x = 0 ;x < _preferences.length;x ++)...{
              ZoomTapAnimation(end: 0.99,child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color:  _verticalMenu == x ? AppColors.appmaincolor : Colors.transparent,)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
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
                              color: _verticalMenu == x ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(_preferences[x], style: new TextStyle(fontSize: 15,
                            color: Colors.black,fontFamily: "AppFontStyle"),),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  setState(() {
                    _verticalMenu = x;
                    _other.text = "";
                    step2subs.follow_drastic_diet = "${step2subs.follow_drastic_diet},${_horizontalChoosen},${_preferences[x]}";
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
            },
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                onChanged: (text){
                  setState(() {
                    _verticalMenu = null;
                    step2subs.follow_drastic_diet = "${step2subs.follow_drastic_diet},${_horizontalChoosen},${text}";
                  });
                },
                style: TextStyle(fontFamily: "AppFontStyle"),
                controller: _other,
                maxLines: 4,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    border: InputBorder.none,
                    hintText: "Autres...",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 80,
        ),
      ],
    );
  }
}