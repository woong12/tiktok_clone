import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class ChatImoticons extends StatelessWidget {
  final IconData icon;
  final Color color;

  const ChatImoticons({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size16,
        vertical: Sizes.size8,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 232, 232),
        borderRadius: BorderRadius.circular(
          Sizes.size20,
        ),
      ),
      child: Row(
        children: [
          FaIcon(
            icon,
            size: Sizes.size16 + Sizes.size1,
            color: color,
          ),
          Gaps.h3,
          FaIcon(
            icon,
            size: Sizes.size16 + Sizes.size1,
            color: color,
          ),
          Gaps.h3,
          FaIcon(
            icon,
            size: Sizes.size16 + Sizes.size1,
            color: color,
          ),
        ],
      ),
    );
  }
}
