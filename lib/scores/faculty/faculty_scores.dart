import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/faculty/faculty_item.dart';

// class FacultiesScreenProvider extends StatefulWidget {
//   const FacultiesScreenProvider({Key? key}) : super(key: key);

//   @override
//   State<FacultiesScreenProvider> createState() => _FacultiesScreenProviderState();
// }

// class _FacultiesScreenProviderState extends State<FacultiesScreenProvider> {

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         StreamProvider<List<Faculty>>(
//           create: (_) => FirestoreService().getFacultiesAsStream(),
//           initialData: [Faculty()],
//           catchError: (_, __) => [Faculty()],
//         ),
//         StreamProvider<List<Team>>(
//           create: (_) => FirestoreService().getTeamsAsStream(),
//           initialData: [Team()],
//           catchError: (_, __) => [Team()],
//         ),
//       ],
//       child: const FacultiesScreen(),
//     );
//   }
// }

class FacultiesScreen extends StatefulWidget {
  const FacultiesScreen({super.key});

  @override
  State<FacultiesScreen> createState() => _FacultiesScreenState();
}

class _FacultiesScreenState extends State<FacultiesScreen> {
  @override
  Widget build(BuildContext context) {
    var faculties = Provider.of<List<Faculty>>(context);
    faculties =
        faculties.where((element) => element.id != 'sprecherrat').toList();

    var teams = Provider.of<List<Team>>(context);

    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: faculties.length,
        itemBuilder: (context, index) {
          final faculty = faculties[index];
          return FacultyItem(
            rank: ranks[faculty] ?? 0,
            score: scores[faculty] ?? 0,
            faculty: faculty,
          );
        },
      ),
    );
  }
}
