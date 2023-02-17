import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/post_repo.dart';

class AddPostUsecase {
  final PostRepository _repository;

  AddPostUsecase(this._repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await _repository.addPost(post);
  }
}
