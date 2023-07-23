import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/breakpoint.dart';

import '../../common/widgets/video_configuration/video_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("settings"),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: ListView(
              children: [
                AnimatedBuilder(
                  animation: videoConfig,
                  builder: (context, child) => SwitchListTile.adaptive(
                    value: videoConfig.autoMute,
                    onChanged: (value) {
                      videoConfig.toggleAutoMute();
                    },
                    title: const Text("Mute Video"),
                    subtitle: const Text("Videos will be muted by default."),
                  ),
                ),
                SwitchListTile.adaptive(
                  value: _notifications,
                  onChanged: _onNotificationsChanged,
                  title: const Text("Enable notifications"),
                  subtitle: const Text("They will be cute."),
                ),
                CheckboxListTile(
                  activeColor: Colors.black,
                  value: _notifications,
                  onChanged: _onNotificationsChanged,
                  title: const Text("Marketing emials"),
                  subtitle: const Text("We won't spam you."),
                ),
                ListTile(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                    );
                    if (kDebugMode) {
                      print(date);
                    }
                    if (!mounted) return;
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (kDebugMode) {
                      print(time);
                    }
                    if (!mounted) return;
                    final booking = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            appBarTheme: const AppBarTheme(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (kDebugMode) {
                      print(booking);
                    }
                  },
                  title: const Text("What is your birthday?"),
                  subtitle: const Text("I need to know!"),
                ),
                ListTile(
                  title: const Text("Log out (iOS)"),
                  textColor: Colors.red,
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("Are you sure?"),
                        content: const Text("Good Bye"),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("No"),
                          ),
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            isDestructiveAction: true,
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Log out (Android)"),
                  textColor: Colors.red,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Are you sure?"),
                        content: const Text("Good Bye"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Log out (iOS / bottom)"),
                  textColor: Colors.red,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: const Text("Are you sure?"),
                        message: const Text("Good Bye"),
                        actions: [
                          CupertinoActionSheetAction(
                            isDefaultAction: true,
                            onPressed: () {},
                            child: const Text("No"),
                          ),
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            onPressed: () {},
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const AboutListTile(
                  applicationVersion: "1.0",
                  applicationLegalese: "Don't copy me.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
