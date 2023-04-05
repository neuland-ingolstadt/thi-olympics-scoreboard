import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/shared/appbar.dart';
import 'package:scoreboard/shared/faculty_utils.dart';

class TeamDetails extends StatelessWidget {
  final Team team;
  const TeamDetails({required this.team, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);
    var facultiesRef = faculties.where((element) => element.id == team.faculty);
    var faculty = facultiesRef.isNotEmpty ? facultiesRef.first : Faculty();

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
              team.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(faculty.name),
            const Padding(
              padding: EdgeInsets.all(8),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: faculties.length,
                itemBuilder: (context, index) {
                  var faculty = faculties[index];
                  return TeamFacultyCard(
                    gameFaculty: faculty,
                    team: team,
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
  final Team team;
  final Faculty gameFaculty;
  const TeamFacultyCard(
      {required this.team, required this.gameFaculty, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var teams = Provider.of<List<Team>>(context);
    var faculties = Provider.of<List<Faculty>>(context);

    var points = GameUtils.getGlobalPointsForTeam(teams, faculties, team);

    return Card(
      child: ListTile(
        title: Text(gameFaculty.game),
        leading: FacultyUtils.getCirlceAvatar(context, gameFaculty),
        subtitle: Text(gameFaculty.name),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(rankString),
            Text('${points[gameFaculty] ?? 0}'),
          ],
        ),
        tileColor: Theme.of(context).colorScheme.surfaceVariant,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
