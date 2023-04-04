import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/edit_scores/edit_scores.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/services/firestore.dart';

class EditScoresProvider extends StatelessWidget {
  const EditScoresProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Faculty>(
      future: FirestoreService().getFacultyFromUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var faculty = snapshot.data!;
          return MultiProvider(
            providers: [
              StreamProvider<List<Team>>(
                create: (_) => FirestoreService().getTeamsAsStream(),
                initialData: [Team()],
                catchError: (_, __) => [Team()],
              ),
              StreamProvider<List<Faculty>>(
                create: (_) => FirestoreService().getFacultiesAsStream(),
                initialData: [Faculty()],
                catchError: (_, __) => [Faculty()],
              ),
            ],
            child: EditScores(
              faculty: faculty,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
