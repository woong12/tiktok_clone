import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isLiked;

  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
    required this.isLiked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: isLiked ? Colors.red : Colors.white,
          size: Sizes.size32 + Sizes.size2,
        ),
        Gaps.v5,
        Text(
          text,
          style: const TextStyle(
            fontSize: Sizes.size12 + Sizes.size1,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
