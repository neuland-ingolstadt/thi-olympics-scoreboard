import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/faculty/faculty_item.dart';

class FacultiesScreen extends StatefulWidget {
  const FacultiesScreen({super.key});

  @override
  State<FacultiesScreen> createState() => _FacultiesScreenState();
}

class _FacultiesScreenState extends State<FacultiesScreen> {
  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);
    var teams = Provider.of<List<Team>>(context);

    var globalScores = GameUtils.getAllFacultyTeamScores(faculties, teams);
    var ranks = GameUtils.getRankFromScores(globalScores);

    faculties = faculties.where((element) => element.scoresEnabled).toList();
    faculties.sort((a, b) => (ranks[a.id] ?? -1).compareTo(ranks[b.id] ?? -1));

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: faculties.length,
      itemBuilder: (context, index) {
        final faculty = faculties[index];

        return FacultyItem(
          rank: ranks[faculty.id] ?? 0,
          score: globalScores[faculty.id] ?? 0,
          faculty: faculty,
        );
      },
    );
  }
}
