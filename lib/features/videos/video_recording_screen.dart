import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _permissionDenied = false;

  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  double _currentZoom = 1.0;
  final double _minZoom = 1.0;
  final double _maxZoom = 4.0;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late FlashMode _flashMode;

  late CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
    } else {
      _permissionDenied = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  void _handleZooming(DragUpdateDetails details) {
    double sensitivity = 0.005;

    _currentZoom -= details.delta.dy * sensitivity;
    _currentZoom = _currentZoom.clamp(_minZoom, _maxZoom);

    _cameraController.setZoomLevel(_currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _permissionDenied
            ? const CameraStatus(
                status: "Permission Denied\n Setting > App > Turn on Camera",
              )
            : !_hasPermission
                ? const CameraStatus(status: "Initializing...")
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      const Positioned(
                        top: Sizes.size40,
                        left: Sizes.size20,
                        child: CloseButton(
                          color: Colors.white,
                        ),
                      ),
                      if (!_noCamera && _cameraController.value.isInitialized)
                        CameraPreview(
                          _cameraController,
                          child: Stack(
                            children: [
                              if (!_noCamera)
                                Positioned(
                                  top: Sizes.size10,
                                  right: Sizes.size10,
                                  child: Column(
                                    children: [
                                      IconButton(
                                        color: Colors.white,
                                        onPressed: _toggleSelfieMode,
                                        icon: const Icon(
                                          Icons.cameraswitch,
                                        ),
                                      ),
                                      Gaps.v5,
                                      flashStatus(
                                        Colors.amber.shade200,
                                        Colors.white,
                                        Icons.flash_off_rounded,
                                        FlashMode.off,
                                      ),
                                      Gaps.v5,
                                      flashStatus(
                                        Colors.amber.shade200,
                                        Colors.white,
                                        Icons.flash_on_rounded,
                                        FlashMode.always,
                                      ),
                                      Gaps.v5,
                                      flashStatus(
                                        Colors.amber.shade200,
                                        Colors.white,
                                        Icons.flash_auto_rounded,
                                        FlashMode.auto,
                                      ),
                                      Gaps.v5,
                                      flashStatus(
                                        Colors.amber.shade200,
                                        Colors.white,
                                        Icons.flashlight_on_rounded,
                                        FlashMode.torch,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: Sizes.size20,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          height: Sizes.size80 + Sizes.size32,
                          child: Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onVerticalDragUpdate: _handleZooming,
                                onTapUp: (details) => _stopRecording(),
                                onTapDown: _startRecording,
                                child: ScaleTransition(
                                  scale: _buttonAnimation,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: Sizes.size80 + Sizes.size4,
                                        height: Sizes.size80 + Sizes.size4,
                                        child: CircularProgressIndicator(
                                          color: Colors.red.shade400,
                                          strokeWidth: Sizes.size6,
                                          value: _progressAnimationController
                                              .value,
                                        ),
                                      ),
                                      Container(
                                        width: Sizes.size72,
                                        height: Sizes.size72,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: _onPickVideoPressed,
                                    icon: const FaIcon(
                                      FontAwesomeIcons.image,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  IconButton flashStatus(onColor, offColor, icon, status) {
    return IconButton(
      color: _flashMode == status ? onColor : offColor,
      onPressed: () => _setFlashMode(status),
      icon: Icon(icon),
    );
  }
}

class CameraStatus extends StatelessWidget {
  final String status;

  const CameraStatus({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          status,
          style: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w400,
          ),
        ),
        Gaps.v20,
        CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
