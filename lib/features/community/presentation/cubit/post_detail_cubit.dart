import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/auth/domain/usecases/get_token.dart';
import 'package:tanitama/features/community/domain/usecases/get_post_by_id.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';

part 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit({
    required this.getPostById,
    required this.getToken,
  }) : super(PostDetailInitial());

  final GetPostById getPostById;
  final GetToken getToken;

  void fetchPostById(int id) async {
    emit(PostDetailLoading());

    final result = await getPostById.execute(id);
    final auth = await getToken.execute();

    result.fold((failure) => emit(PostDetailError(failure.message)), (data) {
      emit(PostDetailSuccess(data, auth!.userId.toString()));
    });
  }
}
