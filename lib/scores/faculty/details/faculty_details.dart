import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/shared/appbar.dart';
import 'package:scoreboard/shared/faculty_utils.dart';

class FacultyDetails extends StatelessWidget {
  final Faculty faculty;
  const FacultyDetails({required this.faculty, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);
    var allTeams = Provider.of<List<Team>>(context);

    var facultyTeams =
        allTeams.where((element) => element.faculty == faculty.id).toList();
    // var faculty = facultiesRef.isNotEmpty ? facultiesRef.first : Faculty();

    return Scaffold(
      appBar: getAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
            ),
            Text(
              faculty.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text('${facultyTeams.length} Team(s)'),
            const Padding(
              padding: EdgeInsets.all(8),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: faculties.length,
                itemBuilder: (context, index) {
                  var gameFaculty = faculties[index];
                  return TeamFacultyCard(
                    currentFaculty: faculty,
                    gameFaculty: gameFaculty,
                    facultyTeams: facultyTeams,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TeamFacultyCard extends StatelessWidget {
  final List<Team> facultyTeams;
  final Faculty currentFaculty;
  final Faculty gameFaculty;
  const TeamFacultyCard(
      {required this.facultyTeams,
      required this.gameFaculty,
      required this.currentFaculty,
      Key? key})
      : super(key: key);

  int getFacGameScore(Team team) {
    return gameFaculty.scores[team.id] ?? 0;
  }

  Map<Faculty, double> getAvgScore(
      List<Faculty> faculties, List<Team> allTeams, Faculty gameFaculty) {
    var avgs = {
      for (var faculty in faculties) faculty: 0.0,
    };

    for (var team in allTeams) {
      // get faculty of team
      var facultyRef = faculties.where((element) => element.id == team.faculty);
      var faculty = facultyRef.isNotEmpty ? facultyRef.first : Faculty();

      avgs[faculty] = (avgs[faculty] ?? 0) + getFacGameScore(team);

      // print('${faculty.name} ${avgs[faculty]}');
    }

    for (var element in avgs.entries) {
      var teamLength =
          allTeams.where((e) => e.faculty == element.key.id).length;

      avgs[element.key] = element.value / teamLength;
    }

    return avgs;
  }

  Map<Faculty, int> mapTeamsToScore(
      Map<Faculty, double> avgs, List<Faculty> faculties) {
    var facultiesCopy = List.of(faculties);

    facultiesCopy.sort(((a, b) => (avgs[b] ?? 0).compareTo(avgs[a] ?? 0)));

    var teamPlaces = <Faculty, int>{};

    var prevScore = -1.0;
    var rank = 0;

    for (var element in facultiesCopy) {
      var curScore = avgs[element] ?? 0;

      if (curScore == 0 || curScore.isNaN) {
        continue;
      }

      // print('${element.name} ${curScore}');

      if (curScore != prevScore) {
        ++rank;
        prevScore = curScore;
      }
      teamPlaces[element] = rank;
    }

    return teamPlaces;
  }

  int rankToPoints(int facCount, int rank) {
    return (facCount - rank + 1) * 10;
  }

  @override
  Widget build(BuildContext context) {
    var teams = Provider.of<List<Team>>(context);
    var faculties = Provider.of<List<Faculty>>(context);

    var avgs = getAvgScore(faculties, teams, gameFaculty);
    var ranks = mapTeamsToScore(avgs, faculties);

    var currentRankRef =
        ranks.entries.where((element) => element.key.id == currentFaculty.id);
    var rankString =
        currentRankRef.isNotEmpty ? '${currentRankRef.first.value}. Platz' : '';
    var rank = currentRankRef.isNotEmpty
        ? currentRankRef.first.value
        : faculties.length + 1;

    var points = rankToPoints(faculties.length, rank);
    var pointsString = points > 0 ? '$points Fakultätspunkte' : '';

    // var currentAvgRef =
    //     avgs.entries.where((element) => element.key.id == currentFaculty.id);
    // var avgString = currentAvgRef.isNotEmpty && currentAvgRef.first.value > 0
    //     ? 'Ø ${currentAvgRef.first.value} Spielpunkte'
    //     : '';

    return Card(
      child: ListTile(
        title: Text(gameFaculty.game),
        leading: FacultyUtils.getCirlceAvatar(context, gameFaculty),
        subtitle: Text(gameFaculty.name),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // RichText(
            //   text: TextSpan(children: [
            //     TextSpan(
            //       text: '$rankString ',
            //       style: const TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //     TextSpan(
            //       text: pointsString,
            //     ),
            //   ]),
            // ),
            Text(
              rankString,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(pointsString),
          ],
        ),
      ),
    );
  }
}
