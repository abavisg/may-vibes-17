import 'package:flutter/material.dart';
import 'package:tweenvibes/screens/welcome_screen.dart';
import 'package:tweenvibes/screens/sign_up_screen.dart';
import 'package:tweenvibes/screens/mood_entry_screen.dart';
import 'package:tweenvibes/screens/home_screen.dart';
import 'package:tweenvibes/screens/settings_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String signUp = '/sign-up';
  static const String moodEntry = '/mood-entry';
  static const String home = '/home';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      welcome: (context) => const WelcomeScreen(),
      signUp: (context) => const SignUpScreen(),
      moodEntry: (context) => const MoodEntryScreen(),
      home: (context) => const HomeScreen(),
      settings: (context) => const SettingsScreen(),
    };
  }
}
