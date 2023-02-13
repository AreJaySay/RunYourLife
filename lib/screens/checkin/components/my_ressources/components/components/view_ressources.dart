import 'package:flutter/material.dart';
import 'package:run_your_life/widgets/backbutton.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../utils/palettes/app_colors.dart';

class ViewRessources extends StatefulWidget {
  final Map ressource;
  final bool isPdf;
  ViewRessources({required this.ressource, this.isPdf = false});
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
        title: Text(widget.ressource["programmation"]["file_name"].toString(),style: TextStyle(fontFamily: "AppFontStyle",fontSize: 18,),maxLines: 1,overflow: TextOverflow.ellipsis,),
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
              initialUrl: widget.isPdf ? 'https://docs.google.com/gview?embedded=true&url=${widget.ressource["programmation"]["file_path"]}' : widget.ressource["programmation"]["file_path"],
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}
