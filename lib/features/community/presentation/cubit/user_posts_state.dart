part of 'user_posts_cubit.dart';

abstract class UserPostsState extends Equatable {
  const UserPostsState();

  @override
  List<Object> get props => [];
}

class UserPostsInitial extends UserPostsState {}

class UserPostsLoading extends UserPostsState {}

class UserPostsError extends UserPostsState {
  final String message;

  const UserPostsError(this.message);

  @override
  List<Object> get props => [message];
}

class UserPostsSuccess extends UserPostsState {
  final List<PostEntity> posts;

  const UserPostsSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}
