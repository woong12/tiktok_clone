import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';

class FriendTile extends StatelessWidget {
  final String name;
  final String friendProfileImg;

  const FriendTile({
    super.key,
    required this.name,
    required this.friendProfileImg,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          Positioned(
            child: Container(
              padding: const EdgeInsets.all(2),
              width: 54,
              height: 54,
              child: CircleAvatar(
                radius: 26,
                foregroundImage: NetworkImage(
                  friendProfileImg,
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              width: 20,
              height: 20,
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
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: const Text(
        "Active now",
        style: TextStyle(
          fontSize: Sizes.size14,
        ),
      ),
      trailing: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "04/16/2023",
            style: TextStyle(
              color: Colors.black38,
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(""),
        ],
      ),
    );
  }
}
