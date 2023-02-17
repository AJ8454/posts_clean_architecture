import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/post_repo.dart';

class GetAllPostsUsecase {
  final PostRepository _repository;

  GetAllPostsUsecase(this._repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await _repository.getAllPosts();
  }
}
