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
  bool hasGame;

  Faculty({
    this.name = 'Error',
    this.shortname = 'Error',
    this.icon = 0xe237,
    this.color = '#ff1e1e',
    this.id = '',
    this.scoresEnabled = true,
    this.hasGame = true,
    this.game = 'Disziplin der Fakultät',
  });

  // returns a map of teams and their ranks for the game of this faculty
  Map<String, int> getTeamRanks(List<Team> teams) {
    var scores = teams.map((e) => e.scores[id] ?? 0).toList();
    scores.sort((a, b) => b.compareTo(a));

    var teamPlaces = <String, int>{};

    for (var team in teams) {
      teamPlaces[team.id] = scores.indexOf(team.scores[id] ?? 0) + 1;
    }

    return teamPlaces;
  }

  factory Faculty.fromJson(String id, Map<String, dynamic> json) =>
      _$FacultyFromJson(json)..id = id;

  Map<String, dynamic> toJson() => _$FacultyToJson(this);
}

@JsonSerializable()
class Team {
  String name;
  String id;
  String faculty;
  Map<String, int> scores;

  Team({
    this.name = 'Error',
    this.id = '',
    this.faculty = 'error',
    this.scores = const {},
  });

  double getGlobalScore(List<Faculty> faculties, List<Team> teams) {
    var score = 0.0;
    for (var faculty in faculties) {
      if (scores[faculty.id] == null) continue;
      var ranks = faculty.getTeamRanks(teams);
      score += GameUtils.getPointsFromRank(ranks, this);
    }

    return score;
  }

  factory Team.fromJson(String id, Map<String, dynamic> json) =>
      _$TeamFromJson(json)..id = id;

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

class GameUtils {
  static Map<T, int> getRankFromScores<T>(Map<T, double> globalScores) {
    var scores = globalScores.values.toList();

    scores.sort((a, b) => b.compareTo(a));

    var teamPlaces = <T, int>{};

    for (var element in globalScores.keys) {
      teamPlaces[element] = scores.indexOf(globalScores[element] ?? 0) + 1;
    }

    return teamPlaces;
  }

  static double getPointsFromRank(Map<String, int> allRanks, Team team) {
    var teamRank = allRanks[team.id] ?? 0;

    var sameRank = allRanks.values.where((e) => e == teamRank).length;
    var points = 0.0;
    for (var i = 0; i < sameRank; i++) {
      points += (allRanks.length - teamRank - i) * 10;
    }
    points = points / sameRank;

    return points;
  }

  static Map<String, double> getGlobalScores(
      List<Team> teams, List<Faculty> faculties) {
    var globalScores = <String, double>{};

    for (var team in teams) {
      globalScores[team.id] = team.getGlobalScore(faculties, teams);
    }

    return globalScores;
  }

  static Map<String, double> getAllFacultyTeamScores(
      List<Faculty> faculties, List<Team> teams) {
    var globalScores = GameUtils.getGlobalScores(teams, faculties);

    var facultyScores = <String, double>{};

    for (var faculty in faculties) {
      var facultyTeams = teams.where((e) => e.faculty == faculty.id).toList();

      if (facultyTeams.isEmpty) {
        facultyScores[faculty.id] = 0;
        continue;
      }

      var scores = facultyTeams
          .map((e) => globalScores[e.id])
          .reduce((value, element) => value! + element!);

      scores = (scores ?? 0) / facultyTeams.length;

      facultyScores[faculty.id] = scores;
    }

    return facultyScores;
  }
}
