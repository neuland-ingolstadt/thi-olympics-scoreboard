import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/teams/details/team_details_provider.dart';
import 'package:scoreboard/shared/list_title.dart';

class GameTeamItem extends StatelessWidget {
  final Team team;
  final int rank;
  final double globalScore;
  final int? gameScore;
  final Faculty gameFaculty;

  const GameTeamItem(
      {required this.team,
      Key? key,
      required this.rank,
      required this.globalScore,
      required this.gameScore,
      required this.gameFaculty})
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
            Text(showScores ? '$rank. Platz' : 'Keine Wertung'),
            const Icon(Icons.arrow_right_rounded),
          ],
        ),
        title: ListTitle(
          title: team.name,
          faculty: faculty,
        ),
        subtitle: gameScore != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$gameScore Spielpunkte",
                    style: TextStyle(
                      // textstyle: caption
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Visibility(
                    visible: showScores,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(Icons.circle, size: 5),
                        ),
                        Text("$globalScore Punkte"),
                      ],
                    ),
                  ),
                ],
              )
            : Text(team.times[gameFaculty.id] == null
                ? ""
                : "${team.times[gameFaculty.id]} Uhr"),
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
