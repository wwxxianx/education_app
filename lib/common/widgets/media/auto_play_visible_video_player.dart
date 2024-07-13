import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' as videoPlayer;
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AutoPlayVisibleVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isInteractive;
  const AutoPlayVisibleVideoPlayer({
    super.key,
    required this.videoUrl,
    this.isInteractive = false,
  });

  @override
  State<AutoPlayVisibleVideoPlayer> createState() =>
      _AutoPlayVisibleVideoPlayerState();
}

class _AutoPlayVisibleVideoPlayerState
    extends State<AutoPlayVisibleVideoPlayer> {
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

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1.0) {
      // Video is fully visible, play the video
      _controller.play();
    } else if (info.visibleFraction < 0.7) {
      // Video is less than 50% visible, pause the video
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isInteractive) {
      return VisibilityDetector(
        key: Key(widget.videoUrl),
        onVisibilityChanged: _handleVisibilityChanged,
        child: Container(
          color: Colors.black,
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CustomVideoPlayer(
                      customVideoPlayerController:
                          _customVideoPlayerController),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: _handleVisibilityChanged,
      child: Container(
        color: Colors.black,
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: videoPlayer.VideoPlayer(_controller),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
