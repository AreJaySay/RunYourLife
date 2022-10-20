import 'dart:io';

import 'package:flutter/material.dart';
import 'package:run_your_life/functions/base64_converter.dart';
import 'package:run_your_life/functions/create_video_player.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideosRessourcesDesign extends StatefulWidget {
  final String base64;
  VideosRessourcesDesign({required this.base64});
  @override
  State<VideosRessourcesDesign> createState() => _VideosRessourcesDesignState();
}

class _VideosRessourcesDesignState extends State<VideosRessourcesDesign> {
  final Base64Converter _base64converter = new Base64Converter();
  VideoPlayerController? _videocontroller;
  final CreateVideoPlayer _createVideoPlayer = new CreateVideoPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _base64converter.createFileFromString(base64String:  widget.base64.replaceAll("data:video/mp4;base64,", ""),extension: ".mp4").then((value)async{
     await _createVideoPlayer.createVideoPlayer(fileimage: File(value)).then((value)async{
        setState((){
          _videocontroller = value;
          print("FILE ${_videocontroller.toString()}");
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _videocontroller == null ? Container(
      height: DeviceModel.isMobile ? 120 : 150,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    ) : _videocontroller!.value.isInitialized ?
    Stack(
      children: [
        Container(
          height: DeviceModel.isMobile ? 120 : 150,
          width: 180,
          child: AspectRatio(
            aspectRatio: _videocontroller!.value.aspectRatio,
            child: VideoPlayer(_videocontroller!),
          ),
        ),
        Container(
          height: DeviceModel.isMobile ? 120 : 150,
          width: 180,
          child: Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Colors.white.withOpacity(0.4),
              ),
              child: Center(
                child: Icon(Icons.play_arrow,color: AppColors.appmaincolor,),
              ),
            ),
          )
        ),
      ],
    ) : Container(
      height: DeviceModel.isMobile ? 120 : 150,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
