import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/auth/domain/usecases/get_token.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';
import 'package:tanitama/features/community/domain/usecases/get_posts_by_user.dart';

part 'user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  UserPostsCubit({
    required this.getPostsByUser,
  }) : super(UserPostsInitial());

  final GetPostsByUser getPostsByUser;

  void fetchAllPostsByUser() async {
    emit(UserPostsLoading());

    final result = await getPostsByUser.execute();

    result.fold(
      (failure) => emit(UserPostsError(failure.message)),
      (data) => emit(UserPostsSuccess(data)),
    );
  }
}
