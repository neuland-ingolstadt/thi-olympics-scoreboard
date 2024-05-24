import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/games/details/game_details_provider.dart';

import '../../shared/list_title.dart';

class GamesItem extends StatelessWidget {
  final Faculty faculty;

  const GamesItem({required this.faculty, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var teams = Provider.of<List<Team>>(context);
    var playedTeams =
        teams.where((t) => t.scores.containsKey(faculty.id)).toList().length;

    return Card(
      child: ListTile(
        title: ListTitle(
          title: faculty.game,
          faculty: faculty,
        ),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GameDetailsProvider(faculty: faculty);
          }));
        },
        subtitle: Text('$playedTeams / ${teams.length} Teams'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
