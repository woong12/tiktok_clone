import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/common/widgets/theme_configuration/theme_config.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/router.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(
    ProviderScope(
      overrides: [
        playbackConfigProvider
            .overrideWith(() => PlaybackConfigViewModel(repository)),
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    S.load(const Locale("en"));
    return ValueListenableBuilder(
      valueListenable: useDarkThemeConfig,
      builder: (context, value, child) => MaterialApp.router(
        themeMode: useDarkThemeConfig.value ? ThemeMode.dark : ThemeMode.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'TikTok Clone',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en"),
          Locale("ko"),
        ],
        theme: ThemeData(
          useMaterial3: true,
          textTheme: Typography.blackMountainView,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade50,
          ),
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
          tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          tabBarTheme: TabBarTheme(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade700,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          textTheme: Typography.whiteMountainView,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade900,
            surfaceTintColor: Colors.grey.shade900,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
            iconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
          ),
          primaryColor: const Color(0xFFE9435A),
          brightness: Brightness.dark,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
        ),
        // home: const SignUpScreen(),
        // main page: MainNavigationSCreen()
      ),
    );
  }
}
