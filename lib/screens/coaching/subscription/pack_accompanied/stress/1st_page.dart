import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step6_subs.dart';

import 'package:run_your_life/utils/palettes/app_colors.dart';

class Stress1stPage extends StatefulWidget {
  @override
  _Stress1stPageState createState() => _Stress1stPageState();
}

class _Stress1stPageState extends State<Stress1stPage> {
  TextEditingController _joborstudy = new TextEditingController()..text=step6subs.job_or_study;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _joborstudy.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quel est ton métier ou ta formation ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: TextField(
            controller: _joborstudy,
            maxLines: 4,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                border: InputBorder.none,
                hintText: "Ton métier/Ta formation",
                hintStyle: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle")
            ),
            onChanged: (text){
              setState(() {
                step6subs.job_or_study = text;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Est-ce que ce métier/cette formation est stressant.e ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Text("1 : pas stressant \n3 : modérément \n5 : très stressant",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          child: FlutterSlider(
            values: [step6subs.stress_meter],
            max: 5,
            min: 0,
            handlerWidth: 50,
            handlerHeight: 40,
            tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: false,
                disabled: true
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBarHeight: 10,
              activeTrackBarHeight: 10,
              activeTrackBar: BoxDecoration(
                  color: AppColors.appmaincolor,
                  borderRadius: BorderRadius.circular(1000)
              ),
              inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000)
              ),
            ),
            handler: FlutterSliderHandler(
                decoration: BoxDecoration(
                    color: AppColors.appmaincolor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Text(step6subs.stress_meter.floor().toString(),
                  style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                step6subs.stress_meter = lowerValue;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Est-ce que ce métier/cette formation est épanouissant.e ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        Text("1 : pas épanouissante \n3 : modérément \n5 : très épanouissante",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          child: FlutterSlider(
            values: [step6subs.fulfilling_meter],
            max: 5,
            min: 0,
            handlerWidth: 50,
            handlerHeight: 40,
            tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: false,
                disabled: true
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBarHeight: 10,
              activeTrackBarHeight: 10,
              activeTrackBar: BoxDecoration(
                  color: AppColors.appmaincolor,
                  borderRadius: BorderRadius.circular(1000)
              ),
              inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000)
              ),
            ),
            handler: FlutterSliderHandler(
                decoration: BoxDecoration(
                    color: AppColors.appmaincolor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Text(step6subs.fulfilling_meter.floor().toString(),
                  style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                step6subs.fulfilling_meter = lowerValue;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
