import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/post_repo.dart';

class DeletePostUsecase {
  final PostRepository _repository;

  DeletePostUsecase(this._repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await _repository.deletePost(postId);
  }
}
