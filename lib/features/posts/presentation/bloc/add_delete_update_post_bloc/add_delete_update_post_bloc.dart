import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/core/strings/failures_string.dart';
import 'package:posts_clean_architecture/core/strings/messages.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/update_post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUsecase addPostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final UpdatePostUsecase updatePostUsecase;

  AddDeleteUpdatePostBloc({
    required this.addPostUsecase,
    required this.deletePostUsecase,
    required this.updatePostUsecase,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPostUsecase(event.post);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, addSuccessMessage));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePostUsecase(event.post);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, updateSuccessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePostUsecase(event.postId);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, deleteSuccessMessage));
      }
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
    Either<Failure, Unit> either,
    String message,
  ) {
    return either.fold(
      (failure) =>
          ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure)),
      (r) => MessageAddDeleteUpdatePostState(message: message),
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
