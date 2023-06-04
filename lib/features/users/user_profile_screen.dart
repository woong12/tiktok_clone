import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Woong"),
            actions: [
              IconButton(
                onPressed: () {},
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
                      const UserAccount(number: "37", infoWord: "Following"),
                      VerticalDivider(
                        width: Sizes.size32 + Sizes.size2,
                        thickness: Sizes.size1,
                        color: Colors.grey.shade200,
                        indent: Sizes.size12,
                        endIndent: Sizes.size12,
                      ),
                      const UserAccount(number: "10.5M", infoWord: "Followers"),
                      VerticalDivider(
                        width: Sizes.size32 + Sizes.size2,
                        thickness: Sizes.size1,
                        color: Colors.grey.shade200,
                        indent: Sizes.size12,
                        endIndent: Sizes.size12,
                      ),
                      const UserAccount(number: "149.3M", infoWord: "Likes"),
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.black,
                    indicatorWeight: 1.8,
                    unselectedLabelColor: Colors.grey.shade500,
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                    ),
                    labelColor: Colors.black,
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.size14,
                        ),
                        child: Icon(
                          Icons.grid_3x3_rounded,
                          size: Sizes.size24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.size14,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
