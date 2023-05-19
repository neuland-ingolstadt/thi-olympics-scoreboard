import 'package:flutter/material.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/services/hex_color.dart';

class FacultyUtils {
  static IconData iconFromFaculty(BuildContext context, Faculty faculty) {
    switch (faculty.icon) {
      case 63006:
        return Icons.cases_rounded;
      case 57896:
        return Icons.electrical_services_rounded;
      case 983134:
        return Icons.people_rounded;
      case 58215:
        return Icons.laptop_rounded;
      case 983396:
        return Icons.settings_rounded;
      case 983842:
        return Icons.forest_rounded;
      case 58091:
        return Icons.group_rounded;
      case 63077:
        return Icons.construction_rounded;
      default:
        return Icons.error_rounded;
    }
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
