import 'package:flutter/material.dart';
import 'package:scoreboard/edit_scores/edit_scores_provider.dart';
import 'package:scoreboard/login/login.dart';
import 'package:scoreboard/user/user.dart';

import '../services/auth.dart';
import '../settings/settings.dart';

AppBar getAppBar(BuildContext context, String title,
    [bool settingsVisisble = true]) {
  return AppBar(
    title: Row(
      children: [
        const Image(
            image: AssetImage(
              'studverthi.png',
            ),
            height: 35),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    actions: [
      // Visibility(
      //   visible: AuthService().user != null && settingsVisisble,
      //   child: Tooltip(
      //     message: 'Scores bearbeiten',
      //     child: IconButton(
      //       onPressed: () {
      //         var user = AuthService().user;

      //         if (user != null) {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => const EditScoresProvider(),
      //             ),
      //           );
      //         }
      //       },
      //       icon: const Icon(Icons.edit_note_rounded),
      //     ),
      //   ),
      // ),
      Visibility(
        visible: settingsVisisble,
        child: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SettingsPage();
            }));

            // themeNotifier.toggleTheme();

            // final prefs = await SharedPreferences.getInstance();
            // prefs.setBool('theme', themeNotifier.isDark);
          },
          icon: const Icon(Icons.settings_rounded),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
      ),
    ],
  );
}
