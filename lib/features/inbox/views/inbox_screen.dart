import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

import '../../users/views/widgets/friend_tile.dart';
import 'activity_screen.dart';
import 'chats_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  void _onDmPressed() {
    context.pushNamed(ChatsScreen.routeName);
  }

  void _onActivityTab() {
    context.pushNamed(ActivityScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        title: const Text(
          "Inbox",
          style: TextStyle(
            fontSize: Sizes.size16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _onDmPressed,
            icon: const FaIcon(
              FontAwesomeIcons.message,
              size: Sizes.size20 + Sizes.size2,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade200,
          ),
          ListTile(
            onTap: _onActivityTab,
            title: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.size20,
              ),
              child: Text(
                'Activity',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: isDark ? Colors.white : Colors.black,
              size: Sizes.size14,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade200,
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Sizes.size14,
                  bottom: Sizes.size5,
                  left: Sizes.size16,
                ),
                child: Text(
                  'Messages',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.phone,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'Contacts',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              "Find your contacts",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size24,
                vertical: Sizes.size6,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Sizes.size3),
              ),
              child: const Text(
                "Find",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size12,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'New followers',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              "Messages from followers will appear here",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: isDark ? Colors.white : Colors.black,
              size: Sizes.size14,
            ),
          ),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.boxArchive,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'System Notifications',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              "TikTok: Please check",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Tuesday",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gaps.v10,
                Container(
                  width: Sizes.size10,
                  height: Sizes.size10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                )
              ],
            ),
          ),
          const FriendTile(
            friendProfileImg:
                "https://images.unsplash.com/photo-1638803040283-7a5ffd48dad5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80",
            name: "Leon",
          ),
          const FriendTile(
            name: "Bob",
            friendProfileImg:
                "https://images.unsplash.com/photo-1685027172781-d7bdd558cf6b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80",
          )
        ],
      ),
    );
  }
}
