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
    return CustomScrollView(
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
              Gaps.v10,
              const CircleAvatar(
                radius: 50,
                foregroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1683394230814-69e5141bf06a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80",
                ),
                child: Text("woong"),
              ),
              Gaps.v10,
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
              Gaps.v16,
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
            ],
          ),
        )
      ],
    );
  }
}
