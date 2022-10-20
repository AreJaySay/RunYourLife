import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class VideosPlayer extends StatefulWidget {
  final String youtubeId;
  VideosPlayer(this.youtubeId);
  @override
  _VideosPlayerState createState() => _VideosPlayerState();
}

class _VideosPlayerState extends State<VideosPlayer> {
  // YoutubePlayerController? _controller;
  bool _isReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = YoutubePlayerController(
    //   initialVideoId: widget.youtubeId,
    //   flags: YoutubePlayerFlags(
    //     hideControls: false,
    //     controlsVisibleAtStart: false,
    //     useHybridComposition: true,
    //     autoPlay: true,
    //     mute: false,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            padding: EdgeInsets.all(15),
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop(null);
                  setState(() {
                    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                  });
                },
                child: Container(
                  width: 45,
                  height: 45,
                  alignment: Alignment.center,
                  child: Center(
                    child: Platform.isAndroid ? Icon(Icons.arrow_back,color:AppColors.pinkColor,size: 22,) :  Icon(Icons.arrow_back_ios_sharp,color: AppColors.pinkColor,size: 22,),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1000)
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   child: Center(
          //     child: YoutubePlayer(
          //       width: double.infinity,
          //       controller: _controller!,
          //       progressColors: ProgressBarColors(
          //         playedColor: AppColors.appmaincolor,
          //         bufferedColor: Colors.grey.shade300,
          //         backgroundColor: Colors.white
          //       ),
          //       showVideoProgressIndicator: true,
          //       progressIndicatorColor:Colors.amber,
          //       onReady: (){
          //
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
