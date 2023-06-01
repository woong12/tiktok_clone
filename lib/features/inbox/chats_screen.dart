import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/sizes.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text("Direct messages"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              foregroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1685027172781-d7bdd558cf6b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80"),
              child: Text("woong"),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Bob  ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "2:16 PM",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: Sizes.size12 + Sizes.size1,
                  ),
                ),
              ],
            ),
            subtitle: const Text("Good morning friend!"),
          ),
        ],
      ),
    );
  }
}
