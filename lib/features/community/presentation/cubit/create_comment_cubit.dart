import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/community/domain/usecases/create_comment.dart';

part 'create_comment_state.dart';

class CreateCommentCubit extends Cubit<CreateCommentState> {
  CreateCommentCubit({required this.createComment})
      : super(CreateCommentInitial());

  final CreateComment createComment;

  void postComment(int id, String content) async {
    emit(CreateCommentLoading());

    final result = await createComment.execute(id, content);

    result.fold(
      (failure) => emit(CreateCommentError(failure.message)),
      (data) => emit(CreateCommentSuccess(data)),
    );
  }
}
