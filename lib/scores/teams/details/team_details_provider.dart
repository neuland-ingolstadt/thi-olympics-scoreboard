import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/teams/details/team_details.dart';
import 'package:scoreboard/services/firestore.dart';

class TeamDetailsProvider extends StatelessWidget {
  final Team team;
  const TeamDetailsProvider({required this.team, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Team>>(
          create: (_) => FirestoreService().getTeamsAsStream(),
          initialData: [Team()],
          catchError: (_, __) => [Team()],
        ),
        StreamProvider<List<Faculty>>(
          create: (_) => FirestoreService().getFacultiesAsStream(),
          initialData: [Faculty()],
          catchError: (_, __) => [Faculty()],
        ),
      ],
      child: TeamDetails(team: team),
    );
  }
}
