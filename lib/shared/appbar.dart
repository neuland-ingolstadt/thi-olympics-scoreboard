import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/settings.dart';

AppBar getAppBar(BuildContext context, String title,
    [bool settingsVisible = true]) {
  var backShown = Navigator.of(context).canPop();

  return AppBar(
    title: Row(
      children: [
        Visibility(
          visible: !backShown,
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Image(
                image: AssetImage(
                  'logo.png',
                ),
                height: 35),
          ),
        ),
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
      Visibility(
        visible: settingsVisible,
        child: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SettingsPage();
            }));
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
