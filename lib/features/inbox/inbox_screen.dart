import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/utils.dart';

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
        ],
      ),
    );
  }
}
