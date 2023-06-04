import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("settings"),
      ),
      body: ListView(
        children: const [
          // ListTile(
          //   onTap: () => showAboutDialog(
          //       context: context,
          //       applicationVersion: "1.0",
          //       applicationLegalese:
          //           "All rights reserved. Please don't copy me."),
          //   title: const Text(
          //     "About",
          //     style: TextStyle(
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          //   subtitle: const Text("About this app....."),
          // ),
          AboutListTile()
        ],
      ),
    );
  }
}
