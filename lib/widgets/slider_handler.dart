import 'package:another_xlider/another_xlider.dart';
import "package:flutter/material.dart";

import 'package:run_your_life/utils/palettes/app_colors.dart';

class SliderHandler extends StatefulWidget {
  final double range;
  final ValueChanged<double> onslidecallback;
  final Function(int,dynamic,dynamic)? onDragging;
  const SliderHandler({required this.range, required this.onslidecallback, this.onDragging});
  @override
  _SliderHandlerState createState() => _SliderHandlerState();
}

class _SliderHandlerState extends State<SliderHandler> {
  @override
  Widget build(BuildContext context) {
    return  FlutterSlider(
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
          color: AppColors.pinkColor,
          borderRadius: BorderRadius.circular(1000),
        ),
        inactiveTrackBar: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(1000)
        ),
      ),
      handler: FlutterSliderHandler(
          decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(1000)
          ),
          child: Container()
      ),
      values: [widget.range],
      max: 14,
      min: 0,
      onDragging: widget.onDragging,
      // onDragging: (handlerIndex, lowerValue, upperValue) {
      //   lowerValue;
      //   setState(() {
      //     if(_range > 1){
      //       showModalBottomSheet(
      //           context: context, builder: (context){
      //         return BottomListView();
      //       });
      //     }
      //   });
      // },
    );
  }
}
