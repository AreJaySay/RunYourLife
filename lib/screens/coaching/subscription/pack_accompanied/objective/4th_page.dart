import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../models/subscription_models/step4_subs.dart';

class Objective4thPage extends StatefulWidget {
  @override
  _Objective4thPageState createState() => _Objective4thPageState();
}

class _Objective4thPageState extends State<Objective4thPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(step4subs.date_to_reach_goal != ""){
    step4subs.date_to_reach_goal = _selectedDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quel délai tu t'accordes pouratteindre ton objectif ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Jour",style: TextStyle(color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
              Text("Mois",style: TextStyle(color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
              Text("Année",style: TextStyle(color: AppColors.darpinkColor,fontFamily: "AppFontStyle"),),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 300,
          child: ScrollDatePicker(
            minimumDate: DateTime.now(),
            maximumDate: DateTime.parse('2050-01-01 12:00:42.172724'),
            selectedDate: _selectedDate,
            locale: Locale('fr'),
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _selectedDate = value;
                step4subs.date_to_reach_goal = _selectedDate.toString();
              });
            },
            scrollViewOptions: DatePickerScrollViewOptions(
              day: ScrollViewDetailOptions(margin: EdgeInsets.only(right: 30)),
              month: ScrollViewDetailOptions(margin: EdgeInsets.only(left: 30)),
              year: ScrollViewDetailOptions(margin: EdgeInsets.only(left: 30))
            ),
            options: DatePickerOptions(
              itemExtent: 40,
              diameterRatio: 8,
            ),
            indicator: Container(
              width: double.infinity,
              height: 45,
              color: AppColors.appmaincolor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(_selectedDate.day.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "AppFontStyle"),),
                  Text(DateFormat("MMMM","fr").format(DateTime.parse(_selectedDate.toString()))[0].toUpperCase()+DateFormat("MMMM","fr").format(DateTime.parse(_selectedDate.toString())).substring(1).toLowerCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "AppFontStyle"),),
                  Text(_selectedDate.year.toString()+"    ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "AppFontStyle"),)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}