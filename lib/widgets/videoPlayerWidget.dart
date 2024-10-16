import 'package:flutter/material.dart';

import 'package:youtube_player_flutter_quill/youtube_player_flutter_quill.dart';
import 'package:demopatient/utilities/color.dart';

class VideoPlayerWidget extends StatefulWidget {
  final videoUrl;

  VideoPlayerWidget({this.videoUrl});
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  YoutubePlayerController? _controller;
  // PlayerState? _playerState;
  // YoutubeMetaData? _videoMetaData;
  // double _volume = 100;
  // bool _muted = false;
  bool _isPlayerReady = false;
  String? _videoId;
  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print("***************************************************8");
    // TODO: implement initState
    _videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    // TODO: implement initState
    _controller = YoutubePlayerController(
      initialVideoId: _videoId??"",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    // _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller!.value.isFullScreen) {
      setState(() {
        // _playerState = _controller!.value.playerState;
        // _videoMetaData = _controller!.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller!,
      showVideoProgressIndicator: true,
      progressColors: ProgressBarColors(
        playedColor: iconsColor,
        handleColor: iconsColor,
      ),
      onReady: () {
        _controller!.addListener(listener);
      },
    );
  }
}
