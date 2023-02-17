import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/core/strings/failures_string.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPostsUsecase;

  PostsBloc({required this.getAllPostsUsecase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUsecase();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUsecase();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return "Unexpected Error. Please try again later.";
    }
  }
}
