import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoDialog extends StatelessWidget {

  final YoutubePlayerController controller;
  final String imageUrl;

  const VideoDialog({Key? key, required this.controller, required this.imageUrl}) : super(key: key);

  static Future<T?> openModal<T>(context, {controller, cover}){
    return showDialog<T>(context: context, builder: (context) => VideoDialog(controller: controller, imageUrl: cover));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child:  ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: YoutubePlayer(
          controller: controller,
          progressIndicatorColor: Colors.white,
          progressColors: const ProgressBarColors(
            playedColor: Colors.white,
            handleColor: Colors.white,
            bufferedColor: Colors.white30,
            backgroundColor: Colors.white30,
          ),
          showVideoProgressIndicator: true,
          thumbnail: CachedImage(imageUrl, fit: BoxFit.cover,),
        ),
      ),
    );
  }
}