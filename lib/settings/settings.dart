import 'package:flutter/material.dart';
import 'package:scoreboard/edit_scores/edit_scores_provider.dart';
import 'package:scoreboard/login/login.dart';
import 'package:scoreboard/shared/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/auth.dart';
import '../services/config.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Uri _uri = Uri.parse("https://neuland-ingolstadt.de/");

  @override
  Widget build(BuildContext context) {
    var headerSize = 16.0;

    var user = AuthService().user;

    Future<void> launchURL() async {
      await launchUrl(_uri);
    }

    return Scaffold(
      appBar: getAppBar(context, 'Einstellungen', false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Personalisierung',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.color_lens_rounded),
                ),
                Expanded(
                  child: Text('Dark Mode',
                      style: TextStyle(
                        fontSize: headerSize,
                      )),
                ),
                Switch(
                  value: themeNotifier.isDark,
                  onChanged: (value) async {
                    setState(() {
                      themeNotifier.setTheme(value);
                    });

                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('theme', themeNotifier.isDark);
                  },
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Allgemein',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Visibility(
              visible: user == null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.person_rounded),
                  ),
                  Expanded(
                    child: Text('Mitgliederbereich',
                        style: TextStyle(
                          fontSize: headerSize,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      },
                      icon: const Icon(Icons.login_rounded),
                      label: const Text("Anmelden"),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: user != null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.games_rounded),
                  ),
                  Expanded(
                    child: Text('Spieleinstellungen',
                        style: TextStyle(
                          fontSize: headerSize,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const EditScoresProvider();
                        }));
                      },
                      icon: const Icon(Icons.edit_rounded),
                      label: const Text("Punkte eintragen"),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
            ),
            Visibility(
              visible: user != null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.person_rounded),
                  ),
                  Expanded(
                    child: Text('Mitgliederbereich',
                        style: TextStyle(
                          fontSize: headerSize,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: FilledButton.icon(
                      onPressed: () {
                        setState(() {
                          AuthService().logoutUser();
                        });
                      },
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text("Abmelden"),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  launchURL();
                },
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    themeNotifier.isDark ? Colors.white : Colors.black,
                    BlendMode.srcIn,
                  ),
                  child: const Image(
                    image: AssetImage(
                      'neuland.png',
                    ),
                    height: 75,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
