import 'dart:io';
import 'package:video_player/video_player.dart';

class CreateVideoPlayer{
  Future<VideoPlayerController> createVideoPlayer({File? fileimage}) async {
    final VideoPlayerController controller = VideoPlayerController.file(fileimage!);
    await controller.initialize();
    await controller.setLooping(true);
    return controller;
  }

  Future<VideoPlayerController> documentVideo({String? video}) async {
    final VideoPlayerController controller = VideoPlayerController.network(video!);
    await controller.initialize();
    await controller.setLooping(true);
    return controller;
  }
}