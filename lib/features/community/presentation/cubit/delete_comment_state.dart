part of 'delete_comment_cubit.dart';

abstract class DeleteCommentState extends Equatable {
  const DeleteCommentState();

  @override
  List<Object> get props => [];
}

class DeleteCommentInitial extends DeleteCommentState {}

class DeleteCommentLoading extends DeleteCommentState {}

class DeleteCommentError extends DeleteCommentState {
  final String message;

  const DeleteCommentError(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteCommentSuccess extends DeleteCommentState {
  final String message;

  const DeleteCommentSuccess(this.message);

  @override
  List<Object> get props => [message];
}
