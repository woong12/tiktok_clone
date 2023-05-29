import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size10,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text(
            "22796 comments",
            style: TextStyle(
              fontSize: Sizes.size14 + Sizes.size1,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            IconButton(
                onPressed: _onClosePressed,
                icon: const Icon(Icons.close_rounded)),
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            child: const Text("im a comment"),
          ),
        ),
      ),
    );
  }
}
