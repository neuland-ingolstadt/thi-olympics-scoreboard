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
  int icon;
  String color;
  String id;
  String game;
  Map<String, int> scores;

  Faculty({
    this.name = 'Error',
    this.icon = 0xe237,
    this.color = '#ff1e1e',
    this.id = '',
    this.scores = const {},
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
