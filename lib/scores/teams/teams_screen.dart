import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/teams/team_item.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  int getFacGameScore(Faculty faculty, Team team) {
    return faculty.scores[team.id] ?? 0;
  }

  Map<Team, int> mapTeamsToScore(Faculty faculty, List<Team> teams) {
    teams.sort(((a, b) =>
        getFacGameScore(faculty, b).compareTo(getFacGameScore(faculty, a))));

    var teamPlaces = <Team, int>{};

    var prevScore = -1;
    var rank = 0;

    for (var element in teams) {
      var curScore = getFacGameScore(faculty, element);
      if (curScore == 0) {
        continue;
      }

      if (curScore != prevScore) {
        ++rank;
        prevScore = curScore;
      }
      teamPlaces[element] = rank;
    }

    for (var element in teams) {
      teamPlaces[element] =
          (teams.length - (teamPlaces[element] ?? teams.length + 1) + 1) * 10;
    }

    return teamPlaces;
  }

  Map<Team, int> getGlobalScores(List<Faculty> faculties, List<Team> teams) {
    var teamScoreMap = <Team, int>{};

    for (var faculty in faculties) {
      var teamPlaces = mapTeamsToScore(faculty, teams);

      for (var team in teams) {
        teamScoreMap[team] =
            (teamScoreMap[team] ?? 0) + (teamPlaces[team] ?? 0);
      }
    }

    return teamScoreMap;
  }

  Map<Team, int> getGlobalRanks(Map<Team, int> globalScores) {
    var teamPlaces = {
      for (var element in globalScores.keys) element: 0,
    };

    var prevScore = -1;
    var rank = 0;

    for (var element in globalScores.keys.toList()
      ..sort(
          (a, b) => (globalScores[b] ?? 0).compareTo(globalScores[a] ?? 0))) {
      var curScore = globalScores[element] ?? 0;

      if (curScore != prevScore) {
        ++rank;
        prevScore = curScore;
        // print('$curScore - $rank');
      }
      teamPlaces[element] = rank;
    }

    return teamPlaces;
  }

  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);
    var teams = Provider.of<List<Team>>(context);

    var scores = getGlobalScores(faculties, teams);
    var ranks = getGlobalRanks(scores);

    teams.sort((a, b) => (ranks[a] ?? 0).compareTo(ranks[b] ?? 0));

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
