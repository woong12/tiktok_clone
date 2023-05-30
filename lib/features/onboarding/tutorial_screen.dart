import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import '../../constants/sizes.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;
  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // to the right
      setState(() {
        _direction = Direction.right;
      });
    } else {
      // to the left
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: SafeArea(
            child: AnimatedCrossFade(
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    "Swipe right",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(
                      fontSize: Sizes.size20 + Sizes.size2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Gaps.v52,
                  Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage("assets/images/tutorial1.png"),
                      width: 300,
                      height: 450,
                    ),
                  )
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    "Watch videos",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(
                      fontSize: Sizes.size20 + Sizes.size2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Gaps.v52,
                  Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage("assets/images/tutorial2.png"),
                      width: 300,
                      height: 430,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size24,
              horizontal: Sizes.size32,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showingPage == Page.first ? 0 : 1,
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size16,
                ),
                onPressed: _onEnterAppTap,
                borderRadius: BorderRadius.circular(2),
                color: Theme.of(context).primaryColor,
                child: const Text(
                  "Start watching",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
