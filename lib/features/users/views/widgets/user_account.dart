import 'package:flutter/material.dart';

import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class UserAccount extends StatelessWidget {
  final String number;
  final String infoWord;

  const UserAccount({
    super.key,
    required this.number,
    required this.infoWord,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: Sizes.size16 + Sizes.size1,
          ),
        ),
        Gaps.v3,
        Text(
          infoWord,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Sizes.size12 + Sizes.size1,
          ),
        ),
      ],
    );
  }
}
