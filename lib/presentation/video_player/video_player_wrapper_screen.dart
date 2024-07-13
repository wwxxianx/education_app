import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWrapperScreen extends StatefulWidget {
  static const route = '/video-player';
  final String videoUrl;
  const VideoPlayerWrapperScreen({
    super.key,
    this.videoUrl =
        "https://vooexvblyikqqqacbwnx.supabase.co/storage/v1/object/public/course/videos/6646688-hd_1920_1080_24fps__1_.mp4",
  });

  @override
  State<VideoPlayerWrapperScreen> createState() =>
      _VideoPlayerWrapperScreenState();
}

class _VideoPlayerWrapperScreenState extends State<VideoPlayerWrapperScreen> {
  late VideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true);
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const HeroIcon(
              HeroIcons.arrowDownTray,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CustomVideoPlayer(
                      customVideoPlayerController:
                          _customVideoPlayerController),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
