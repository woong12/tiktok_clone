import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class PostVideoButton extends StatefulWidget {
  const PostVideoButton({super.key});

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 22,
          child: Container(
            height: 33.5,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff61d4f0),
              borderRadius: BorderRadius.circular(
                Sizes.size10,
              ),
            ),
          ),
        ),
        Positioned(
          left: 22,
          child: Container(
            height: 33.5,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                Sizes.size10,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              Sizes.size8 + Sizes.size1,
            ),
          ),
          height: 33.5,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size12,
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: Colors.black,
              size: 21,
            ),
          ),
        )
      ],
    );
  }
}
