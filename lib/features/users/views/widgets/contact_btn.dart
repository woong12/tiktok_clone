import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/sizes.dart';
import '../../../../utils.dart';

class ContactBtn extends StatelessWidget {
  final IconData icon;
  final double size;
  final double paddingv;
  final double paddingh;

  const ContactBtn({
    super.key,
    required this.icon,
    required this.size,
    required this.paddingv,
    required this.paddingh,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingh,
        vertical: paddingv,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size10,
        ),
        color: isDark
            ? Colors.grey.shade800
            : const Color.fromARGB(255, 236, 236, 243),
      ),
      child: FaIcon(
        icon,
        size: size,
      ),
    );
  }
}
