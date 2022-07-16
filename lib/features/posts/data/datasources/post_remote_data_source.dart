import 'dart:convert';

import 'package:clean_arch_posts_app/core/error/exceptions.dart';
import 'package:clean_arch_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> deletePost(int postId);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final respone = await client.get(
      Uri.parse("$BASE_URL/posts/"),
      headers: {"Content-Type": "application/json"},
    );
    if (respone.statusCode == 200) {
      final List decodeJson = json.decode(respone.body) as List;
      final List<PostModel> postModels = decodeJson
          .map<PostModel>((jsonPost) => PostModel.fromJson(jsonPost))
          .toList();
      return postModels;
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response =
        await client.post(Uri.parse("$BASE_URL/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final respone = await client.delete(
      Uri.parse("$BASE_URL/posts/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (respone.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "body": postModel.body,
      "title": postModel.title,
    };

    final response = await client.patch(Uri.parse("$BASE_URL/posts/$postId"));
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExceptions();
    }
  }
}
