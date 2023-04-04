import 'package:flutter/material.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/faculty/details/faculty_details_provider.dart';
import 'package:scoreboard/shared/faculty_utils.dart';

class FacultyItem extends StatelessWidget {
  final int score;
  final int rank;
  final Faculty faculty;

  const FacultyItem(
      {required this.score,
      required this.rank,
      required this.faculty,
      Key? key})
      : super(key: key);

  // String getTotalScore(BuildContext context, Faculty faculty) {
  //   var teams = Provider.of<List<Team>>(context);

  //   if (teams.isEmpty) {
  //     return '0';
  //   }

  //   int total =
  //       teams.map((e) => e.score).reduce((value, element) => value + element);

  //   return total.toString();
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // contentPadding: const EdgeInsets.all(),
        leading: FacultyUtils.getCirlceAvatar(context, faculty),
        title: Text(
          faculty.name,
          style: const TextStyle(
            fontSize: 20,
            // color: HexColor(faculty.color),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$score Punkte'),
            const Icon(Icons.arrow_right),
          ],
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FacultyDetailsProvider(faculty: faculty);
          }));
        },
        subtitle: Text('$rank. Platz'),
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

// class TeamsList extends StatelessWidget {
//   final Faculty faculty;
//   const TeamsList({required this.faculty, super.key});

//   @override
//   Widget build(BuildContext context) {
//     var teams = Provider.of<List<Team>>(context);
//     teams = teams.where((e) => e.faculty == faculty.id).toList();

//     return Column(
//       children: [
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: teams.length,
//           itemBuilder: (context, index) {
//             // var team = teams[index];

//             return TeamsItem(
//               score: 0,
//               rank: 0,
//               team: teams[index],
//             );
//           },
//         ),
//         const Padding(padding: EdgeInsets.only(bottom: 5))
//       ],
//     );
//   }
// }

// class TeamsItem extends StatelessWidget {
//   final Team team;
//   final int score;
//   final int rank;
//   const TeamsItem(
//       {required this.rank,
//       required this.team,
//       super.key,
//       required,
//       required this.score});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 5),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               team.name,
//             ),
//           ),
//           Text(
//             '$score Punkte',
//           ),
//         ],
//       ),
//     );
//   }
// }
