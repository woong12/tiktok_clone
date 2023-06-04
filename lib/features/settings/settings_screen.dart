import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("settings"),
      ),
      body: Column(
        children: const [
          CupertinoActivityIndicator(
            radius: 40,
          ),
          CircularProgressIndicator.adaptive(),
        ],
      ),

      // ListWheelScrollView(
      //   diameterRatio: 1,
      //   offAxisFraction: 2,
      //   itemExtent: 200,
      //   children: [
      //     for (var x in [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
      //       FractionallySizedBox(
      //         widthFactor: 1,
      //         child: Container(
      //           color: Colors.teal,
      //           alignment: Alignment.center,
      //           child: const Text(
      //             "Pick me",
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: Sizes.size40,
      //             ),
      //           ),
      //         ),
      //       ),
      //   ],
      // ),
    );
  }
}
