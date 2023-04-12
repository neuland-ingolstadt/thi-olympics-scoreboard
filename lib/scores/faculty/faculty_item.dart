import 'package:flutter/material.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/faculty/details/faculty_details_provider.dart';
import 'package:scoreboard/shared/faculty_utils.dart';

class FacultyItem extends StatelessWidget {
  final double score;
  final int rank;
  final Faculty faculty;

  const FacultyItem(
      {required this.score,
      required this.rank,
      required this.faculty,
      Key? key})
      : super(key: key);

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
