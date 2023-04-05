import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/teams/team_item.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);
    var teams = Provider.of<List<Team>>(context);

    // var scores = getGlobalScores(faculties, teams);
    // var ranks = getGlobalRanks(scores);

    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return TeamItem(
            team: team,
            rank: ranks[team] ?? 0,
            score: scores[team] ?? 0,
          );
        },
      ),
    );
  }
}
