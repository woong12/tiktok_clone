import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class PostVideoButton extends StatefulWidget {
  final bool inverted;

  const PostVideoButton({
    Key? key,
    required this.onTap,
    required this.inverted,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: Stack(
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
                color: !widget.inverted ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(
                  Sizes.size8 + Sizes.size1,
                ),
              ),
              height: 33.5,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size12,
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: !widget.inverted ? Colors.black : Colors.white,
                  size: 21,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
