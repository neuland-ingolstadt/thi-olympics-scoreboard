import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/teams/details/team_details_provider.dart';
import 'package:scoreboard/shared/list_title.dart';

class TeamItem extends StatelessWidget {
  final Team team;
  final int rank;
  final double score;

  const TeamItem(
      {required this.team, Key? key, required this.rank, required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);

    var showScores = faculties
        .firstWhere(
          (element) => element.id == team.faculty,
          orElse: () => Faculty(
            scoresEnabled: false,
          ),
        )
        .scoresEnabled;

    var facultiesRef = faculties.where((element) => element.id == team.faculty);
    var faculty = facultiesRef.isNotEmpty ? facultiesRef.first : Faculty();

    return Card(
      child: ListTile(
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: showScores,
              child: Text('$score Punkte'),
            ),
            const Icon(Icons.arrow_right_rounded),
          ],
        ),
        title: ListTitle(
          title: team.name,
          faculty: faculty,
        ),
        subtitle: Text(showScores ? '$rank. Platz' : 'Keine Wertung'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TeamDetailsProvider(team: team);
          }));
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
