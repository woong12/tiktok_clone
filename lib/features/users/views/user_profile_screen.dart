import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoint.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/views/user_profile_edit_screen.dart';
import 'package:tiktok_clone/features/users/views/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/views/widgets/contact_btn.dart';
import 'package:tiktok_clone/features/users/views/widgets/my_videos.dart';
import 'package:tiktok_clone/features/users/views/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/views/widgets/user_account.dart';
import 'package:tiktok_clone/utils.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen>
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

  void _onEditPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserProfileEditScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDark = isDarkMode(context);

    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: Breakpoints.lg,
                    ),
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverAppBar(
                            title: Text(data.name),
                            centerTitle: true,
                            actions: [
                              IconButton(
                                onPressed: _onEditPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: Sizes.size20,
                                ),
                              ),
                              IconButton(
                                onPressed: _onGearPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.gear,
                                  size: Sizes.size20,
                                ),
                              ),
                            ],
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: width < Breakpoints.md
                                  ? [
                                      Gaps.v20,
                                      Avatar(
                                        uid: data.uid,
                                        name: data.name,
                                        hasAvatar: data.hasAvatar,
                                      ),
                                      Gaps.v8,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "@${data.name}",
                                            style: const TextStyle(
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
                                        height: Sizes.size48,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const UserAccount(
                                              number: "37",
                                              infoWord: "Following",
                                            ),
                                            VerticalDivider(
                                              width: Sizes.size32 + Sizes.size2,
                                              thickness: Sizes.size1,
                                              color: Colors.grey.shade200,
                                              indent: Sizes.size12,
                                              endIndent: Sizes.size12,
                                            ),
                                            const UserAccount(
                                              number: "10.5M",
                                              infoWord: "Followers",
                                            ),
                                            VerticalDivider(
                                              width: Sizes.size32 + Sizes.size2,
                                              thickness: Sizes.size1,
                                              color: Colors.grey.shade200,
                                              indent: Sizes.size12,
                                              endIndent: Sizes.size12,
                                            ),
                                            const UserAccount(
                                              number: "149.3M",
                                              infoWord: "Likes",
                                            ),
                                          ],
                                        ),
                                      ),
                                      Gaps.v12,
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                            maxWidth: Breakpoints.ssm),
                                        child: FractionallySizedBox(
                                          widthFactor: 0.64,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: Sizes.size14,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      Sizes.size10,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Follow",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Sizes.size16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              Gaps.h4,
                                              const ContactBtn(
                                                icon: FontAwesomeIcons.youtube,
                                                size:
                                                    Sizes.size20 + Sizes.size2,
                                                paddingh: Sizes.size12,
                                                paddingv:
                                                    Sizes.size12 + Sizes.size1,
                                              ),
                                              Gaps.h4,
                                              const ContactBtn(
                                                icon:
                                                    FontAwesomeIcons.caretDown,
                                                size: Sizes.size18,
                                                paddingh: Sizes.size18,
                                                paddingv:
                                                    Sizes.size14 + Sizes.size1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Gaps.v12,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: Sizes.size40,
                                        ),
                                        child: Text(
                                          data.bio,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Gaps.v8,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.link,
                                            size: Sizes.size12,
                                          ),
                                          Gaps.h4,
                                          Text(
                                            data.link,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  Sizes.size12 + Sizes.size1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gaps.v20,
                                    ]
                                  : [
                                      Gaps.v28,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Gaps.h52,
                                          Avatar(
                                            uid: data.uid,
                                            name: data.name,
                                            hasAvatar: data.hasAvatar,
                                          ),
                                          Gaps.h40,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "@${data.name}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: Sizes.size18,
                                                    ),
                                                  ),
                                                  Gaps.h5,
                                                  FaIcon(
                                                    FontAwesomeIcons
                                                        .solidCircleCheck,
                                                    size: Sizes.size12 +
                                                        Sizes.size1,
                                                    color: Colors
                                                        .lightBlue.shade300,
                                                  ),
                                                  Gaps.h40,
                                                  SizedBox(
                                                    height: Sizes.size44 +
                                                        Sizes.size2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const UserAccount(
                                                          number: "37",
                                                          infoWord: "Following",
                                                        ),
                                                        VerticalDivider(
                                                          width: Sizes.size32 +
                                                              Sizes.size2,
                                                          thickness:
                                                              Sizes.size1,
                                                          color: Colors
                                                              .grey.shade200,
                                                          indent: Sizes.size12,
                                                          endIndent:
                                                              Sizes.size12,
                                                        ),
                                                        const UserAccount(
                                                          number: "10.5M",
                                                          infoWord: "Followers",
                                                        ),
                                                        VerticalDivider(
                                                          width: Sizes.size32 +
                                                              Sizes.size2,
                                                          thickness:
                                                              Sizes.size1,
                                                          color: Colors
                                                              .grey.shade200,
                                                          indent: Sizes.size12,
                                                          endIndent:
                                                              Sizes.size12,
                                                        ),
                                                        const UserAccount(
                                                          number: "149.3M",
                                                          infoWord: "Likes",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gaps.v10,
                                              ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                  maxWidth: Breakpoints.ssm,
                                                ),
                                                child: FractionallySizedBox(
                                                  widthFactor: 0.64,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical:
                                                                Sizes.size14,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              Sizes.size10,
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Follow",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  Sizes.size16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                      Gaps.h4,
                                                      const ContactBtn(
                                                        icon: FontAwesomeIcons
                                                            .youtube,
                                                        size: Sizes.size20 +
                                                            Sizes.size2,
                                                        paddingh: Sizes.size12,
                                                        paddingv: Sizes.size12 +
                                                            Sizes.size1,
                                                      ),
                                                      Gaps.h4,
                                                      const ContactBtn(
                                                        icon: FontAwesomeIcons
                                                            .caretDown,
                                                        size: Sizes.size18,
                                                        paddingh: Sizes.size18,
                                                        paddingv: Sizes.size14 +
                                                            Sizes.size1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Gaps.v12,
                                              Column(
                                                children: [
                                                  Text(
                                                    data.bio,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Gaps.v8,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const FaIcon(
                                                        FontAwesomeIcons.link,
                                                        size: Sizes.size12,
                                                      ),
                                                      Gaps.h4,
                                                      Text(
                                                        data.link,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              Sizes.size12 +
                                                                  Sizes.size1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Gaps.v20,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                            ),
                          ),
                          SliverPersistentHeader(
                            delegate: PersistentTabBar(),
                            pinned: true,
                          ),
                        ];
                      },
                      body: const TabBarView(
                        children: [
                          MyVideos(
                            imageUrl:
                                "https://images.unsplash.com/photo-1683229903327-d3ffbe2f0da4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80",
                          ),
                          MyVideos(
                            imageUrl:
                                "https://images.unsplash.com/photo-1576542260349-626bf55262a8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80",
                          ),
                        ],
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
