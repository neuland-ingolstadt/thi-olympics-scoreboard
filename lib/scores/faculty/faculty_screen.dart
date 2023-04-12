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
    faculties.sort((a, b) => (ranks[a.id]!).compareTo(ranks[b.id]!));

    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: faculties.length,
        itemBuilder: (context, index) {
          final faculty = faculties[index];

          return FacultyItem(
            rank: ranks[faculty.id] ?? 0,
            score: globalScores[faculty.id] ?? 0,
            faculty: faculty,
          );
        },
      ),
    );
  }
}
