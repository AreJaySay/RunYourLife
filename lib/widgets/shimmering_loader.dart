import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringLoader{
  Widget pageLoader({required double radius, required double width, required double height,}){
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.white,

        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
            )
        )
    );
  }
}