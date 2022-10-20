import 'dart:io';

import 'package:flutter/material.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';

class BlogShimmerLoader extends StatefulWidget {
  @override
  _BlogShimmerLoaderState createState() => _BlogShimmerLoaderState();
}

class _BlogShimmerLoaderState extends State<BlogShimmerLoader> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: DeviceModel.isMobile ? 2 : 3,
          childAspectRatio: DeviceModel.isMobile ? (1 / 1.5) : (1 / 1.23),
        ),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height:DeviceModel.isMobile ? 150 : 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        height: DeviceModel.isMobile ? 150 : 200,
                        alignment: Alignment.topLeft,
                        child: _shimmeringLoader.pageLoader(radius: 10, width: 90, height: 20)

                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmeringLoader.pageLoader(radius: 10, width: double.infinity, height: 15),
                    SizedBox(
                      height: 5,
                    ),
                    _shimmeringLoader.pageLoader(radius: 10, width: 120, height: 15),
                  ],
                ),
                Spacer(),
                _shimmeringLoader.pageLoader(radius: 10, width: 120, height: 15),
                SizedBox(
                  height: 2,
                ),
                _shimmeringLoader.pageLoader(radius: 10, width: 200, height: 15)
              ],
            ),
          );
        }
    );
  }
}

