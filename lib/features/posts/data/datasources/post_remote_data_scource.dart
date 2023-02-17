import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/exception.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> addPost(PostModel postModel);

  Future<Unit> deletePost(int postId);

  Future<Unit> updatePost(PostModel postModel);
}

const baseUrl = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl(this.client);

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse("$baseUrl/posts/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {"title": postModel.title, "body": postModel.body};

    final response =
        await client.post(Uri.parse("$baseUrl/posts/"), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse("$baseUrl/posts/$postId"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {"title": postModel.title, "body": postModel.body};

    final response =
        await client.patch(Uri.parse("$baseUrl/posts/$postId"), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
