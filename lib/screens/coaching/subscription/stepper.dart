import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class MyStepper extends StatefulWidget {
  double range,maxLength;
  MyStepper(this.maxLength,{this.range = 0});

  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(widget.range.floor().toString()+" / ${widget.maxLength.floor().toString()}",style: TextStyle(color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontSize: 14.5,fontWeight: FontWeight.w600),),
        ),
        FlutterSlider(
          handlerHeight: 20,
          tooltip: FlutterSliderTooltip(
              alwaysShowTooltip: false,
              disabled: true
          ),
          trackBar: FlutterSliderTrackBar(
            inactiveTrackBarHeight: 15,
            activeTrackBarHeight: 15,
            activeDisabledTrackBarColor: AppColors.appmaincolor,
            inactiveDisabledTrackBarColor: Colors.grey.shade300,
            activeTrackBar: BoxDecoration(
                color: AppColors.appmaincolor,
                borderRadius: BorderRadius.circular(1000),
            ),
            inactiveTrackBar: BoxDecoration(
              color: AppColors.appmaincolor,
                borderRadius: BorderRadius.circular(1000)
            ),
          ),
          handler: FlutterSliderHandler(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(119, 192, 213,0.9),
                  borderRadius: BorderRadius.circular(1000)
              ),
            child: Container()
          ),
          disabled: true,
          values: [widget.range],
          max: widget.maxLength,
          min: 0,
          onDragging: (handlerIndex, lowerValue, upperValue) {
            widget.range = lowerValue;
            setState(() {});
          },
        ),
      ],
    );
  }
}
