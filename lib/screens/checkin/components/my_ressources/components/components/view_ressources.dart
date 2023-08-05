import 'package:flutter/material.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../../../utils/palettes/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class ViewRessources extends StatefulWidget {
  final Map ressource;
  final bool isPdf,isMessage;
  ViewRessources({required this.ressource, this.isPdf = false, this.isMessage = false});
  @override
  State<ViewRessources> createState() => _ViewRessourcesState();
}

class _ViewRessourcesState extends State<ViewRessources> {
  final Materialbutton _materialButton = new Materialbutton();
  WebViewController _controller = new WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse(widget.isPdf ? 'https://docs.google.com/gview?embedded=true&url=${widget.isMessage ? widget.ressource["file"] : widget.ressource[widget.ressource.toString().contains("programmation") ? "programmation" : "documents"]["file_path"]}' : widget.isMessage ? widget.ressource["file"] : widget.ressource[widget.ressource.toString().contains("programmation") ? "programmation" : "documents"]["file_path"]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.appmaincolor,
        title: Text(!widget.isMessage ? widget.ressource[widget.ressource.toString().contains("programmation") ? "programmation" : "documents"]["file_name"].toString() : widget.ressource["file_name"].toString(),style: TextStyle(fontFamily: "AppFontStyle",fontSize: 18,),maxLines: 1,overflow: TextOverflow.ellipsis,),
      ),
      body: Stack(
        children: [
          Center(
            child: CircularProgressIndicator(
              color: AppColors.appmaincolor,
            ),
          ),
          Center(
            child: WebViewWidget(controller: _controller),
          )
          // WEBVIEW NEED TO CHANGE
          // Center(
          //   child: WebView(
          //     initialUrl: widget.isPdf ? 'https://docs.google.com/gview?embedded=true&url=${widget.ressource["programmation"]["file_path"]}' : widget.ressource["programmation"]["file_path"],
          //     javascriptMode: JavascriptMode.unrestricted,
          //   ),
          // ),
        ],
      ),
    );
  }
}
