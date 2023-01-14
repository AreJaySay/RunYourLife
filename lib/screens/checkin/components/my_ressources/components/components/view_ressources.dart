import 'package:flutter/material.dart';
import 'package:run_your_life/widgets/backbutton.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../utils/palettes/app_colors.dart';

class ViewRessources extends StatefulWidget {
  final Map ressource;
  ViewRessources({required this.ressource});
  @override
  State<ViewRessources> createState() => _ViewRessourcesState();
}

class _ViewRessourcesState extends State<ViewRessources> {
  final Materialbutton _materialButton = new Materialbutton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.appmaincolor,
        title: Text(widget.ressource["documents"]["file_name"].toString(),style: TextStyle(fontFamily: "AppFontStyle",fontSize: 18,),maxLines: 1,overflow: TextOverflow.ellipsis,),
      ),
      body: Stack(
        children: [
          Center(
            child: CircularProgressIndicator(
              color: AppColors.appmaincolor,
            ),
          ),
          Center(
            child: WebView(
              initialUrl: widget.ressource["documents"]["file_path"],
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}
