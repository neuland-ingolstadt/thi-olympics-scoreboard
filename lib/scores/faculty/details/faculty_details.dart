import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/teams/team_item.dart';
import 'package:scoreboard/shared/appbar.dart';

class FacultyDetails extends StatelessWidget {
  final Faculty faculty;
  const FacultyDetails({required this.faculty, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);
    var teams = Provider.of<List<Team>>(context);

    var facultyTeams =
        teams.where((element) => element.faculty == faculty.id).toList();

    var globalScores = GameUtils.getGlobalScores(teams, faculties);
    var ranks = GameUtils.getRankFromScores(globalScores);

    teams.sort((a, b) =>
        (globalScores[b.id] ?? -1).compareTo(globalScores[a.id] ?? -1));

    return Scaffold(
      appBar: getAppBar(context, faculty.name),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: facultyTeams.length,
              itemBuilder: (context, index) {
                var team = facultyTeams[index];
                return TeamItem(
                  team: team,
                  rank: ranks[team.id] ?? 0,
                  score: globalScores[team.id] ?? 0,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// class TeamFacultyCard extends StatelessWidget {
//   final List<Team> facultyTeams;
//   final Faculty currentFaculty;
//   final Faculty gameFaculty;
//   const TeamFacultyCard(
//       {required this.facultyTeams,
//       required this.gameFaculty,
//       required this.currentFaculty,
//       Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var teams = Provider.of<List<Team>>(context);
//     var faculties = Provider.of<List<Faculty>>(context);

//     return Card(
//       child: ListTile(
//         title: Text(gameFaculty.game),
//         leading: FacultyUtils.getCirlceAvatar(context, gameFaculty),
//         subtitle: Text(gameFaculty.name),
//         trailing: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: const [
//             Text(
//               'rankString',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text('pointsString'),
//           ],
//         ),
//         tileColor: Theme.of(context).colorScheme.surfaceVariant,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }
