import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> postModel);
}

const cachePostKey = "CACHED_POSTS";

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreference;

  PostLocalDataSourceImpl({required this.sharedPreference});

  @override
  Future<Unit> cachePosts(List<PostModel> postModel) async {
    List postModelsToJson =
        postModel.map<Map<String, dynamic>>((posts) => posts.toJson()).toList();
    await sharedPreference.setString(
        cachePostKey, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreference.getString(cachePostKey);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModel = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
