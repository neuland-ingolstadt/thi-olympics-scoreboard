import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/games/details/game_team_item.dart';
import 'package:scoreboard/shared/appbar.dart';

class GameDetails extends StatelessWidget {
  final Faculty faculty;
  const GameDetails({required this.faculty, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var teams = Provider.of<List<Team>>(context);
    var faculties = Provider.of<List<Faculty>>(context);

    var ranks = faculty.getTeamRanks(
        teams.where((element) => element.hasScoresEnabled(faculties)).toList());
    teams.sort((a, b) =>
        (ranks[a.id] ?? ranks.length).compareTo(ranks[b.id] ?? ranks.length));

    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context, faculty.game),
        body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          itemCount: teams.length,
          itemBuilder: (context, index) {
            var team = teams[index];
            return GameTeamItem(
              team: team,
              rank: ranks[team.id] ?? 0,
              globalScore: GameUtils.getPointsFromRank(ranks, team),
              gameScore: team.scores[faculty.id],
              gameFaculty: faculty,
            );
          },
        ),
      ),
    );
  }
}
