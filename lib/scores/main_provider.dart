import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/faculty/faculty_screen.dart';
import 'package:scoreboard/scores/games/games_screen.dart';
import 'package:scoreboard/services/firestore.dart';
import 'package:scoreboard/settings/settings.dart';
import 'package:scoreboard/shared/appbar.dart';
import 'package:scoreboard/shared/global.dart';

import 'teams/teams_screen.dart';

class MainProvider extends StatefulWidget {
  const MainProvider({super.key});

  @override
  State<MainProvider> createState() => _MainProviderState();
}

class SharedNavigationDestination {
  final Widget icon;
  final Widget selectedIcon;
  final String label;

  const SharedNavigationDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  NavigationDestination toNavigationDestination() {
    return NavigationDestination(
      icon: icon,
      selectedIcon: selectedIcon,
      label: label,
    );
  }

  NavigationDrawerDestination toNavigationDrawerDestination() {
    return NavigationDrawerDestination(
      icon: icon,
      selectedIcon: selectedIcon,
      label: Text(label),
    );
  }
}

class _MainProviderState extends State<MainProvider> {
  int index = 0;

  final destinations = [
    const SharedNavigationDestination(
      icon: Icon(Icons.group_outlined),
      selectedIcon: Icon(Icons.group),
      label: 'Teams',
    ),
    const SharedNavigationDestination(
      icon: Icon(Icons.folder_outlined),
      selectedIcon: Icon(Icons.folder),
      label: 'Fakultäten',
    ),
    const SharedNavigationDestination(
      icon: Icon(Icons.videogame_asset_outlined),
      selectedIcon: Icon(Icons.videogame_asset),
      label: 'Spiele',
    ),
  ];
  final screens = [
    const TeamsScreen(),
    const FacultiesScreen(),
    const GamesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isDesktop(context)
          ? null
          : getAppBar(context, 'Fachschaftsolympiade', true),
      bottomNavigationBar: isDesktop(context)
          ? null
          : NavigationBar(
              destinations:
                  destinations.map((e) => e.toNavigationDestination()).toList(),
              selectedIndex: index,
              onDestinationSelected: (index) => setState(() {
                this.index = index;
              }),
            ),
      body: MultiProvider(
        providers: [
          StreamProvider<List<Faculty>>(
            create: (_) => FirestoreService().getFacultiesAsStream(),
            initialData: [Faculty()],
            catchError: (_, __) => [Faculty()],
          ),
          StreamProvider<List<Team>>(
            create: (_) => FirestoreService().getTeamsAsStream(),
            initialData: [Team()],
            catchError: (_, __) => [Team()],
          ),
        ],
        child: isDesktop(context)
            ? Row(
                children: [
                  NavigationDrawer(
                    elevation: 1,
                    selectedIndex: index,
                    onDestinationSelected: (index) {
                      if (index == screens.length) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );

                        return;
                      }

                      setState(() {
                        this.index = index;
                      });
                    },
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          children: const [
                            Image(
                                image: AssetImage(
                                  'studverthi.png',
                                ),
                                height: 35),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text(
                              'Fachschaftsolympiade',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      ...destinations
                          .map((e) => e.toNavigationDrawerDestination())
                          .toList(),
                      const NavigationDrawerDestination(
                        icon: Icon(Icons.settings_rounded),
                        selectedIcon: Icon(Icons.settings_rounded),
                        label: Text('Einstellungen'),
                      ),
                    ],
                  ),
                  Expanded(child: screens[index]),
                ],
              )
            : screens[index],
      ),
    );
  }
}
