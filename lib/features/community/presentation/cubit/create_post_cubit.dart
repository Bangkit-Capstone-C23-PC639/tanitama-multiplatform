import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/community/domain/usecases/create_post.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit({required this.createPost}) : super(CreatePostInitial());

  final CreatePost createPost;

  void addPost(String title, String content, File image) async {
    emit(CreatePostLoading());

    final result = await createPost.execute(title, content, image);

    result.fold(
      (failure) => emit(CreatePostError(failure.message)),
      (data) => emit(CreatePostSuccess(data)),
    );
  }
}
