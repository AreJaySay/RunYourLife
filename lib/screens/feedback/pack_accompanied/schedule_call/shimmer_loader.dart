import 'package:flutter/material.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';

class TimeShimmerLoader extends StatefulWidget {
  @override
  State<TimeShimmerLoader> createState() => _TimeShimmerLoaderState();
}

class _TimeShimmerLoaderState extends State<TimeShimmerLoader> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(left: 5,bottom: 10,top: 20),
      primary: false,
      shrinkWrap: true,
      crossAxisSpacing: 12,
      mainAxisSpacing: 10,
      crossAxisCount: DeviceModel.isMobile ? 3 : 4,
      childAspectRatio: (1 / .3),
      children: <Widget>[
        for(var x = 0; x < 8; x++)...{
          _shimmeringLoader.pageLoader(radius: 1000, width: double.infinity, height:  double.infinity)
        },
      ],
    );
  }
}
