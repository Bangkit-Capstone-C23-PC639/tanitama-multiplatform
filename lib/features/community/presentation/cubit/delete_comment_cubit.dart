import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/community/domain/usecases/delete_comment.dart';

part 'delete_comment_state.dart';

class DeleteCommentCubit extends Cubit<DeleteCommentState> {
  DeleteCommentCubit({required this.deleteComment})
      : super(DeleteCommentInitial());

  final DeleteComment deleteComment;

  void removeComment(int id) async {
    emit(DeleteCommentLoading());

    final result = await deleteComment.execute(id);

    result.fold(
      (failure) => emit(DeleteCommentError(failure.message)),
      (data) => emit(DeleteCommentSuccess(data)),
    );
  }
}
