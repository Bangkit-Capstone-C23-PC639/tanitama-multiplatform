part of 'post_detail_cubit.dart';

abstract class PostDetailState extends Equatable {
  const PostDetailState();

  @override
  List<Object> get props => [];
}

class PostDetailInitial extends PostDetailState {}

class PostDetailLoading extends PostDetailState {}

class PostDetail extends PostDetailState {}

class PostDetailError extends PostDetailState {
  final String message;

  const PostDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class PostDetailSuccess extends PostDetailState {
  final PostEntity post;
  final String userId;

  const PostDetailSuccess(this.post, this.userId);

  @override
  List<Object> get props => [post, userId];
}
