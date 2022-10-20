import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';

class FeedbackShimmerLoader extends StatefulWidget {
  @override
  State<FeedbackShimmerLoader> createState() => _FeedbackShimmerLoaderState();
}

class _FeedbackShimmerLoaderState extends State<FeedbackShimmerLoader> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(var i = 0; i < 4; i++)...{
          _shimmeringLoader.pageLoader(radius: 5, width: 200, height: 15),
          SizedBox(
              height: 15
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            margin: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmeringLoader.pageLoader(radius: 5, width: 130, height: 15),
                SizedBox(
                  height: 8,
                ),
                _shimmeringLoader.pageLoader(radius: 5, width: double.infinity, height: 15),
                SizedBox(
                  height: 8,
                ),
                _shimmeringLoader.pageLoader(radius: 5, width: 250, height: 15),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        }
      ],
    );
  }
}
