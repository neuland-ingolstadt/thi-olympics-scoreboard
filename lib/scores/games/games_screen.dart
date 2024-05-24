import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/games/games_item.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);

    faculties = faculties.where((element) => element.hasGame).toList();
    faculties.sort((a, b) => a.name.compareTo(b.name));

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      itemCount: faculties.length,
      itemBuilder: (context, index) {
        final faculty = faculties[index];

        return GamesItem(
          faculty: faculty,
        );
      },
    );
  }
}
