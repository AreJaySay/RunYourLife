import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/screens/checkin/tracking.dart';
import 'package:run_your_life/services/stream_services/screens/home.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class SlideWidgets extends StatefulWidget {
  @override
  _SlideWidgetsState createState() => _SlideWidgetsState();
}

class _SlideWidgetsState extends State<SlideWidgets> {
  List<String> _grams = ["Protéines","Lipides","Glucides","Légumes"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(var x = 0; x < 4; x++)...{
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(_grams[x],style: TextStyle(color: Colors.black,fontSize: 15.5,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
              Text(subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? "" : " (${subscriptionDetails.currentdata[0]["coach_macros"][0][x == 0 ? "protein" : x == 1 ? "lipid" : x == 2 ? "carbohydrate" : "vegetable"].toString()})",style: TextStyle(color: Colors.black,fontSize: 15.5,fontFamily: "AppFontStyle"),),
              Spacer(),
              InkWell(
                child: Icon(Icons.remove_circle_outline,color: AppColors.pinkColor,),
                onTap: (){
                  setState(() {
                    if(Tracking.gramslider[x] != 0){
                      Tracking.gramslider[x]--;
                    }
                  });
                },
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                child: Icon(Icons.add_circle_outline,color: AppColors.appmaincolor,),
                onTap: (){
                  setState(() {
                    Tracking.gramslider[x]++;
                  });
                },
              )
            ],
          ),
          FlutterSlider(
            values: [Tracking.gramslider[x]],
            max: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ? 1000 : subscriptionDetails.currentdata[0]["coach_macros"][0]["type"] == "portions" ? 35 : 1000,
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
              activeTrackBar: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ?
              BoxDecoration(
                  color: AppColors.appmaincolor,
                  borderRadius: BorderRadius.circular(1000)
              ) :
              BoxDecoration(
                  color: Tracking.gramslider[x] > int.parse(subscriptionDetails.currentdata[0]["coach_macros"][0][x == 0 ? "protein" : x == 1 ? "lipid" : x == 2 ? "carbohydrate" : "vegetable"].toString()) ? Colors.redAccent : AppColors.appmaincolor,
                  borderRadius: BorderRadius.circular(1000)
              ),
              inactiveTrackBar: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(1000)
              ),
            ),
            handler: FlutterSliderHandler(
                decoration: subscriptionDetails.currentdata[0]["coach_macros"].toString() == "[]" ?
                BoxDecoration(
                    color: AppColors.appmaincolor,
                    borderRadius: BorderRadius.circular(10)
                ) :
                BoxDecoration(
                    color:Tracking.gramslider[x] > int.parse(subscriptionDetails.currentdata[0]["coach_macros"][0][x == 0 ? "protein" : x == 1 ? "lipid" : x == 2 ? "carbohydrate" : "vegetable"].toString()) ? Colors.redAccent : AppColors.appmaincolor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(Tracking.gramslider[x].round().toString(),style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              Tracking.gramslider[x] = lowerValue;
              setState(() {
                if(x == 0){
                  tracking.protein = lowerValue;
                }else if(x == 1){
                  tracking.lipid = lowerValue;
                }else if(x == 2){
                  tracking.carbohydrate = lowerValue;
                }else{
                  tracking.vegetable = lowerValue;
                }
              });
            },
          )
        }
      ],
    );
  }
}
