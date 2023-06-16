part of 'create_comment_cubit.dart';

abstract class CreateCommentState extends Equatable {
  const CreateCommentState();

  @override
  List<Object> get props => [];
}

class CreateCommentInitial extends CreateCommentState {}

class CreateCommentLoading extends CreateCommentState {}

class CreateCommentError extends CreateCommentState {
  final String message;

  const CreateCommentError(this.message);

  @override
  List<Object> get props => [message];
}

class CreateCommentSuccess extends CreateCommentState {
  final String message;

  const CreateCommentSuccess(this.message);

  @override
  List<Object> get props => [message];
}
