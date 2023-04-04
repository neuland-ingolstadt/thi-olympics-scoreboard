import 'package:flutter/material.dart';
import 'package:scoreboard/edit_scores/edit_scores_provider.dart';
import 'package:scoreboard/login/login.dart';
import 'package:scoreboard/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';
import '../services/config.dart';

AppBar getAppBar(BuildContext context, [bool loginVisible = false]) {
  return AppBar(
    backgroundColor: themeNotifier.isDark
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.primary,
    foregroundColor: themeNotifier.isDark
        ? Theme.of(context).colorScheme.onPrimaryContainer
        : Theme.of(context).colorScheme.onPrimary,
    title: const Text('Fachschaftsolympiade'),
    actions: [
      Visibility(
        visible: AuthService().user != null && loginVisible,
        child: Tooltip(
          message: 'Scores bearbeiten',
          child: IconButton(
            onPressed: () {
              var user = AuthService().user;

              if (user != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EditScoresProvider(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.edit_note_rounded),
          ),
        ),
      ),
      Visibility(
        visible: loginVisible,
        child: Tooltip(
          message: AuthService().user == null ? 'Login' : 'User',
          child: IconButton(
            onPressed: () {
              var user = AuthService().user;

              if (user == null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserOverview(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.person),
          ),
        ),
      ),
      IconButton(
        onPressed: () async {
          themeNotifier.toggleTheme();

          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('theme', themeNotifier.isDark);
        },
        icon: themeNotifier.isDark
            ? const Icon(Icons.brightness_high)
            : const Icon(Icons.brightness_low),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
      ),
    ],
  );
}
