import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/breakpoint.dart';
import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class MyVideos extends StatelessWidget {
  final String imageUrl;

  const MyVideos({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GridView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.zero,
      itemCount: 21,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width > Breakpoints.md ? 5 : 3,
        crossAxisSpacing: Sizes.size2,
        mainAxisSpacing: Sizes.size2,
        childAspectRatio: 9 / 12.5,
      ),
      itemBuilder: (context, index) => Column(
        children: [
          AspectRatio(
            aspectRatio: 9 / 12.5,
            child: Stack(
              children: [
                FadeInImage.assetNetwork(
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  placeholder: "assets/images/placeholder.jpg",
                  image:
                      // "https://images.unsplash.com/photo-1683229903327-d3ffbe2f0da4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80",
                      imageUrl,
                ),
                index == 0
                    ? Positioned(
                        top: Sizes.size4,
                        left: Sizes.size4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size4,
                            vertical: Sizes.size3,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Sizes.size3),
                            ),
                          ),
                          child: const Text(
                            "Pinned",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: Sizes.size12,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                const Positioned(
                  bottom: 5,
                  left: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.play,
                        color: Colors.white,
                        size: Sizes.size14 + Sizes.size1,
                      ),
                      Gaps.h8,
                      Text(
                        "4.1M",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size12,
                        ),
                      ),
                    ],
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
