import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class BlogPlaceholder extends StatefulWidget {
  @override
  _BlogPlaceholderState createState() => _BlogPlaceholderState();
}

class _BlogPlaceholderState extends State<BlogPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          width: 90,
          image: AssetImage("assets/icons/searchblog.png"),
        ),
        SizedBox(
          height: 10,
        ),
        Text("NO ARTICLE FOUND.",style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle",fontSize: 15),),
      ],
    );
  }
}
