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
        title: Text(gameFaculty.game),
        leading: FacultyUtils.getCirlceAvatar(context, gameFaculty),
        subtitle: Text(gameFaculty.name),
        trailing: Visibility(
          visible: team.scores[gameFaculty.id] != null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("$teamRank. Platz"),
              Row(
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
              )
            ],
          ),
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
