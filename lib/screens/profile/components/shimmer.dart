import 'package:flutter/material.dart';
import '../../../widgets/shimmering_loader.dart';

class ShimmerLoader extends StatefulWidget {
  @override
  _ShimmerLoaderState createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Genre", style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 5,
                      ),
                      _shimmeringLoader.pageLoader(radius: 10, width: 100, height: 20),
                       SizedBox(
                        height: 20,
                      ),
                      Text("Date de naissance",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                      SizedBox(
                        height: 5,
                      ),
                      _shimmeringLoader.pageLoader(radius: 10, width: 160, height: 20),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Avoir des enfants", style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 5,
                      ),
                      _shimmeringLoader.pageLoader(radius: 10, width: 100, height: 20)
                      ],
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Poids",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                        SizedBox(
                          height: 5,
                        ),
                        _shimmeringLoader.pageLoader(
                            radius: 10, width: 70, height: 20)
                       ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Taille",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 5,
                        ),
                         _shimmeringLoader.pageLoader(
                            radius: 10, width: 70, height: 20)
                         ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Statut",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 5,
                        ),
                       _shimmeringLoader.pageLoader(
                            radius: 10, width: 70, height: 20)
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                  for (var x = 0; x < 3; x++) ...{
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmeringLoader.pageLoader(radius: 10, width: 230, height: 20),
                        SizedBox(
                          height: 10,
                        ),
                        _shimmeringLoader.pageLoader(radius: 10, width: double.infinity, height: 15),
                        SizedBox(
                          height: 5,
                        ),
                        _shimmeringLoader.pageLoader(radius: 10, width: 270, height: 15),
                        SizedBox(
                          height: 5,
                        ),
                        _shimmeringLoader.pageLoader(radius: 10, width: 200, height: 15),
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    )
                  }
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}