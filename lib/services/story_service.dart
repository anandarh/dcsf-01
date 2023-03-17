import 'dart:convert';
import 'package:storyapp/models/story_response.dart';
import 'package:storyapp/services/token_service.dart';
import 'package:storyapp/utils/api.dart';

class StoryService {
  static Future<StoryResponse> allStories() async {
    String token = await TokenService.getToken() ?? '';
    final response = await Api.get('stories', token);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return StoryResponse.fromJson(data);
    } else {
      throw Exception(data['message']);
    }
  }
}
