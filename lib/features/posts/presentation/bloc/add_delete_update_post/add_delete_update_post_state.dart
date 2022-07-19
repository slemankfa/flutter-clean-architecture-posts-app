part of 'add_delete_update_post_bloc.dart';

abstract class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

class LoadingAddDeleteUpdatePost extends AddDeleteUpdatePostState {}

class ErrorAddDeleteUpdatePost extends AddDeleteUpdatePostState {
  final String message;

  ErrorAddDeleteUpdatePost({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdatePost extends AddDeleteUpdatePostState {
  final String message;

  MessageAddDeleteUpdatePost({required this.message});

  @override
  List<Object> get props => [message];
}
