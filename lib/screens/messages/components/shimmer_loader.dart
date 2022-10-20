import 'package:flutter/material.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';

class MessageShimmerLoader extends StatefulWidget {
  @override
  State<MessageShimmerLoader> createState() => _MessageShimmerLoaderState();
}

class _MessageShimmerLoaderState extends State<MessageShimmerLoader> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(var x = 0; x < 5; x++)...{
          x.isOdd ?
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(left: 20,right: 70),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(68, 169, 204,0.9).withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10)
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmeringLoader.pageLoader(radius: 10, width: double.infinity, height: 15),
                    SizedBox(
                      height: 10,
                    ),
                    _shimmeringLoader.pageLoader(radius: 10, width: 200, height: 15),
                    SizedBox(
                      height: 10,
                    ),
                    _shimmeringLoader.pageLoader(radius: 10, width: 150, height: 15),
                  ],
                )
            ),
          ) :
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(left: 70,right: 20),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _shimmeringLoader.pageLoader(radius: 10, width: double.infinity, height: 15),
                  SizedBox(
                    height: 10,
                  ),
                  _shimmeringLoader.pageLoader(radius: 10, width: 200, height: 15),
                  SizedBox(
                    height: 10,
                  ),
                  _shimmeringLoader.pageLoader(radius: 10, width: 150, height: 15),
                ],
              ),
            ),
          ),
        },
      ],
    );
  }
}
