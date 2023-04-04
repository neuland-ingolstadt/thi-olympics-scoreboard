import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/faculty/faculty_item.dart';

// class FacultiesScreenProvider extends StatefulWidget {
//   const FacultiesScreenProvider({Key? key}) : super(key: key);

//   @override
//   State<FacultiesScreenProvider> createState() => _FacultiesScreenProviderState();
// }

// class _FacultiesScreenProviderState extends State<FacultiesScreenProvider> {

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         StreamProvider<List<Faculty>>(
//           create: (_) => FirestoreService().getFacultiesAsStream(),
//           initialData: [Faculty()],
//           catchError: (_, __) => [Faculty()],
//         ),
//         StreamProvider<List<Team>>(
//           create: (_) => FirestoreService().getTeamsAsStream(),
//           initialData: [Team()],
//           catchError: (_, __) => [Team()],
//         ),
//       ],
//       child: const FacultiesScreen(),
//     );
//   }
// }

class FacultiesScreen extends StatefulWidget {
  const FacultiesScreen({super.key});

  @override
  State<FacultiesScreen> createState() => _FacultiesScreenState();
}

class _FacultiesScreenState extends State<FacultiesScreen> {

  int getFacGameScore(Faculty faculty, Team team) {
    return faculty.scores[team.id] ?? 0;
  }

  double getFacGameAvgScore(Faculty faculty, List<Team> teams) {
    if (teams.isEmpty) {
      return 0;
    }

    var total = teams
        .map((e) => getFacGameScore(faculty, e))
        .reduce((value, element) => value + element);

    return total / teams.length;
  }

  //Retruns the average score of all teams in the faculty for the given game of a faculty
  double getFacGameAvgScores(
      Faculty gameFaculty, Faculty teamFaculty, List<Team> allTeams) {
    // var scores = <Faculty, int>{};

    // Get teams from faculty
    var teams = allTeams.where((e) => e.faculty == teamFaculty.id).toList();

    // Get average score for given game from faculty
    return getFacGameAvgScore(gameFaculty, teams);
  }

  //Returns global score for each faculty for the given game of a faculty
  Map<Faculty, int> getFacScore(
      Faculty gameFaculty, List<Faculty> faculties, List<Team> allTeams) {

    var facultiesCopy = List.of(faculties);

    facultiesCopy.sort(((a, b) => getFacGameAvgScores(gameFaculty, b, allTeams)
        .compareTo(getFacGameAvgScores(gameFaculty, a, allTeams))));

    var facRanks = <Faculty, int>{};

    double prevScore = -1;
    var rank = 0;

    // print(gameFaculty.name);
    for (var element in facultiesCopy) {
      var curScore = getFacGameAvgScores(gameFaculty, element, allTeams);

      // print('${element.name} $curScore');

      if (curScore == 0 || curScore.isNaN) {
        continue;
      }

      if (curScore != prevScore) {
        ++rank;
        prevScore = curScore;
      }
      facRanks[element] = rank;
    }

    for (var element in facultiesCopy) {
      facRanks[element] =
          (facultiesCopy.length - (facRanks[element] ?? facultiesCopy.length + 1) + 1) *
              10;

      // print('${element.name} ${facRanks[element]}');
    }

    // print('\n');

    return facRanks;
  }

  Map<Faculty, int> getGlobalSumScores(
      List<Faculty> gameFaculties, List<Team> allTeams) {
    var facSumMap = <Faculty, int>{};

    for (var gameFaculty in gameFaculties) {
      // score for given game from faculty
      var facRanks = getFacScore(gameFaculty, gameFaculties, allTeams);

      // add to total score
      for (var teamFaculty in gameFaculties) {
        facSumMap[teamFaculty] =
            (facSumMap[teamFaculty] ?? 0) + (facRanks[teamFaculty] ?? 0);
      }
    }

    return facSumMap;
  }

  Map<Faculty, int> getGlobalRanks(Map<Faculty, int> globalScores) {
    var facRanks = {
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
      facRanks[element] = rank;
    }

    return facRanks;
  }

  @override
  Widget build(BuildContext context) {

    var faculties = Provider.of<List<Faculty>>(context);
    faculties = faculties.where((element) => element.id != 'sprecherrat').toList();

    var teams = Provider.of<List<Team>>(context);

    var scores = getGlobalSumScores(faculties, teams);
    var ranks = getGlobalRanks(scores);

    faculties.sort((a, b) => (ranks[a] ?? 0).compareTo(ranks[b] ?? 0));

    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: faculties.length,
        itemBuilder: (context, index) {
          final faculty = faculties[index];
          return FacultyItem(
            rank: ranks[faculty] ?? 0,
            score: scores[faculty] ?? 0,
            faculty: faculty,
          );
        },
      ),
    );
  }
}
