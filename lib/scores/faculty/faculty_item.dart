import 'package:flutter/material.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/faculty/details/faculty_details_provider.dart';

import '../../shared/list_title.dart';

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
        title: ListTitle(
          title: faculty.name,
          faculty: faculty,
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
