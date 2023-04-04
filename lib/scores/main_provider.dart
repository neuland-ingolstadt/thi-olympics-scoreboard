import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/faculty/faculty_scores.dart';
import 'package:scoreboard/services/firestore.dart';
import 'package:scoreboard/shared/appbar.dart';

import 'teams/teams_screen.dart';

class MainProvider extends StatefulWidget {
  const MainProvider({super.key});

  @override
  State<MainProvider> createState() => _MainProviderState();
}

class _MainProviderState extends State<MainProvider> {
  int index = 0;

  final screens = [const TeamsScreen(), const FacultiesScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, true),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.group_outlined),
            selectedIcon: Icon(Icons.group),
            label: 'Teams',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Fakultäten',
          ),
        ],
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
        child: screens[index],
      ),
    );
  }
}
