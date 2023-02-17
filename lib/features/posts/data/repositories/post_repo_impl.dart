import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/exception.dart';

import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/core/network/network_info.dart';
import 'package:posts_clean_architecture/features/posts/data/datasources/post_local_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/datasources/post_remote_data_scource.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/post_repo.dart';

class PostsRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addPost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deletePost(postId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updatePost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
