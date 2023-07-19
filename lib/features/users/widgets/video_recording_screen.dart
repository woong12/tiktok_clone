import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _permissionDenied = false;

  bool _isSelfieMode = false;

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
    initPermissions();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: _permissionDenied
            ? const CameraStatus(
                status: "Permission Denied\n Setting > App > Turn on Camera",
              )
            : !_hasPermission || !_cameraController.value.isInitialized
                ? const CameraStatus(status: "Initializing...")
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      CameraPreview(_cameraController),
                      Positioned(
                        top: Sizes.size20,
                        right: Sizes.size20,
                        child: Column(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: _toggleSelfieMode,
                              icon: const Icon(
                                Icons.cameraswitch,
                              ),
                            ),
                            Gaps.v10,
                            flashStatus(
                              Colors.amber.shade200,
                              Colors.white,
                              Icons.flash_off_rounded,
                              FlashMode.off,
                            ),
                            Gaps.v10,
                            flashStatus(
                              Colors.amber.shade200,
                              Colors.white,
                              Icons.flash_on_rounded,
                              FlashMode.always,
                            ),
                            Gaps.v10,
                            flashStatus(
                              Colors.amber.shade200,
                              Colors.white,
                              Icons.flash_auto_rounded,
                              FlashMode.auto,
                            ),
                            Gaps.v10,
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
          ),
        ),
        Gaps.v20,
        const CircularProgressIndicator.adaptive()
      ],
    );
  }
}
