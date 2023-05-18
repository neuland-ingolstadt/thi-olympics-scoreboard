import 'package:flutter/material.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/services/hex_color.dart';

class FacultyUtils {
  static IconData iconFromFaculty(BuildContext context, Faculty faculty) {
    return IconData(faculty.icon, fontFamily: 'MaterialIcons');
  }

  static CircleAvatar getCircleAvatar(BuildContext context, Faculty faculty) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      foregroundColor: HexColor(faculty.color),
      child: Icon(
        FacultyUtils.iconFromFaculty(context, faculty),
      ),
    );
  }
}
