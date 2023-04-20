import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/teams/details/team_faculty_card.dart';
import 'package:scoreboard/shared/appbar.dart';

class TeamDetails extends StatelessWidget {
  final Team team;
  const TeamDetails({required this.team, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);
    // var facultiesRef = faculties.where((element) => element.id == team.faculty);
    // var faculty = facultiesRef.isNotEmpty ? facultiesRef.first : Faculty();

    return Scaffold(
      appBar: getAppBar(context, team.name),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
          ),
        ),
      ),
    );
  }
}
