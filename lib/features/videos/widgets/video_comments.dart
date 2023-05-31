import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

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
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          toolbarHeight: 45,
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "22796 comments",
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Colors.black,
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
              Scrollbar(
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
                      const CircleAvatar(
                        radius: 18,
                        child: Text("AA"),
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
                            Row(
                              children: const [
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
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                      vertical: Sizes.size10,
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
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
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
                                fillColor: Colors.grey.shade100,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12,
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.at,
                                      color: Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    FaIcon(
                                      FontAwesomeIcons.gift,
                                      color: Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      color: Colors.grey.shade900,
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
                                            color:
                                                Theme.of(context).primaryColor,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
