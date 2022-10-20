import 'package:flutter/material.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';

class CoachingShimmerLoader extends StatefulWidget {
  @override
  _CoachingShimmerLoaderState createState() => _CoachingShimmerLoaderState();
}

class _CoachingShimmerLoaderState extends State<CoachingShimmerLoader> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Text("LES ABONNEMENTS",style: TextStyle(color: AppColors.appmaincolor,fontSize: 22,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
        ),
        Container(
          margin: EdgeInsets.only(left: 20,right: 20,bottom: 25),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3.0, // has the effect of softening the shadow
                spreadRadius: 1.0, // has the effect of extending the shadow
                offset: Offset(
                  0.0, // horizontal, move right 10
                  1.0, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: _shimmeringLoader.pageLoader(radius: 50, width: 200, height: 20),
                  padding: EdgeInsets.only(left: 20,right: 20,top: 30)
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmeringLoader.pageLoader(radius: 50, width: 300, height: 12),
                    SizedBox(
                      height: 10,
                    ),
                    _shimmeringLoader.pageLoader(radius: 50, width: 270, height: 12),
                    SizedBox(
                      height: 10,
                    ),
                    _shimmeringLoader.pageLoader(radius: 50, width: 150, height: 12),
                  ],
                )
              ),
              Spacer(),
              Container(
                alignment: Alignment.centerRight,
                width: double.infinity,
                child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.pinkColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(10)
                      )
                  ),
                  child: Center(child: _shimmeringLoader.pageLoader(radius: 50, width: 80, height: 15))
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: AppGradientColors.gradient,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3.0, // has the effect of softening the shadow
                spreadRadius: 1.0, // has the effect of extending the shadow
                offset: Offset(
                  0.0, // horizontal, move right 10
                  1.0, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Stack(
            children: [
              Image(
                color: Colors.white,
                width: double.infinity,
                alignment: Alignment.topRight,
                image: AssetImage("assets/important_assets/coaching_back.png"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: _shimmeringLoader.pageLoader(radius: 50, width: 200, height: 20),
                      padding: EdgeInsets.only(left: 20,right: 20,top: 30)
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmeringLoader.pageLoader(radius: 50, width: 300, height: 12),
                        SizedBox(
                          height: 10,
                        ),
                        _shimmeringLoader.pageLoader(radius: 50, width: 270, height: 12),
                        SizedBox(
                          height: 10,
                        ),
                        _shimmeringLoader.pageLoader(radius: 50, width: 150, height: 12),
                      ],
                    )
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.centerRight,
                    width: double.infinity,
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(10)
                          )
                      ),
                      child: Center(child: _shimmeringLoader.pageLoader(radius: 50, width: 80, height: 15))
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
