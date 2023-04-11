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

  @override
  Widget build(BuildContext context) {
    var teams = Provider.of<List<Team>>(context);
    var faculties = Provider.of<List<Faculty>>(context);

    return Card(
      child: ListTile(
        title: Text(gameFaculty.game),
        leading: FacultyUtils.getCirlceAvatar(context, gameFaculty),
        subtitle: Text(gameFaculty.name),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              'rankString',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('pointsString'),
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
