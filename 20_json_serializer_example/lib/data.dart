// To build, use: flutter pub pub run build_runner build

import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Story extends Object with _$StorySerializerMixin {
  final String title;
  final String url;
  final String text;
  @JsonKey(includeIfNull: false)
  final int score;
  @JsonKey(includeIfNull: false)
  final List<int> parts;

  Story({this.title, this.url, this.text, this.score, this.parts});
  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

/// List is just a list of ints, so json_serializable is overkill
parseStoryIds(List<dynamic> storyIds) =>
    storyIds.map(((i) => i as int)).toList();
