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

    var globalScores = GameUtils.getGlobalScores(teams, faculties);
    var ranks = GameUtils.getRankFromScores(globalScores);

    faculties = faculties.where((element) => element.scoresEnabled).toList();

    var allEmpty = globalScores.entries.every((element) => element.value == 0);
    if (allEmpty) {
      teams.sort((a, b) {
        var teamANumber = int.tryParse(a.name.split(' ')[1]) ?? 0;
        var teamBNumber = int.tryParse(b.name.split(' ')[1]) ?? 0;

        return teamANumber.compareTo(teamBNumber);
      });
    } else {
      teams.sort((a, b) =>
          (globalScores[b.id] ?? -1).compareTo(globalScores[a.id] ?? -1));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index];
        return TeamItem(
          team: team,
          rank: ranks[team.id] ?? 0,
          score: globalScores[team.id] ?? 0,
        );
      },
    );
  }
}
