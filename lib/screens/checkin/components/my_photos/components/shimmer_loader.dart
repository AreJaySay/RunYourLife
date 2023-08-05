import 'package:flutter/material.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';

class PhotosShimmerLoader extends StatefulWidget {
  const PhotosShimmerLoader({Key? key}) : super(key: key);

  @override
  State<PhotosShimmerLoader> createState() => _PhotosShimmerLoaderState();
}

class _PhotosShimmerLoaderState extends State<PhotosShimmerLoader> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        for(var months = 0; months < 2; months++)...{
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(right: 200),
            child: _shimmeringLoader.pageLoader(radius: 10, width: 50, height: 20),
          ),
          SizedBox(
            height: 20,
          ),
          GridView.count(
            padding: EdgeInsets.all(0),
            primary: false,
            shrinkWrap: true,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: DeviceModel.isMobile ? 3 : 4,
            children: <Widget>[
              for(var _photos = 0; _photos < 7; _photos++)...{
                _shimmeringLoader.pageLoader(radius: 10, width: double.infinity, height: double.infinity)
              }
            ],
          ),
        },
        SizedBox(
          height: DeviceModel.isMobile ? 50 : 0,
        )
      ],
    );
  }
}
