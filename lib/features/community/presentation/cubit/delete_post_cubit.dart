import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/community/domain/usecases/delete_post.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit({required this.deletePost}) : super(DeletePostInitial());

  final DeletePost deletePost;

  void removePost(int id) async {
    emit(DeletePostLoading());

    final result = await deletePost.execute(id);

    result.fold(
      (failure) => emit(DeletePostError(failure.message)),
      (data) => emit(DeletePostSuccess(data)),
    );
  }
}
