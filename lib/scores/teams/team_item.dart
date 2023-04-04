import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/teams/details/team_details_provider.dart';
import 'package:scoreboard/services/hex_color.dart';
import 'package:scoreboard/shared/faculty_utils.dart';

class TeamItem extends StatelessWidget {
  final Team team;
  final int rank;
  final int score;

  const TeamItem(
      {required this.team, required this.rank, required this.score, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context)
        .where((element) => element.id == team.faculty);
    var faculty = faculties.isNotEmpty ? faculties.first : Faculty();

    return Card(
      child: ListTile(
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$score Punkte'),
            const Icon(Icons.arrow_right_rounded),
          ],
        ),
        title: Row(
          children: [
            Icon(
              FacultyUtils.iconFromFaculty(context, faculty),
              color: HexColor(faculty.color),
              size: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(3.5),
            ),
            Text(
              team.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        subtitle: Text('$rank. Platz'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TeamDetailsProvider(team: team);
          }));
        },
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

class TeamsList extends StatelessWidget {
  final Faculty faculty;
  const TeamsList({required this.faculty, super.key});

  @override
  Widget build(BuildContext context) {
    var teams = Provider.of<List<Team>>(context);
    teams = teams.where((e) => e.faculty == faculty.id).toList();

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: teams.length,
          itemBuilder: (context, index) => TeamsItem(team: teams[index]),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 5))
      ],
    );
  }
}

class TeamsItem extends StatelessWidget {
  final Team team;
  const TeamsItem({required this.team, super.key, required});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            Expanded(
              child: Text(
                team.name,
              ),
            ),
            // Text(
            //   team.score.toString(),
            // ),
          ],
        ));
  }
}
