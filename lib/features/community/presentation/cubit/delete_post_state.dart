part of 'delete_post_cubit.dart';

abstract class DeletePostState extends Equatable {
  const DeletePostState();

  @override
  List<Object> get props => [];
}

class DeletePostInitial extends DeletePostState {}

class DeletePostLoading extends DeletePostState {}

class DeletePostError extends DeletePostState {
  final String message;

  const DeletePostError(this.message);

  @override
  List<Object> get props => [message];
}

class DeletePostSuccess extends DeletePostState {
  final String message;

  const DeletePostSuccess(this.message);

  @override
  List<Object> get props => [message];
}
