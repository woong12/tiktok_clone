import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");

  final bool _isKeyboardVisible = false;

  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {}
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: _onScaffoldTap,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0.5,
            title: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
            ),
            bottom: TabBar(
              onTap: (value) {
                FocusScope.of(context).unfocus();
              },
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              isScrollable: true,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.black45,
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Sizes.size16,
              ),
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  ),
              ],
            ),
          ),
          body: Listener(
            onPointerMove: (event) {
              if (_isKeyboardVisible) {
                FocusScope.of(context).unfocus();
              }
            },
            child: TabBarView(
              children: [
                GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.all(
                    Sizes.size8,
                  ),
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Sizes.size10,
                    mainAxisSpacing: Sizes.size10,
                    childAspectRatio: 9 / 18.3,
                  ),
                  itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Sizes.size3,
                          ),
                        ),
                        child: AspectRatio(
                          aspectRatio: 9 / 14.3,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/placeholder.jpg",
                            image:
                                "https://images.unsplash.com/photo-1680212703757-2565f02a653e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80",
                          ),
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "Lorem ipsum dolor sit am et, consectetur adipisci ng elit, sed do eiusmod ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gaps.v8,
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1682936366238-b0a5bde0155b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
                            ),
                          ),
                          Gaps.h3,
                          Expanded(
                            child: Text(
                              "Woong_woong0000",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: Sizes.size12 + Sizes.size1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size14 + Sizes.size1,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          Text(
                            "2.5M",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size12 + Sizes.size1,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                for (var tab in tabs.skip(1))
                  Center(
                    child: Text(
                      tab,
                      style: const TextStyle(
                        fontSize: Sizes.size28,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
