import 'package:dartz/dartz.dart';

import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/features/posts/data/datasources/post_local_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/datasources/post_remote_data_scource.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/post_repo.dart';

class PostsRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;

  PostsRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    await remoteDataSource.getAllPosts();
    await localDataSource.getCachedPosts();

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
