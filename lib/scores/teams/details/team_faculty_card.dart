import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';
import '../../../shared/faculty_utils.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                gameFaculty.game,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Visibility(
              visible: team.scores[gameFaculty.id] != null,
              child: Text(
                "$teamRank. Platz",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        leading: FacultyUtils.getCirlceAvatar(context, gameFaculty),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              gameFaculty.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5),
            ),
            team.scores[gameFaculty.id] == null
                ? Text(
                    (team.times[gameFaculty.id] == null
                        ? "Noch nicht gespielt"
                        : "${team.times[gameFaculty.id]} Uhr"),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${team.scores[gameFaculty.id]} Spielpunkte"),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(Icons.circle, size: 5),
                      ),
                      Text(
                          "${GameUtils.getPointsFromRank(gameRanks, team)} Punkte"),
                    ],
                  ),
          ],
        ),
        // trailing: Visibility(
        //   visible: team.scores[gameFaculty.id] != null,
        //   child: Text("$teamRank. Platz"),
        // ),
        //       Row(
        // mainAxisSize: MainAxisSize.min,
        // children: [
        //   Text("${team.scores[gameFaculty.id]} Spielpunkte"),
        //   const Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 5),
        //     child: Icon(Icons.circle, size: 5),
        //   ),
        //   Text(
        //       "${GameUtils.getPointsFromRank(gameRanks, team)} Punkte"),
        // ],
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
