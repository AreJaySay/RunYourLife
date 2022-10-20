import 'package:flutter/material.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';

class RessourceShimmerLoader extends StatefulWidget {
  @override
  State<RessourceShimmerLoader> createState() => _RessourceShimmerLoaderState();
}

class _RessourceShimmerLoaderState extends State<RessourceShimmerLoader> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
      itemCount: 4,
      itemBuilder: (context, index){
        return Container(
          width: double.infinity,
          height: 120,
          margin: EdgeInsets.only(top: 25),
          child: Row(
            children: [
              _shimmeringLoader.pageLoader(radius: 10, width: 180, height: DeviceModel.isMobile ? 120 : 150),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmeringLoader.pageLoader(radius: 5, width: 150, height: 15),
                      SizedBox(
                        height: 5,
                      ),
                      _shimmeringLoader.pageLoader(radius: 5, width: 90, height: 15),
                      SizedBox(
                        height: 15,
                      ),
                      _shimmeringLoader.pageLoader(radius: 5, width: 140, height: 10),
                      SizedBox(
                        height: 5,
                      ),
                      _shimmeringLoader.pageLoader(radius: 5, width: 120, height: 10),
                      Spacer(),
                      _shimmeringLoader.pageLoader(radius: 5, width: 150, height: 25),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
