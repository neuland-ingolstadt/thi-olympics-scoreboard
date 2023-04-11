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
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("$teamRank. Platz"),
            Text(
                '${team.scores[gameFaculty.id]} Spiel-Punkte => ${GameUtils.getPointsFromRank(gameRanks, team)} Gesamtpunkte'),
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
