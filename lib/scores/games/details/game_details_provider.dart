import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/games/details/game_details.dart';
import 'package:scoreboard/services/firestore.dart';

class GameDetailsProvider extends StatelessWidget {
  final Faculty faculty;
  const GameDetailsProvider({required this.faculty, Key? key})
      : super(key: key);

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
      child: GameDetails(faculty: faculty),
    );
  }
}
