import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_account.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text("Woong"),
                actions: [
                  IconButton(
                    onPressed: _onGearPressed,
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Gaps.v6,
                    const CircleAvatar(
                      radius: 47,
                      foregroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1683394230814-69e5141bf06a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80",
                      ),
                      child: Text("woong"),
                    ),
                    Gaps.v8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "@woong",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size16,
                          ),
                        ),
                        Gaps.h5,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: Sizes.size12 + Sizes.size1,
                          color: Colors.lightBlue.shade300,
                        ),
                      ],
                    ),
                    Gaps.v14,
                    SizedBox(
                      height: Sizes.size40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const UserAccount(
                              number: "37", infoWord: "Following"),
                          VerticalDivider(
                            width: Sizes.size32 + Sizes.size2,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade200,
                            indent: Sizes.size12,
                            endIndent: Sizes.size12,
                          ),
                          const UserAccount(
                              number: "10.5M", infoWord: "Followers"),
                          VerticalDivider(
                            width: Sizes.size32 + Sizes.size2,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade200,
                            indent: Sizes.size12,
                            endIndent: Sizes.size12,
                          ),
                          const UserAccount(
                              number: "149.3M", infoWord: "Likes"),
                        ],
                      ),
                    ),
                    Gaps.v12,
                    FractionallySizedBox(
                      widthFactor: 0.64,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size14,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(
                                  Sizes.size10,
                                ),
                              ),
                              child: const Text(
                                "Follow",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Gaps.h4,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                              vertical: Sizes.size12 + Sizes.size1,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Sizes.size10,
                              ),
                              color: const Color.fromARGB(255, 236, 236, 243),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.youtube,
                              size: Sizes.size20 + Sizes.size2,
                            ),
                          ),
                          Gaps.h4,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size18,
                              vertical: Sizes.size14 + Sizes.size1,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Sizes.size10,
                              ),
                              color: const Color.fromARGB(255, 236, 236, 243),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.caretDown,
                              size: Sizes.size18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v12,
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size40,
                      ),
                      child: Text(
                        "Enjoy the world's famous tourist attractions!             ⬇️",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Gaps.h4,
                        Text(
                          "https://unsplash.com/t/travel",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Sizes.size12 + Sizes.size1,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v20,
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.zero,
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
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
                                "https://images.unsplash.com/photo-1683229903327-d3ffbe2f0da4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80",
                          ),
                          Positioned(
                            bottom: 5,
                            left: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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
              ),
              const Center(
                child: Text("Page two"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
