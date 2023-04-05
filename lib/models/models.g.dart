// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      faculty: json['faculty'] as String? ?? 'Error',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'faculty': instance.faculty,
    };

Faculty _$FacultyFromJson(Map<String, dynamic> json) => Faculty(
      name: json['name'] as String? ?? 'Error',
      shortname: json['shortname'] as String? ?? 'Error',
      icon: json['icon'] as int? ?? 0xe237,
      color: json['color'] as String? ?? '#ff1e1e',
      id: json['id'] as String? ?? '',
      scores: (json['scores'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as int),
          ) ??
          const {},
      scoresEnabled: json['scoresEnabled'] as bool? ?? true,
      game: json['game'] as String? ?? 'Disziplin der Fakultät',
    );

Map<String, dynamic> _$FacultyToJson(Faculty instance) => <String, dynamic>{
      'name': instance.name,
      'shortname': instance.shortname,
      'icon': instance.icon,
      'color': instance.color,
      'id': instance.id,
      'game': instance.game,
      'scoresEnabled': instance.scoresEnabled,
      'scores': instance.scores,
    };

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      name: json['name'] as String? ?? 'Error',
      id: json['id'] as String? ?? '',
      faculty: json['faculty'] as String? ?? 'error',
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'faculty': instance.faculty,
    };
