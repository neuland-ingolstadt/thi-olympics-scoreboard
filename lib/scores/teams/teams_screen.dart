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

    teams.sort(
        (a, b) => (globalScores[b.id] ?? 0).compareTo(globalScores[a.id] ?? 0));

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
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
          ),
        ),
      ),
    );
  }
}
