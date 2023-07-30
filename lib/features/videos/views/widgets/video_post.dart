import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:tiktok_clone/constants/breakpoint.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../generated/l10n.dart';
import '../../../users/views/user_profile_screen.dart';
import '../../models/video_model.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final VideoModel videoData;

  final int index;

  const VideoPost({
    Key? key,
    required this.onVideoFinished,
    required this.index,
    required this.videoData,
  }) : super(key: key);

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with TickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  bool _isPaused = false;

  bool showMore = false;

  bool volumeHigh = false;

  bool _isMuted = false;

  // Create a controller
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: false);

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
    _initMuted();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    _controller.dispose();

    super.dispose();
  }

  void _initMuted() {
    final isMuted = ref.read(playbackConfigProvider).muted;
    _setMuted(isMuted);
    setState(() {
      _isMuted = isMuted;
    });
  }

  void _setMuted(bool isMuted) => isMuted
      ? _videoPlayerController.setVolume(0)
      : _videoPlayerController.setVolume(1);

  void _toggleMuted() {
    _setMuted(!_isMuted);
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
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

  void _goProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const UserProfileScreen(username: "woong", tab: "view"),
      ),
    );
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
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
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
                Text(
                  "@${widget.videoData.creator}",
                  style: const TextStyle(
                    fontSize: Sizes.size16 + Sizes.size2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    Text(
                      widget.videoData.description,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
              icon: FaIcon(
                _isMuted
                    ? FontAwesomeIcons.volumeXmark
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: _toggleMuted,
            ),
          ),

          // Buttons

          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _goProfile,
                  child: Stack(
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
                          child: CircleAvatar(
                            radius: 27,
                            foregroundImage: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/tiktok-woong.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media",
                            ),
                            child: Text(widget.videoData.creator),
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
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(widget.videoData.likes),
                ),
                Gaps.v16,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidCommentDots,
                    text: S.of(context).commentCount(widget.videoData.comments),
                  ),
                ),
                Gaps.v16,
                VideoButton(
                  icon: FontAwesomeIcons.solidBookmark,
                  text: S.of(context).bookmarkCount(widget.videoData.bookmarks),
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
