import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failuers.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostsUseCase addPost;
  final UpdatePostsUseCase updatePosts;
  final DeletePostsUseCase deletePosts;

  AddDeleteUpdatePostBloc(
      {required this.addPost,
      required this.deletePosts,
      required this.updatePosts})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePost());

        final failuerOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrErrorMessage(
            failuerOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePost());

        final failuerOrDoneMessage = await updatePosts(event.post);
        emit(_eitherDoneMessageOrErrorMessage(
            failuerOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePost());

        final failuerOrDoneMessage = await deletePosts(event.postId);
        emit(_eitherDoneMessageOrErrorMessage(
            failuerOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorMessage(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failuer) => ErrorAddDeleteUpdatePost(
        message: _mapFailureToMessage(failuer),
      ),
      (_) => MessageAddDeleteUpdatePost(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case EmptyCashFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
