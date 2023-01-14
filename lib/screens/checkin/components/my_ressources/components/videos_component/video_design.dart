import 'dart:io';

import 'package:flutter/material.dart';
import 'package:run_your_life/functions/base64_converter.dart';
import 'package:run_your_life/functions/create_video_player.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideosRessourcesDesign extends StatefulWidget {
  final String video;
  VideosRessourcesDesign({required this.video});
  @override
  State<VideosRessourcesDesign> createState() => _VideosRessourcesDesignState();
}

class _VideosRessourcesDesignState extends State<VideosRessourcesDesign> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
