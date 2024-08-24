import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:simap/utills/app_utils.dart';

import '../../../../res/app_colors.dart';
import '../../../widgets/app_custom_text.dart';

class StartTutorial extends StatefulWidget {
  const StartTutorial({super.key});

  @override
  _StartTutorialState createState() => _StartTutorialState();
}

class _StartTutorialState extends State<StartTutorial> {
  late VideoPlayerController _controller;
  bool _isFullscreen = false;
  bool _showControls = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  // Initialize the video and handle errors
  void _initializeVideo() {
    try {
      _controller = VideoPlayerController.network(
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
      )
        ..initialize().then((_) {
          setState(() {}); // Trigger UI update when video is ready
        })
        ..addListener(() {
          if (_controller.value.hasError) {
            setState(() {
              _errorMessage =
                  'Failed to load video: ${_controller.value.errorDescription ?? "Unknown error"}';
            });
          }
        });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullscreen
          ? null
          : AppBar(
              title: const CustomText(
                  text: 'Playing Tutorial', color: AppColors.black),
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: AppColors.black),
            ),
      body: _errorMessage != null
          ? Center(
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          : _buildVideoPlayer(context),
      // floatingActionButton: _showControls && !_isFullscreen
      //     ? FloatingActionButton(
      //   backgroundColor: Colors.redAccent,
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //     color: Colors.white,
      //   ),
      // )
      //  : null,
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildVideoPlayer(BuildContext context) {
    return SizedBox(
      width:
          _isFullscreen ? MediaQuery.of(context).size.width : double.infinity,
      height: _isFullscreen
          ? MediaQuery.of(context).size.height
          : MediaQuery.of(context).size.height * 0.4,
      child: _controller.value.isInitialized
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showControls = !_showControls;
                    });
                  },
                  child: VideoPlayer(_controller),
                ),
                if (_showControls) _buildControls(),
              ],
            )
          : const Center(
              child:
                  CircularProgressIndicator()), // Show loading spinner if not initialized
    );
  }

  Widget _buildControls() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          colors: const VideoProgressColors(
            playedColor: Colors.redAccent,
            bufferedColor: Colors.grey,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
            ),
            Text(
              '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
              style: const TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: Icon(
                _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                color: Colors.white,
              ),
              onPressed: _toggleFullscreen,
            ),
          ],
        ),
      ],
    );
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
      if (_isFullscreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]); // Ensure the screen returns to portrait after exiting video
    super.dispose();
  }
}
