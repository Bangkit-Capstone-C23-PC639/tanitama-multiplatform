import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/community/domain/usecases/get_post_by_id.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';

part 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit({required this.getPostById}) : super(PostDetailInitial());

  final GetPostById getPostById;

  void fetchPostById(int id) async {
    emit(PostDetailLoading());

    final result = await getPostById.execute(id);

    result.fold(
      (failure) => emit(PostDetailError(failure.message)),
      (data) => emit(PostDetailSuccess(data)),
    );
  }
}
