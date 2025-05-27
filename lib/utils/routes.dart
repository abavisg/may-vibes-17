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

  // Helper method to navigate to the MoodEntryScreen with a modal-style transition
  static Future<void> navigateToMoodEntry(BuildContext context) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MoodEntryScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutQuart;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  // Helper method to navigate to Settings with a slide-from-right transition
  static Future<void> navigateToSettings(BuildContext context) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeOutQuart;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
