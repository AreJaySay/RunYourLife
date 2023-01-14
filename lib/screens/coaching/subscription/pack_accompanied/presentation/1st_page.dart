import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../widgets/textfields.dart';

class Presentation1stPage extends StatefulWidget {
  @override
  _Presentation1stPageState createState() => _Presentation1stPageState();
}

class _Presentation1stPageState extends State<Presentation1stPage> {
  TextEditingController _weight = new TextEditingController()..text=step1subs.weight;
  TextEditingController _height = new TextEditingController()..text=step1subs.height;
  bool _keyboardVisible = false;

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('fr'),
        initialDate:  DateTime.now().toUtc().add(Duration(hours: 2)),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        step1subs.birthdate = selectedDate.toString();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = step1subs.birthdate == "" ? null : DateTime.parse(step1subs.birthdate);
    KeyboardVisibilityController().onChange.listen((event) {
      setState(() {
        _keyboardVisible = event;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _weight.dispose();
    _height.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ZoomTapAnimation(end: 0.99,child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: step1subs.gender == "Male" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step1subs.gender == "Male" ? 1 : 2,
                          onChanged: (val) {
                            setState(() {
                              step1subs.gender = "Male";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Homme',style: new TextStyle(fontSize: 14,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step1subs.gender = "Male";
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
                    border: Border.all(color: step1subs.gender == "Female" ? AppColors.appmaincolor : Colors.transparent,)
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
                          groupValue: step1subs.gender == "Female" ? 2 : 1,
                          onChanged: (val) {
                            setState(() {
                              step1subs.gender = "Female";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Femme',style: new TextStyle(fontSize: 14,color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  step1subs.gender = "Female";
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Text(selectedDate == null ? "Date d'anniversaire" : DateFormat("dd/MM/yyyy").format(DateTime.parse(selectedDate.toString())) ,style: TextStyle(color: selectedDate == null ? Colors.grey : Colors.black,fontFamily: "AppFontStyle",fontSize: 15.5),),
          ),
          onTap: (){
            _selectDate(context);
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextFields(_weight,hintText: "Poids (kg)",
          onChanged: (text){
            setState(() {
              step1subs.weight = text;
              print(step1subs.weight.toString());
            });
          },inputType: TextInputType.numberWithOptions(decimal: true),isWeight: true,),
        SizedBox(
          height: 20,
        ),
        TextFields(_height,hintText: "Taille (cm)",
          onChanged: (text){
            setState(() {
              step1subs.height = _height.text;
            });
          },inputType: TextInputType.number,isWeight: true,),
      ],
    );
  }
}
