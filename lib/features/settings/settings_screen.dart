import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoint.dart';
import 'package:tiktok_clone/features/authentication/repos/authenrication_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

import '../../common/widgets/theme_configuration/theme_config.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).muted,
                  onChanged: (value) =>
                      ref.read(playbackConfigProvider.notifier).setMuted(value),
                  title: const Text("Mute Video"),
                  subtitle: const Text("Videos will be muted by default."),
                ),
                SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).autoplay,
                  onChanged: (value) => ref
                      .read(playbackConfigProvider.notifier)
                      .setAutoplay(value),
                  title: const Text("Autoplay"),
                  subtitle:
                      const Text("Videos will start playing automatically."),
                ),
                ValueListenableBuilder(
                  valueListenable: useDarkThemeConfig,
                  builder: (context, value, child) => SwitchListTile.adaptive(
                    value: useDarkThemeConfig.value,
                    onChanged: (value) =>
                        useDarkThemeConfig.value = !useDarkThemeConfig.value,
                    title: const Text('Dark mode'),
                  ),
                ),
                /* SwitchListTile.adaptive(
                  value: false,
                  onChanged: (value) {},
                  title: const Text("Enable notifications"),
                  subtitle: const Text("They will be cute."),
                ),
                SwitchListTile.adaptive(
                  value: false,
                  onChanged: (value) {},
                  title: const Text("Marketing emails"),
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
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (kDebugMode) {
                      print(time);
                    }
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
                ), */
                const AboutListTile(
                  applicationVersion: "1.0",
                  applicationLegalese: "Don't copy me.",
                  child: Text("About TikTok"),
                ),
                ListTile(
                  title: const Text("Log out"),
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
                            onPressed: () {
                              ref.read(authRepo).signOut();
                              context.go("/");
                            },
                            isDestructiveAction: true,
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
