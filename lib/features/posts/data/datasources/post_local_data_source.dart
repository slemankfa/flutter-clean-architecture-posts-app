import 'dart:convert';

import 'package:clean_arch_posts_app/core/error/exceptions.dart';
import 'package:clean_arch_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPost();
  Future<Unit> cachPosts(List<PostModel> postModels);
}

const CACHED_POSTS = "CACHED_POSTS";

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachPosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPost() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeToJson = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeToJson
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCashExceptions();
    }
  }
}
