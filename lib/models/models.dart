import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class User {
  String faculty;

  User({this.faculty = 'Error'});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Faculty {
  String name;
  String shortname;
  int icon;
  String color;
  String id;
  String game;
  bool scoresEnabled;
  Map<String, int> scores;

  Faculty({
    this.name = 'Error',
    this.shortname = 'Error',
    this.icon = 0xe237,
    this.color = '#ff1e1e',
    this.id = '',
    this.scores = const {},
    this.scoresEnabled = true,
    this.game = 'Disziplin der Fakultät',
  });

  factory Faculty.fromJson(String id, Map<String, dynamic> json) =>
      _$FacultyFromJson(json)..id = id;

  Map<String, dynamic> toJson() => _$FacultyToJson(this);
}

@JsonSerializable()
class Team {
  String name;
  String id;
  String faculty;

  Team({
    this.name = 'Error',
    this.id = '',
    this.faculty = 'error',
  });

  factory Team.fromJson(String id, Map<String, dynamic> json) =>
      _$TeamFromJson(json)..id = id;

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

class GameUtils {
  static Map<T, int> getRankFromScores<T>(Map<T, int> globalScores) {
    var scores = globalScores.values.toList();

    scores.sort((a, b) => b.compareTo(a));

    var teamPlaces = <T, int>{};

    for (var element in globalScores.keys) {
      teamPlaces[element] = scores.indexOf(globalScores[element] ?? 0) + 1;
    }

    return teamPlaces;
  }

  static Map<Faculty, int> getGlobalPointsForTeam(
      List<Team> teams, List<Faculty> faculties, Team team) {
    var teamCount = teams
        .where(
            (t) => faculties.firstWhere((f) => f.id == t.faculty).scoresEnabled)
        .length;

    var scores = <Faculty, int>{};

    for (var faculty in faculties) {
      var teamPlaces = getRankFromScores(faculty.scores);
      print(faculty.name);
      print(teamPlaces);

      var rank = teamPlaces[team] ?? teamCount + 1;

      scores[faculty] = (teamCount - rank + 1) * 10;
    }

    return scores;
  }
}
