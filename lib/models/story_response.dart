import 'package:storyapp/models/story.dart';

class StoryResponse {
  final bool error;
  final String message;
  final List<Story>? listStory;

  StoryResponse({
    required this.error,
    required this.message,
    this.listStory,
  });

  factory StoryResponse.fromJson(Map<String, dynamic> json) {
    return StoryResponse(
      error: json['error'],
      message: json['message'],
      listStory: json['listStory'] != null
          ? List<Story>.from(json['listStory'].map((x) => Story.fromJson(x)))
          : null,
    );
  }
}
