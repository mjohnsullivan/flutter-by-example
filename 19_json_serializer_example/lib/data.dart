// To build, use: flutter pub pub run build_runner build

import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable(nullable: false)
class Story extends Object with _$StorySerializerMixin {
  final String title;
  final String url;
  Story({this.title, this.url});
  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

/// List is just a list of ints, so json_serializable is overkill
parseStoryIds(List<dynamic> storyIds) =>
    storyIds.map(((i) => i as int)).toList();
