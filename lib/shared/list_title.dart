import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/hex_color.dart';
import 'faculty_utils.dart';

class ListTitle extends StatelessWidget {
  final Faculty faculty;
  final String title;

  const ListTitle({super.key, required this.faculty, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          FacultyUtils.iconFromFaculty(context, faculty),
          color: HexColor(faculty.color),
          size: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(3.5),
        ),
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
