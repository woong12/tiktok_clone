import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

import '../../../../constants/breakpoint.dart';
import '../../../../constants/gaps.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.73,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size10,
        ),
      ),
      child: Scaffold(
        backgroundColor: isDark ? null : Colors.grey.shade50,
        appBar: AppBar(
          toolbarHeight: 45,
          backgroundColor: isDark ? null : Colors.grey.shade50,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            S.of(context).commentTitle(542315, 542315),
            style: const TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: _onClosePressed,
              icon: const Icon(Icons.close_rounded),
            ),
            const SizedBox(
              width: Sizes.size4,
            ),
          ],
        ),

        // Input

        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size18,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: Sizes.size44,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(
                      Sizes.size8,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size14,
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Top Gifts",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Sizes.size52),
                child: Scrollbar(
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    separatorBuilder: (context, index) => Gaps.v20,
                    padding: const EdgeInsets.only(
                      top: Sizes.size10,
                      bottom: Sizes.size20 + Sizes.size96,
                      left: Sizes.size14,
                      right: Sizes.size14,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: isDark ? Colors.grey.shade500 : null,
                          child: const Text("AA"),
                        ),
                        Gaps.h8,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "woong",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Sizes.size14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Gaps.v5,
                              const Text(
                                "That's not it l've seen the same thing but also in a cave",
                                style: TextStyle(
                                  fontSize: Sizes.size16,
                                ),
                              ),
                              Gaps.v8,
                              Row(
                                children: [
                                  Text(
                                    "1-18",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w300,
                                      fontSize: Sizes.size12 + Sizes.size1,
                                    ),
                                  ),
                                  Gaps.h10,
                                  Text(
                                    "Reply",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: Sizes.size14,
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.v10,
                              const Row(
                                children: [
                                  Text(
                                    "View replies (194)",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: Sizes.size14,
                                    ),
                                  ),
                                  Gaps.h3,
                                  FaIcon(
                                    FontAwesomeIcons.chevronDown,
                                    size: Sizes.size14,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gaps.h10,
                        Column(
                          children: [
                            const SizedBox(height: Sizes.size4),
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size20 + Sizes.size1,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.v2,
                            Text(
                              "52.2K",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: Breakpoints.sm),
                  child: Positioned(
                    bottom: 0,
                    width: size.width,
                    child: Container(
                      color: isDark ? Colors.grey.shade900 : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: Sizes.size16,
                          right: Sizes.size16,
                          top: Sizes.size10,
                          bottom: Sizes.size40,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey.shade500,
                              foregroundColor: Colors.white,
                              child: const Text("AA"),
                            ),
                            Gaps.h10,
                            Expanded(
                              child: SizedBox(
                                height: Sizes.size44,
                                child: TextField(
                                  onTap: _onStartWriting,
                                  expands: true,
                                  minLines: null,
                                  maxLines: null,
                                  textInputAction: TextInputAction.newline,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    hintText: "Add comment...",
                                    hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: Sizes.size16 + Sizes.size1,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size10,
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: isDark
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade200,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size12,
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.at,
                                          color: isDark
                                              ? Colors.grey.shade500
                                              : Colors.grey.shade900,
                                        ),
                                        Gaps.h14,
                                        FaIcon(
                                          FontAwesomeIcons.gift,
                                          color: isDark
                                              ? Colors.grey.shade500
                                              : Colors.grey.shade900,
                                        ),
                                        Gaps.h14,
                                        FaIcon(
                                          FontAwesomeIcons.faceSmile,
                                          color: isDark
                                              ? Colors.grey.shade500
                                              : Colors.grey.shade900,
                                        ),
                                        Gaps.h14,
                                        if (_isWriting)
                                          GestureDetector(
                                            onTap: _stopWriting,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: Sizes.size10,
                                              ),
                                              child: FaIcon(
                                                FontAwesomeIcons.circleArrowUp,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
