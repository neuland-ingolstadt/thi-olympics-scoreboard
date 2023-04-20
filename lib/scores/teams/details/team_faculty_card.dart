import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';
import '../../../services/hex_color.dart';
import '../../../shared/faculty_utils.dart';
import '../../../shared/list_title.dart';

class TeamFacultyCard extends StatelessWidget {
  final Team team;
  final Faculty gameFaculty;
  const TeamFacultyCard(
      {required this.team, required this.gameFaculty, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var teams = Provider.of<List<Team>>(context);
    var gameRanks = gameFaculty.getTeamRanks(teams);

    var teamRank = gameRanks[team.id];

    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: ListTitle(
            title: gameFaculty.game,
            faculty: gameFaculty,
          ),
        ),
        trailing: Visibility(
          visible: team.scores[gameFaculty.id] != null,
          child: Text("$teamRank. Platz"),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            team.scores[gameFaculty.id] == null
                ? Text(
                    (team.times[gameFaculty.id] == null
                        ? "Nicht gespielt"
                        : "${team.times[gameFaculty.id]} Uhr"),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${team.scores[gameFaculty.id]} Spielpunkte",
                        style: TextStyle(
                          // textstyle: caption
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(Icons.circle, size: 5),
                      ),
                      Text(
                          "${GameUtils.getPointsFromRank(gameRanks, team)} Punkte"),
                    ],
                  ),
            const Padding(
              padding: EdgeInsets.all(2),
            ),
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
