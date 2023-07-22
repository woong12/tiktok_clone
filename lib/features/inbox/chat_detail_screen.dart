import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_imoticons.dart';

import '../../utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  bool _isWriting = false;

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
    return GestureDetector(
      onTap: _stopWriting,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          titleSpacing: -10,
          title: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: [
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      width: 50,
                      height: 45,
                      child: const CircleAvatar(
                        radius: 20,
                        foregroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1685027172781-d7bdd558cf6b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80"),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.lightGreenAccent.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.h5,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bob",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Active now",
                    style: TextStyle(
                      fontSize: Sizes.size12 + Sizes.size1,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.flag,
                    color: isDark ? Colors.white : Colors.black,
                    size: Sizes.size20 + Sizes.size1,
                  ),
                  Gaps.h28,
                  FaIcon(
                    FontAwesomeIcons.ellipsis,
                    color: isDark ? Colors.white : Colors.black,
                    size: Sizes.size20,
                  )
                ],
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size24,
              ),
              child: Text(
                "June 16, 2023, 7:22 PM",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w300,
                  fontSize: 13.5,
                ),
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size60,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                        Sizes.size14,
                      ),
                      decoration: BoxDecoration(
                        color: isMine
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(
                            Sizes.size20,
                          ),
                          topRight: const Radius.circular(
                            Sizes.size20,
                          ),
                          bottomLeft: Radius.circular(
                            isMine ? Sizes.size20 : Sizes.size4,
                          ),
                          bottomRight: Radius.circular(
                            isMine ? Sizes.size4 : Sizes.size20,
                          ),
                        ),
                      ),
                      child: const Text(
                        "This is a message",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 7,
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                      vertical: Sizes.size2,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const ChatImoticons(
                              icon: FontAwesomeIcons.solidHeart,
                              color: Colors.red,
                            ),
                            Gaps.h5,
                            ChatImoticons(
                              icon: FontAwesomeIcons.solidFaceSmileBeam,
                              color: Colors.yellow.shade700,
                            ),
                            Gaps.h5,
                            ChatImoticons(
                              icon: FontAwesomeIcons.solidThumbsUp,
                              color: Theme.of(context).primaryColor,
                            ),
                            Gaps.h5,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size12 + Sizes.size1,
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
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: Sizes.size4,
                                      right: Sizes.size3,
                                      top: Sizes.size3,
                                      bottom: Sizes.size3,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: Sizes.size1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size3,
                                      ),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.play,
                                      size: Sizes.size7,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Gaps.h8,
                                  const Text(
                                    "Share post",
                                    style: TextStyle(
                                      fontSize: Sizes.size12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.v5,
                  Container(
                    color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Sizes.size16,
                        right: Sizes.size16,
                        top: Sizes.size10,
                        bottom: Sizes.size36,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.07),
                                    spreadRadius: 20,
                                    blurRadius: 50,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              height: Sizes.size44,
                              child: TextField(
                                onTap: _onStartWriting,
                                expands: true,
                                minLines: null,
                                maxLines: null,
                                textInputAction: TextInputAction.newline,
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  hintText: "Send a message...",
                                  hintStyle: TextStyle(
                                    color: isDark
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade600,
                                    fontWeight: FontWeight.w300,
                                    fontSize: Sizes.size16 + Sizes.size1,
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        Sizes.size20,
                                      ),
                                      topRight: Radius.circular(
                                        Sizes.size20,
                                      ),
                                      bottomLeft: Radius.circular(
                                        Sizes.size20,
                                      ),
                                      bottomRight: Radius.circular(
                                        Sizes.size4,
                                      ),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: isDark
                                      ? Colors.grey.shade800
                                      : Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size12,
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      right: Sizes.size12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.faceSmile,
                                          color: isDark
                                              ? Colors.grey.shade400
                                              : Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Gaps.h12,
                          AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.all(
                              Sizes.size10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Sizes.size20,
                              ),
                              color: _isWriting
                                  ? Theme.of(context).primaryColor
                                  : const Color.fromARGB(208, 215, 215, 215),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.solidPaperPlane,
                              color: Colors.white,
                              size: Sizes.size18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
