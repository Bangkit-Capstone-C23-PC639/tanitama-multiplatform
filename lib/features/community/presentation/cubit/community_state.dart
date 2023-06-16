part of 'community_cubit.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

class CommunityInitial extends CommunityState {}

class PostsLoading extends CommunityState {}

class PostsError extends CommunityState {
  final String message;

  const PostsError(this.message);

  @override
  List<Object> get props => [message];
}

class PostsSuccess extends CommunityState {
  final List<PostEntity> posts;

  const PostsSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}
