import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:tiktok_clone/constants/breakpoint.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../common/widgets/video_configuration/video_config.dart';
import '../../../generated/l10n.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    Key? key,
    required this.onVideoFinished,
    required this.index,
  }) : super(key: key);

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> with TickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  bool _isPaused = false;

  bool _autoMute = videoConfig.autoMute;

  bool showMore = false;

  bool volumeHigh = false;

  // Create a controller
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: false);

  // Create an animation with value of type "double"
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  // #Hashtags
  final String _hashtags =
      "#Island #SkyView #Ocean #Sky #NiceView #Good #Awesome #BeautifulSky";

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/video.mp4");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
      volumeHigh = true;
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  // Volumn

  void onVolumnControl() {
    if (volumeHigh == true) {
      _videoPlayerController.setVolume(1);
    } else {
      _videoPlayerController.setVolume(0);
    }
    setState(() {
      volumeHigh = !volumeHigh;
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );

    videoConfig.addListener(() {
      setState(() {
        _autoMute = videoConfig.autoMute;
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    _controller.dispose();

    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  // Pause and Play
  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });

    if (_isPaused) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  // Commnet Tap
  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: Breakpoints.sm),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white.withOpacity(0.9),
                      size: Sizes.size60,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Description Section

          Positioned(
            bottom: 20,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Woong",
                  style: TextStyle(
                    fontSize: Sizes.size16 + Sizes.size2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    Text(
                      "Flying Over Island",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gaps.h5,
                    const Text(
                      "☁️",
                      style: TextStyle(
                        fontSize: Sizes.size24 + Sizes.size2,
                      ),
                    )
                  ],
                ),
                Gaps.v1,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 230,
                          child: AnimatedCrossFade(
                            duration: const Duration(milliseconds: 200),
                            firstChild: Text(
                              _hashtags,
                              style: const TextStyle(
                                fontSize: Sizes.size16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            secondChild: Text(
                              _hashtags,
                              style: const TextStyle(
                                fontSize: Sizes.size16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                            crossFadeState: showMore
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                          ),
                        ),
                        Gaps.h3,
                        InkWell(
                          onTap: () {
                            setState(() {
                              showMore = !showMore;
                            });
                          },
                          child: Text(
                            showMore ? "Hide" : "See more",
                            style: const TextStyle(
                              fontSize: Sizes.size16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gaps.v14,
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.music,
                      size: Sizes.size16 + Sizes.size2,
                      color: Colors.white,
                    ),
                    Gaps.h10,
                    Visibility(
                      visible: _isPaused,
                      replacement: SizedBox(
                        width: 180,
                        height: 20,
                        child: Marquee(
                          text: "original sound (TikTok Tunes)",
                          style: const TextStyle(
                            fontSize: Sizes.size16 + Sizes.size1,
                            color: Colors.white,
                          ),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 25.0,
                          velocity: 20.0,
                          fadingEdgeStartFraction: 0.1,
                          fadingEdgeEndFraction: 0.1,
                        ),
                      ),
                      child: const SizedBox(
                        width: 180,
                        height: 20,
                        child: Text(
                          "original sound (TikTokTunes)",
                          style: TextStyle(
                            fontSize: Sizes.size16 + Sizes.size1,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Volume control

          Positioned(
            right: 10,
            top: 50,
            child: IconButton(
              highlightColor: Colors.transparent,
              // icon: volumeHigh
              //     ? const FaIcon(
              //         FontAwesomeIcons.volumeXmark,
              //         color: Colors.white,
              //       )
              //     : const FaIcon(
              //         FontAwesomeIcons.volumeHigh,
              //         color: Colors.white,
              //       ),
              icon: FaIcon(
                _autoMute
                    ? FontAwesomeIcons.volumeXmark
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: videoConfig.toggleAutoMute,
              // onPressed: onVolumnControl,
            ),
          ),

          // Buttons

          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 27,
                          foregroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1683394230814-69e5141bf06a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      child: Container(
                        alignment: Alignment.center,
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                          size: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(9237583),
                ),
                Gaps.v16,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidCommentDots,
                    text: S.of(context).commentCount(542315),
                  ),
                ),
                Gaps.v16,
                VideoButton(
                  icon: FontAwesomeIcons.solidBookmark,
                  text: S.of(context).bookmarkCount(32738),
                ),
                Gaps.v16,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
                Gaps.v20,
                RotationTransition(
                  turns: _animation,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Colors.black87,
                        width: 8,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      foregroundImage: NetworkImage(
                        "https://yt3.googleusercontent.com/FOi0MWjdU9Gw8ZjsSHTAXPuz6tk3QYwQNKzFSVaf3LjOgFuBLwpMuHOg2KFCixegcIk3foKeTQ=s900-c-k-c0x00ffffff-no-rj",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
