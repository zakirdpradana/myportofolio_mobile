import 'package:json_annotation/json_annotation.dart';
part 'experience.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.thumbnail = '',
    this.startedAt,
    this.endedAt,
    this.isOngoing = true,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;
  final String category;

  @JsonKey(defaultValue: '')
  final String thumbnail;

  @JsonKey(includeToJson: false)
  final DateTime? startedAt;

  final DateTime? endedAt;

  @JsonKey(includeToJson: false, defaultValue: true)
  final bool isOngoing;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}