import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handdx/ui/screens/home_screen.dart';
import 'package:handdx/ui/util/ui_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: HandDxApp()));
}

class HandDxApp extends HookWidget {
  const HandDxApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Need to wrap the CupertinoApp with MaterialApp so we can override some Material colors, and still use Material widgets
    // Also, cupertinoOverrideTheme alone is not enough since MaterialApp can't use Apple font families
    return MaterialApp(
      title: "HandyApp",
      theme: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
            barBackgroundColor: UiColors.barBackgroundColor,
            scaffoldBackgroundColor: UiColors.backgroundColor,
            brightness: usePlatformBrightness(),
            textTheme: const CupertinoTextThemeData(
              primaryColor: UiColors.accentAlt,
              actionTextStyle: TextStyle(color: UiColors.accentAlt),
            )),
        canvasColor: UiColors.backgroundColor,
        scaffoldBackgroundColor: UiColors.backgroundColor,
      ),
      home: CupertinoApp(
          theme: CupertinoThemeData(
              barBackgroundColor: UiColors.barBackgroundColor,
              scaffoldBackgroundColor: UiColors.backgroundColor,
              brightness: usePlatformBrightness(),
              textTheme: const CupertinoTextThemeData(
                primaryColor: UiColors.accentAlt,
                actionTextStyle: TextStyle(color: UiColors.accentAlt),
              )),
          home: const HomeScreen()),
    );
  }
}
