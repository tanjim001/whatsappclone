import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerController videoPlayerController;
  bool isplay=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayer(videoPlayerController),
          IconButton(
                  onPressed: () {
                    if(isplay){
                      videoPlayerController.pause();
                    }else{
                      videoPlayerController.play();
                    }
                    setState(() {
                      isplay=!isplay;
                    });
                  },
                  icon:  Icon(isplay==true?Icons.pause_circle:Icons.play_circle))
              .centered()
        ],
      ),
    );
  }
}
