import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';
import 'package:tanitama/features/community/domain/usecases/get_all_posts.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit({
    required this.getAllPosts,
  }) : super(CommunityInitial());

  final GetAllPosts getAllPosts;

  void fetchAllPosts() async {
    emit(PostsLoading());

    final result = await getAllPosts.execute();

    result.fold(
      (failure) => emit(PostsError(failure.message)),
      (data) => emit(PostsSuccess(data)),
    );
  }
}
