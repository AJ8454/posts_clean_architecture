import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';

// Dartz funcional Programming => Either <left , right>
// left is Failure , right is success
// Unit is return type 'Nothing' => LIKE VOID

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();

  Future<Either<Failure, Unit>> deletePost(int id);

  Future<Either<Failure, Unit>> updatePost(Post post);

  Future<Either<Failure, Unit>> addPost(Post post);
}
