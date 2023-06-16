part of 'create_post_cubit.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object> get props => [];
}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostError extends CreatePostState {
  final String message;

  const CreatePostError(this.message);

  @override
  List<Object> get props => [message];
}

class CreatePostSuccess extends CreatePostState {
  final String message;

  const CreatePostSuccess(this.message);

  @override
  List<Object> get props => [message];
}
